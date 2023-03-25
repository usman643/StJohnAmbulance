//
//  CreateEventFormVC.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 3/6/23.
//

import UIKit
import Parchment

protocol CreateEventSegmentDelegate {
    func onPressNext(params:[String:Any], controller:UIViewController)
    func onPressSubmit(params:[String:Any])
}

class CreateEventFormVC: ENTALDBaseViewController, UIScrollViewDelegate {
    
    @IBOutlet var containerView: UIView!
    
    var pageController = PagingViewController(viewControllers: [])
    var viewControllers: [UIViewController] = []
    
    var slides:[Any] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        pageController.menuInteraction = .none
        pageController.contentInteraction = .none
        
        pageController.delegate = self
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
        genForm.delegate = self
        detailInfo.title = "Detail"
        detailInfo.delegate = self
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

    
}

extension CreateEventFormVC: PagingViewControllerDataSource, PagingViewControllerDelegate, CreateEventSegmentDelegate {

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
    
    func pagingViewController(_ pagingViewController: PagingViewController, didScrollToItem pagingItem: PagingItem, startingViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
        if let vc = startingViewController as? GeneralInfoFormVC, transitionSuccessful {
            self.passParamsToDetailInfo(params: vc.getGeneralFieldsParam(), controller: vc)
        }
    }
    
    func onPressNext(params: [String : Any], controller: UIViewController) {
        self.pageController.select(index: 1, animated: true)
        self.passParamsToDetailInfo(params: params, controller: controller)
    }
    
    func passParamsToDetailInfo(params: [String : Any], controller: UIViewController){
        if let _ = controller as? GeneralInfoFormVC {
            if let detailVc = self.viewControllers[1] as? EventDetailInfoFormVC {
                detailVc.setGenInfoParams(params: params)
            }
        }
    }
    
    func onPressSubmit(params: [String : Any]) {
        DispatchQueue.main.async {
            LoadingView.show()
        }
        ENTALDLibraryAPI.shared.createEventRequest(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success:
                break
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in
                        self.navigationController?.popViewController(animated: true)
                    })
                }
            }
        }
    }
    
}
