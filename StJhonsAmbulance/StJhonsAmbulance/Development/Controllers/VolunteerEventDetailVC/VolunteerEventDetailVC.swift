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
    var participationData : [VolunteerEventParticipationCheckModel]?
    var userParticipantData : VolunteerEventParticipationCheckModel?
    let contactId = UserDefaults.standard.contactIdToken ?? ""
    var isUserParticipate = false
    var slides:[Any] = []
    var eventType :String?
    var eventId = ""
    let currentDateTime = Date()
    var isBottombtnEnable = false
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var lblEventLocation: UILabel!
    
    @IBOutlet weak var btnCloseEvent: UIButton!
    
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var closeImg: UIImageView!
    
    @IBOutlet weak var btnCancelApprovedShift: UIButton!
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
        self.getEventParitionCheck()
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
        closeImg.isHidden = true
        
        btnCloseEvent.isHidden = true
        self.btnCancelApprovedShift.isHidden = true
        
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
        if DateFormatManager.shared.formatDate(date: Date()) <= self.scheduleData?.sjavms_end ?? ""{
            isBottombtnEnable = true
        }else{
            isBottombtnEnable = false
        }
        
//        if self.scheduleData?.msnfp_schedulestatus == 335940003 {
//            self.lblDesc.text = "Cancelled"
//            self.closeImg.isHidden = false
//            self.btnCloseEvent.isHidden = true
//        }
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
        if DateFormatManager.shared.formatDate(date: Date()) < self.availableData?.msnfp_endingdate ?? ""{
            isBottombtnEnable = true
        }else{
            isBottombtnEnable = false
        }
        
//        if self.availableData?.msnfp_engagementopportunitystatus == 335940003 {
//            self.lblDesc.text = "Cancelled"
//            self.closeImg.isHidden = false
//            self.btnCloseEvent.isHidden = true
//        }
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
        let shiftVC = ShiftOptionVC.loadFromNib()
        let detailVC = VEventDetailVC.loadFromNib()
        shiftVC.title = "Schedule"
        shiftVC.isBottombtnEnable = self.isBottombtnEnable
        shiftVC.eventId = self.eventId
        shiftVC.userParticipantData = self.userParticipantData
        viewControllers.append(shiftVC)
        
        detailVC.title = "Detail"
        detailVC.eventId = self.eventId
        detailVC.userParticipantData = self.userParticipantData
        viewControllers.append(detailVC)
        
        var option : PagingOptions = PagingOptions()
        option.borderColor = UIColor.separator
        option.borderOptions = .visible(height: 0.5, zIndex: 0, insets: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        
        self.pageController = PagingViewController(options: option, viewControllers: viewControllers)
        
        self.segmentsConfigurations()
    }
    
    func getEventParitionCheck() {
        
        let params : [String:Any] = [
            ParameterKeys.filter : "(_msnfp_engagementopportunityid_value eq \(self.eventId) and statecode eq 0)"
        ]
        
        self.getEventParitionCheckData(params: params)
        
    }
    
    @IBAction func closeApproveShift(_ sender: Any) {
        
        if isUserParticipate == true{
            
        }else{
            self.applyShift()
        }
        
    }
    
    @IBAction func closeEvent(_ sender: Any) {
    }
    
    fileprivate func getEventParitionCheckData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getEventParticipationCheck(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let option = response.value {
                    self.participationData = option
                    let modelData = self.participationData?.filter({$0._msnfp_contactid_value == self.contactId}).first
                    self.userParticipantData = modelData
                    DispatchQueue.main.async {
                        if modelData != nil {
                            self.isUserParticipate = true
                            if ((DateFormatManager.shared.formatDate(date: Date()) <= self.availableData?.msnfp_endingdate ?? "" || DateFormatManager.shared.formatDate(date: Date()) <= self.self.scheduleData?.sjavms_end ?? "" ) ){
                                
                                if (modelData?.statuscode == 844060000 || modelData?.statuscode ==  844060001  || modelData?.statuscode == 844060004) {
                                    self.lblDesc.text = "In Review"
                                    self.closeImg.image = UIImage(named: "stopwatch")
                                    //                                xmark.circle.fill  for close
                                }else if (modelData?.statuscode == 844060002 ){
                                    
                                    self.lblDesc.text = "Registerd to Attend"
                                    self.closeImg.image = UIImage(named: "checkmark.circle.fill")
                                    self.btnCancelApprovedShift.isHidden = false
                                }
   
                            }
                        }else{
                            self.lblDesc.text = "Apply for event"
                            self.closeImg.image = UIImage(named: "checkmark.circle.fill")
                            self.btnCancelApprovedShift.setTitle("Apply", for: .normal)
                            self.btnCancelApprovedShift.isHidden = false
                        }
                            if (DateFormatManager.shared.formatDate(date: Date()) > self.availableData?.msnfp_endingdate ?? "" && self.isUserParticipate == false){
                                self.lblDesc.text = "Missed"
                                self.closeImg.isHidden = false
                                self.closeImg.image = UIImage(named: "xmark.circle.fill")
                                self.btnCloseEvent.isHidden = true
                                
                            }else if (DateFormatManager.shared.formatDate(date: Date()) > self.self.scheduleData?.sjavms_end ?? "" && self.isUserParticipate == false){
                                
                                self.lblDesc.text = "Missed"
                                self.closeImg.isHidden = false
                                self.closeImg.image = UIImage(named: "xmark.circle.fill")
                                self.btnCloseEvent.isHidden = true
                                
                            }else{
                                
                                self.closeImg.isHidden = true
                                self.lblDesc.text = ""
                            }
                    }
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
    
    func applyShift(){
        
        let participationId = self.userParticipantData?.msnfp_participationid ?? ""
        let params = [
            "[msnfp_engagementOpportunityId@odata.bind]" : "/msnfp_engagementopportunities(\(self.eventId))" as String,
            "[msnfp_contactId@odata.bind]" : "/contacts(\(self.contactId))" as String
        ] as [String : Any]
        
        self.applyforShift(params: params)
    }
    
    func applyforShift(params: [String : Any]) {
        DispatchQueue.main.async {
            LoadingView.show()
        }
        ENTALDLibraryAPI.shared.applyforShift(params: params){ result in
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
                        
                    })
                }
            }
        }
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


