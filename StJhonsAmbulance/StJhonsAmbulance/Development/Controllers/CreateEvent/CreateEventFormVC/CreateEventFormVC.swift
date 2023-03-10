//
//  CreateEventFormVC.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 3/6/23.
//

import UIKit
import Parchment

class CreateEventFormVC: ENTALDBaseViewController, UIScrollViewDelegate {
    
    @IBOutlet var containerView: UIView!
    
    var pageController = PagingViewController(viewControllers: [])
    var viewControllers: [UIViewController] = []
    
    var slides:[Any] = []
    var programData : [EventProgramDataModel]?
    var branchData : [EventBranchModel]?
    var councilData : [EventCouncilModel]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.getEventProgram()
//        self.getEventBranch()
//        self.getEventCouncil()
        // Do any additional setup after loading the view.

        self.reloadControllers()
    }
    
    func segmentsConfigurations(){
        self.addPagerControllerAsChildView()
        pageController.dataSource = self
        pageController.menuHorizontalAlignment = .center
        pageController.menuItemSize = .sizeToFit(minWidth: 80, height: 40)
        pageController.menuBackgroundColor = .systemGray5
        pageController.indicatorColor = UIColor.themePrimary
        pageController.indicatorOptions = .visible(height: 3, zIndex: 0, spacing: .zero, insets: .zero)
        let font:UIFont = UIFont.boldSystemFont(ofSize: 14)
        pageController.font = font
        pageController.selectedFont = font
        
        pageController.textColor = .black
        pageController.selectedTextColor = .themeSecondry
        pageController.collectionView.bounces = false
    }
    
    func addPagerControllerAsChildView(){
        DispatchQueue.main.async {
            self.addChild(self.pageController)
            self.containerView.addSubview(self.pageController.view)
            self.containerView.constrainToEdges(self.pageController.view)
            self.pageController.didMove(toParent: self)
        }
    }
    
    
    func reloadControllers(){
        self.pageController = PagingViewController(viewControllers: [])
        let genForm = GeneralInfoFormVC.loadFromNib()
        let detailInfo = EventDetailInfoFormVC.loadFromNib()
        genForm.title = "GenInfo"
        detailInfo.title = "Detail"
        viewControllers.append(genForm)
        viewControllers.append(detailInfo)
        
        var option : PagingOptions = PagingOptions()
        option.borderColor = UIColor.separator
        option.borderOptions = .visible(height: 0.5, zIndex: 0, insets: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        
        self.pageController = PagingViewController(options: option, viewControllers: viewControllers)
        
        self.segmentsConfigurations()
    }

    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    // ========================== API =========================
    
    fileprivate func getEventProgram(){
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "sjavms_Program",
            ParameterKeys.expand : "sjavms_Program($select=sjavms_name)",
            ParameterKeys.filter : "(msnfp_groupid eq \(groupId)) and (sjavms_Program/sjavms_programid ne null) and (sjavms_Branch/sjavms_branchid ne null)",
//            ParameterKeys.orderby : "msnfp_engagementopportunityschedule asc"
        ]

        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestEventPrograme(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let programData = response.value {
                    self.programData = programData
    
                }
            
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    
    
    fileprivate func getEventBranch(){

        let params : [String:Any] = [
            
            ParameterKeys.select : "sjavms_name,_sjavms_council_value",
            
        ]

        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestEventBranch(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let branchData = response.value {
                    self.branchData = branchData
    
                }
            
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    fileprivate func getEventCouncil(){

        let params : [String:Any] = [
            
            ParameterKeys.select : "sjavms_name",
            
        ]

        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestEventCouncil(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let councilData = response.value {
                    self.councilData = councilData
    
                }
            
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    
}

extension CreateEventFormVC: PagingViewControllerDataSource {

    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        let title = viewControllers[index].title ?? ""
        return PagingIndexItem(index: index, title: title)
    }

    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        return viewControllers[index]
//        return ContentViewController(title: viewControllers[index].title ?? "test")
    }

    func numberOfViewControllers(in _: PagingViewController) -> Int {
        return viewControllers.count
    }
    
    
}
