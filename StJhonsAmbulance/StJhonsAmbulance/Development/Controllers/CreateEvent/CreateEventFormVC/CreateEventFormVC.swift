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
        self.slides = self.createSlides()
        self.getEventProgram()
        self.getEventBranch()
        self.getEventCouncil()
        // Do any additional setup after loading the view.
        
    }
    
    
//    func reloadControllers(){
//        self.pageController = PagingViewController(viewControllers: [])
//        let genForm = GeneralInfoFormVC.load
//        viewControllers.append(<#T##newElement: UIViewController##UIViewController#>)
//        
//        var option : PagingOptions = PagingOptions()
//        option.borderColor = UIColor.separator
//        option.borderOptions = .visible(height: 0.5, zIndex: 0, insets: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
//        
//        self.pageController = PagingViewController(options: option, viewControllers: viewControllers)
//        
//        self.segmentsConfigurations()
//    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func createSlides() -> [Any] {
//
        let slide1 : GeneralInfoFormVC = Bundle.main.loadNibNamed("GeneralInfoFormVC", owner: self, options: nil)?.first as! GeneralInfoFormVC
        
        let slide2 : EventDetailInfoFormVC = Bundle.main.loadNibNamed("EventDetailInfoFormVC", owner: self, options: nil)?.first as! EventDetailInfoFormVC
        
        return [slide1, slide2]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    
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


extension UIScrollView {
    func scrollTo(currentPage: Int? = 0) {
        let screenWidth = UIScreen.main.bounds.width
        var frame: CGRect = self.frame
        frame.origin.x = screenWidth * CGFloat(currentPage ?? 0)
        self.scrollRectToVisible(frame, animated: true)
    }
}
