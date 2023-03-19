//
//  VolunteerEventDetailVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 19/03/2023.
//

import UIKit
import Parchment

class VolunteerEventDetailVC: ENTALDBaseViewController, UIScrollViewDelegate {
    
    
    
    var pageController = PagingViewController(viewControllers: [])
    var viewControllers: [UIViewController] = []
    var availableData : AvailableEventModel?
    var scheduleData : ScheduleModelThree?
    var slides:[Any] = []
    var eventType :String?
    var eventId = ""
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var lblEventLocation: UILabel!
    
    @IBOutlet weak var btnCloseEvent: UIButton!
    
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.decorateUI()
        
        if eventType == "schedule"{
            scheduleData = dataModel as? ScheduleModelThree
            self.setupScheduleScreenData()
            
            
        }else if eventType == "available"{
            availableData = dataModel as? AvailableEventModel
            self.setupAvailiableScreenData()
        }

        self.reloadControllers()
    }
    
    func decorateUI(){
        btnCloseEvent.layer.cornerRadius = btnCloseEvent.frame.size.height/2
        headerView.backgroundColor = UIColor.themePrimaryColor
        lblEventName.textColor = UIColor.textWhiteColor
        lblEventDate.textColor = UIColor.textWhiteColor
        lblEventLocation.textColor = UIColor.textWhiteColor
        lblDesc.textColor = UIColor.themePrimary
        
        lblEventName.font = UIFont.BoldFont(16)
        lblEventDate.font = UIFont.BoldFont(14)
        lblEventLocation.font = UIFont.BoldFont(14)
        lblDesc.font = UIFont.BoldFont(14)
        
        
        
        
    }
    
    func setupScheduleScreenData(){
        lblEventName.text = self.scheduleData?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
        lblEventLocation.text = self.scheduleData?.sjavms_VolunteerEvent?.msnfp_location ?? ""
        
        if let date = self.scheduleData?.sjavms_start {
            
            let dateStr = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
            self.lblEventDate.text = dateStr
        }else{
            self.lblEventDate.text = ""
        }
        self.eventId = self.scheduleData?.sjavms_VolunteerEvent?.msnfp_engagementopportunityid ?? ""
        
    }
    
    func setupAvailiableScreenData(){
        
        lblEventName.text = self.availableData?.msnfp_engagementopportunitytitle ?? ""
        lblEventLocation.text = self.availableData?.msnfp_location ?? ""
        
        if let date = self.availableData?.msnfp_startingdate {
            
            let dateStr = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
            self.lblEventDate.text = dateStr
        }else{
            self.lblEventDate.text = ""
        }
        
        self.eventId = self.availableData?.msnfp_engagementopportunityid ?? ""
        
    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func homeTapped(_ sender: Any) {
        
    }
    
    @IBAction func closeEventTapped(_ sender: Any) {
        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
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
        let genForm = ShiftOptionVC.loadFromNib()
        let detailInfo = VEventDetailVC.loadFromNib()
        genForm.title = "Schedule"
        genForm.eventId = self.eventId
        viewControllers.append(genForm)
        
        detailInfo.title = "Detail"
        detailInfo.eventId = self.eventId
        viewControllers.append(detailInfo)
        
        var option : PagingOptions = PagingOptions()
        option.borderColor = UIColor.separator
        option.borderOptions = .visible(height: 0.5, zIndex: 0, insets: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        
        self.pageController = PagingViewController(options: option, viewControllers: viewControllers)
        
        self.segmentsConfigurations()
    }

    
}

extension VolunteerEventDetailVC: PagingViewControllerDataSource {

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


