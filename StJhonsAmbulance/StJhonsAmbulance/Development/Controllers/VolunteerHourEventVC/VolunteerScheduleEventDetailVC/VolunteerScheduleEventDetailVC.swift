//
//  VolunteerScheduleEventDetailVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 12/11/2023.
//

import UIKit
import Parchment

class VolunteerScheduleEventDetailVC: ENTALDBaseViewController, UIScrollViewDelegate {

    var pageController = PagingViewController(viewControllers: [])
    var viewControllers: [UIViewController] = []
    var availableData : AvailableEventModel?
    var scheduleData : ScheduleModelThree?
    var scheduleEngagementData : ScheduleEngagementModel?
    var scheduleCalenderData : ScheduleModelThree?
    var tabDetailData : [VolunteerEventClickShiftDetailModel]?
    var participationData : [VolunteerEventParticipationCheckModel]?
    var userParticipantData : VolunteerEventParticipationCheckModel?
    let contactId = UserDefaults.standard.contactIdToken ?? ""
    var isUserParticipate = false
    var slides:[Any] = []
    var eventType :String?
    var eventId = ""
    var oppId = ""
    let currentDateTime = Date()
    var isBottombtnEnable = false
    var isApplyNowShow = false
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblProgramName: UILabel!
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
            self.eventId = self.scheduleData?.sjavms_VolunteerEvent?.msnfp_engagementopportunityid ?? ""
            self.lblProgramName.text = self.scheduleData?.sjavms_VolunteerEvent?.program ?? ""
            //            self.setupScheduleScreenData()
            //            self.setupAvailiableScreenData()
        }else if eventType == "engagement"{
            scheduleEngagementData = dataModel as? ScheduleEngagementModel
            self.eventId = self.scheduleEngagementData?.VolunteeringEventId ?? ""
            self.oppId = self.scheduleEngagementData?.OppId ?? ""
            
            self.lblProgramName.text = self.scheduleEngagementData?.Program ?? ""
            
//            scheduleEngagementData = dataModel as? ScheduleEngagementModel
//            self.eventId = self.scheduleEngagementData?.VolunteeringEventId ?? ""
//            self.oppId = self.scheduleEngagementData?.OppId ?? ""
//            self.lblProgramName.text = self.scheduleEngagementData?.Program ?? ""
//            self.lblEventLocation.text = self.scheduleEngagementData?.LocationTypeName ?? ""
//            self.lblEventDate.text =  " \(self.scheduleEngagementData?.StartDate ?? "") - \(self.scheduleEngagementData?.StartDate ?? "") "
//            
        }else if eventType == "calender"{
            scheduleCalenderData = dataModel as? ScheduleModelThree
            self.eventId = self.scheduleCalenderData?.sjavms_VolunteerEvent?.msnfp_engagementopportunityid ?? ""
            self.oppId = self.scheduleCalenderData?.sjavms_VolunteerEvent?.msnfp_engagementopportunityid ?? ""
            self.lblProgramName.text = self.scheduleCalenderData?.sjavms_VolunteerEvent?.program ?? ""
        }
        
//        self.setupData()
        self.getEventTabDetail()
        self.getEventParitionCheck()
        self.reloadControllers()
    }
    
    func decorateUI(){
        btnCloseEvent.layer.cornerRadius = btnCloseEvent.frame.size.height/2
        headerView.backgroundColor = UIColor.themePrimaryColor
        lblEventName.textColor = UIColor.textWhiteColor
        lblProgramName.textColor = UIColor.textWhiteColor
        lblEventDate.textColor = UIColor.textWhiteColor
        lblEventLocation.textColor = UIColor.textWhiteColor
        lblDesc.textColor = UIColor.themePrimaryWhite
        lblTitle.textColor = UIColor.headerGreen
        
        lblTitle.font = UIFont.HeaderBoldFont(18)
        lblEventName.font = UIFont.BoldFont(16)
        lblProgramName.font = UIFont.BoldFont(14)
        lblEventDate.font = UIFont.BoldFont(14)
        lblEventLocation.font = UIFont.BoldFont(14)
        lblDesc.font = UIFont.BoldFont(14)
        closeImg.isHidden = true
        
        btnCloseEvent.isHidden = true
        self.btnCancelApprovedShift.isHidden = true
        self.btnCancelApprovedShift.layer.cornerRadius = self.btnCancelApprovedShift.frame.size.height/2
        lblTitle.text = "Event Detail".localized
    }
    
    //    func setupScheduleScreenData(){
    //        lblEventName.text = self.scheduleData?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
    //        lblEventLocation.text = self.scheduleData?.sjavms_VolunteerEvent?.msnfp_location ?? ""
    //
    //        if let date = self.scheduleData?.sjavms_start {
    //
    //            let dateStr = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
    //            self.lblEventDate.text = dateStr
    //        }else{
    //            self.lblEventDate.text = ""
    //        }
    //        self.eventId = self.scheduleData?.sjavms_VolunteerEvent?.msnfp_engagementopportunityid ?? ""
    //        if DateFormatManager.shared.formatDate(date: Date()) < self.scheduleData?.sjavms_end ?? ""{
    //            isBottombtnEnable = true
    //        }else{
    //            isBottombtnEnable = false
    //        }
    //
    ////        if self.scheduleData?.msnfp_schedulestatus == 335940003 {
    ////            self.lblDesc.text = "Cancelled"
    ////            self.closeImg.isHidden = false
    ////            self.btnCloseEvent.isHidden = true
    ////        }
    //    }
    
    func setupData(){
        DispatchQueue.main.async {
            
            if (self.tabDetailData?[0].msnfp_engagementopportunitytitle != nil){
                
                self.lblEventName.text = self.tabDetailData?[0].msnfp_engagementopportunitytitle ?? ""
//                self.lblProgramName.text = self.tabDetailData?[0].msnfp_engagementopportunitytitle ?? ""
                if (self.eventType == "engagement"){
                    self.lblEventLocation.text = self.scheduleEngagementData?.LocationTypeName ?? ""
                }else{
                    self.lblEventLocation.text = self.tabDetailData?[0].msnfp_location ?? "..."
                }
               
                
                if let date = self.tabDetailData?[0].msnfp_startingdate {
                    
                    let dateStr = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
                    var enddateStr = ""
                    if let endDate = self.tabDetailData?[0].msnfp_endingdate {
                        
                        enddateStr = DateFormatManager.shared.formatDateStrToStr(date: endDate, oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
                    }
                    
                    
                    
                    self.lblEventDate.text = "\(dateStr)\n\(enddateStr)"
                }else{
                    self.lblEventDate.text = ""
                }
//                if (self.tabDetailData?[0].msnfp_shifts == true){
//                    let str  = self.lblEventDate.text
//                    self.lblEventDate.text = "\(str ?? "")\n Multi Shift"
//
//                }
            }
        }
              
        
        
//              if DateFormatManager.shared.formatDate(date: Date()) < self.scheduleData?.sjavms_end ?? ""{
//                  isBottombtnEnable = true
//              }else{
//                  isBottombtnEnable = false
//              }
      

        
        
        
        
    }

    
    //    func setupAvailiableScreenData(){
    //
    //        lblEventName.text = self.availableData?.msnfp_engagementopportunitytitle ?? ""
    //        lblEventLocation.text = self.availableData?.msnfp_location ?? ""
    //
    //        if let date = self.availableData?.msnfp_startingdate {
    //
    //            let dateStr = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
    //            self.lblEventDate.text = dateStr
    //        }else{
    //            self.lblEventDate.text = ""
    //        }
    //
    //        self.eventId = self.availableData?.msnfp_engagementopportunityid ?? ""
    //        if DateFormatManager.shared.formatDate(date: Date()) < self.availableData?.msnfp_endingdate ?? ""{
    //            isBottombtnEnable = true
    //        }else{
    //            isBottombtnEnable = false
    //        }
    //
    ////        if self.availableData?.msnfp_engagementopportunitystatus == 335940003 {
    ////            self.lblDesc.text = "Cancelled"
    ////            self.closeImg.isHidden = false
    ////            self.btnCloseEvent.isHidden = true
    ////        }
    //    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func messageTapped(_ sender: Any) {
        ENTALDControllers.shared.showGroupMessageVC(type: .ENTALDPUSH, from: self) { params, controller in
            
        }
    }
    
    @IBAction func closeEventTapped(_ sender: Any) {
        if isApplyNowShow == true{
            self.applyShift()
        }else{
            self.cancelRegisterToAttendEvent()
        }
        //        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
    }
    
    func segmentsConfigurations(){
        self.addPagerControllerAsChildView()
        pageController.dataSource = self
        pageController.menuHorizontalAlignment = .center
        pageController.menuItemLabelSpacing = 0
        pageController.menuItemSize = .sizeToFit(minWidth: 100, height: 40)
        pageController.menuBackgroundColor = UIColor.hexString(hex: "e6f2eb")
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
//        let participationVC = ParticipationDetailVC.loadFromNib()
        
        shiftVC.title = "Schedule".localized
        shiftVC.isBottombtnEnable = self.isBottombtnEnable
        shiftVC.eventId = self.oppId
        shiftVC.userParticipantData = self.userParticipantData
        shiftVC.isEngagmentEvent = true
        viewControllers.append(shiftVC)
        
        detailVC.title = "Detail".localized
        detailVC.eventId = self.oppId
        detailVC.userParticipantData = self.userParticipantData
        detailVC.tabDetailData = self.tabDetailData?[0]
        detailVC.scheduleEngagementData = self.scheduleEngagementData
        detailVC.eventType = "engagment"
        viewControllers.append(detailVC)
        
//        participationVC.title = "Participations".localized
//        participationVC.eventId = self.oppId
//        participationVC.userParticipantData = self.userParticipantData
//        viewControllers.append(participationVC)
        
        var option : PagingOptions = PagingOptions()
        option.borderColor = UIColor.separator
        option.borderOptions = .visible(height: 0.5, zIndex: 0, insets: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        
        self.pageController = PagingViewController(options: option, viewControllers: viewControllers)
        
        self.segmentsConfigurations()
    }
  
    
    @IBAction func closeApproveShift(_ sender: Any) {
        
        if isUserParticipate == true{
            
            self.requestCloseEvent()
            
        }else{
            self.applyShift()
        }
        
    }
    
    
    
    fileprivate func cancelRegisterToAttendEvent(){
        let participationId = self.userParticipantData?.msnfp_participationid ?? ""
        let params = ["msnfp_status": 844060004]
        
        
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        
        ENTALDLibraryAPI.shared.cancelResgitertoAttendEvent(participationId: participationId, params: params) { result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: _):
                DispatchQueue.main.async {
                    LoadingView.hide()
                }
                
            case .error(let error, let errorResponse):
                DispatchQueue.main.async {
                    LoadingView.hide()
                }
                var message = error.message
                if error == .patchSuccess {
                    
                }else{
                    var message = error.message
                    if let err = errorResponse {
                        message = err.error
                    }
                    //                    DispatchQueue.main.async {
                    //                        ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                    //                    }
                }
            }
        }
        
        
    }
    
    func getEventParitionCheck() {
        
        let params : [String:Any] = [
            ParameterKeys.filter : "(_msnfp_engagementopportunityid_value eq \(self.eventId) and statecode eq 0)"
        ]
        
        self.getEventParitionCheckData(params: params)
        
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
                            
                            if(!DateFormatManager.shared.isDatePassed(date: self.userParticipantData?.msnfp_enddate ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")) {
                                
                                self.lblDesc.text = ""
                                self.closeImg.isHidden = true
                                self.closeImg.image = UIImage(named: "xmark.circle.fill")
                                self.btnCancelApprovedShift.setTitle(" Apply Now ".localized, for: .normal)
                                self.isApplyNowShow = true
                                self.btnCancelApprovedShift.isHidden = false
                                self.btnCloseEvent.isHidden = true
                                self.isBottombtnEnable = true
                            }
                            if (self.userParticipantData?.msnfp_status == 844060000 || self.userParticipantData?.msnfp_status ==  844060001  || self.userParticipantData?.msnfp_status == 844060003) {
                                self.lblDesc.text = "In Review".localized
                                self.closeImg.image = UIImage(systemName: "stopwatch")
                                self.btnCloseEvent.isHidden = true
                                self.btnCancelApprovedShift.isHidden = true
                                
                            }else if (self.userParticipantData?.msnfp_status == 844060004){
                                
                                self.lblDesc.text = "Cancelled".localized
                                self.closeImg.isHidden = false
                                self.closeImg.image = UIImage(systemName:  "xmark.circle.fill")
                                self.btnCloseEvent.isHidden = true
                                self.btnCancelApprovedShift.isHidden = true
                                
                            }else if (self.userParticipantData?.msnfp_status == 844060002){
                                
                                self.lblDesc.text = "Registered to Attend".localized
                                self.closeImg.isHidden = false
                                self.closeImg.image = UIImage(systemName:  "checkmark.circle.fill")
                                self.closeImg.tintColor = UIColor.themePrimaryColor
                                self.btnCloseEvent.isHidden = true
                                self.btnCancelApprovedShift.isHidden = false
                                self.btnCancelApprovedShift.setTitle(" Cancel ".localized, for: .normal)
                                self.isApplyNowShow = false
                                
                            }
                            
                        }else{
                            self.isUserParticipate = false
                            self.isBottombtnEnable = false
                            if(DateFormatManager.shared.isDatePassed(date: self.userParticipantData?.msnfp_enddate ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")) {
                                
                                //missed
                                
                                self.lblDesc.text = "Missed".localized
                                self.closeImg.isHidden = false
                                self.closeImg.image = UIImage(systemName:  "xmark.circle.fill")
                                self.btnCloseEvent.isHidden = true
                                self.btnCancelApprovedShift.isHidden = true
                                //                                self.lblDesc.text = "No longer accepting volunteer"
                                //                                self.closeImg.isHidden = true
                                //
                                //                                self.btnCloseEvent.isHidden = false
                                //                                self.btnCloseEvent.isEnabled = false
                                //                                self.btnCloseEvent.setTitle("Close", for: .normal)
                            }else{
                                self.lblDesc.text = ""
                                self.closeImg.isHidden = true
                                
                                self.btnCloseEvent.isHidden = true
                                self.btnCloseEvent.isEnabled = false
                                //                                self.btnCloseEvent.setTitle(" Apply Now ", for: .normal)
                                self.btnCancelApprovedShift.isHidden = false
                                self.btnCancelApprovedShift.setTitle(" Apply Now ".localized, for: .normal)
                                self.isApplyNowShow = true
                            }
                            if (self.userParticipantData?.msnfp_status == 844060000 || self.userParticipantData?.msnfp_status ==  844060001  || self.userParticipantData?.msnfp_status == 844060003) {
                                self.lblDesc.text = "In Review".localized
                                self.closeImg.image = UIImage(systemName: "stopwatch")
                                self.btnCloseEvent.isHidden = true
                                self.btnCancelApprovedShift.isHidden = true
                                
                            }else if (self.userParticipantData?.msnfp_status == 844060004){
                                
                                self.lblDesc.text = "Cancelled".localized
                                self.closeImg.isHidden = false
                                self.closeImg.image = UIImage(systemName:  "xmark.circle.fill")
                                self.btnCloseEvent.isHidden = true
                                self.btnCancelApprovedShift.isHidden = true
                                
                            }else if (self.userParticipantData?.msnfp_status == 844060002){
                                
                                self.lblDesc.text = "Registered to Attend".localized
                                self.closeImg.isHidden = false
                                self.closeImg.image = UIImage(systemName:  "checkmark.circle.fill")
                                self.closeImg.tintColor = UIColor.themePrimaryColor
                                self.btnCloseEvent.isHidden = true
                                self.btnCancelApprovedShift.isHidden = false
                                self.btnCancelApprovedShift.setTitle(" Cancel ".localized, for: .normal)
                                self.isApplyNowShow = false
                                
                            }
                            
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
            "msnfp_engagementOpportunityId@odata.bind" : "/msnfp_engagementopportunities(\(self.oppId))" as String,
            "msnfp_contactId@odata.bind" : "/contacts(\(self.contactId))" as String
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
                //                DispatchQueue.main.async {
                //                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in
                //
                //                    })
                //                }
            }
        }
    }
    
    func requestCloseEvent(){
        
        let participationId = self.userParticipantData?.msnfp_participationid ?? ""
        let params = [
            "msnfp_status": 844060004 as Int
        ] as [String : Any]
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        ENTALDLibraryAPI.shared.cancelParticipationShift(participationId: participationId, params:  params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success:
                break
            case .error(let error, let errorResponse):
                
                var message = error.message
                if error == .patchSuccess {
                    
                }else{
                    var message = error.message
                    if let err = errorResponse {
                        message = err.error
                    }
                    DispatchQueue.main.async {
                        //                        ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                    }
                }
            }
        }
    }
    
    func getEventTabDetail() {
        
        let params : [String:Any] = [
            ParameterKeys.select : "msnfp_location,msnfp_engagementopportunitytitle,msnfp_shortdescription,msnfp_qualifications,msnfp_startingdate,msnfp_locationname,msnfp_shifts,msnfp_locationcitystate,msnfp_endingdate",
            ParameterKeys.filter : "(_msnfp_engagementopportunityid_value eq \(self.eventId ?? ""))"
        ]
        
        self.getEventTabDetailData(params: params)
        
    }
    
    
    fileprivate func getEventTabDetailData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerEventClickShiftDetail(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let qualification = response.value {
                    
                        self.tabDetailData = qualification
                    if ((self.tabDetailData?.count ?? 0) > 0 ) {
                        self.setupData()
                    }else{
                        DispatchQueue.main.async {
                            ENTALDAlertView.shared.showAPIAlertWithTitle(title: "Alert".localized, message: "No Data Found".localized, actionTitle: .KOK, completion: {status in
                                
                                self.navigationController?.popViewController(animated: true)
                            })
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
    
    
    
}

extension VolunteerScheduleEventDetailVC: PagingViewControllerDataSource {
    
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

