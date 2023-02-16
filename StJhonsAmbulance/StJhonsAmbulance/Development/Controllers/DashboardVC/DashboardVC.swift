//
//  DashboardVC.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 23/01/2023.
//

import UIKit
import SideMenu

class DashboardVC: ENTALDBaseViewController,MenuControllerDelegate {
    
    var sideMenu: SideMenuVC?
    var menu: SideMenuNavigationController?
    var gridData : [DashBoardGridModel]?
    var awardData : [VolunteerAwardModel]?
    var latestEventIdData : [LatestEventModel]?
    var latestEventData : [LatestEventDataModel]?
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var awardNumView: UIView!
    @IBOutlet weak var lblAward: UILabel!
    @IBOutlet weak var btnSideMenu: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblActiveDate: UILabel!
    @IBOutlet weak var lblTotalHours: UILabel!
    @IBOutlet weak var lblServiceYears: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var campView: UIView!
    @IBOutlet weak var campImgView: UIImageView!
    @IBOutlet weak var lblCamp: UILabel!
    @IBOutlet weak var lblCampNum: UILabel!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageImgView: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblMessageNum: UILabel!
    
    @IBOutlet weak var checkInView: UIView!
    @IBOutlet weak var checkInImgView: UIImageView!
    @IBOutlet weak var lblCheckIn: UILabel!
    
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var calenderImgView: UIImageView!
    @IBOutlet weak var lblCalender: UILabel!
    @IBOutlet weak var lblCalenderNum: UILabel!
    
    @IBOutlet weak var hourView: UIView!
    @IBOutlet weak var hourImgView: UIImageView!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var lblHourNum: UILabel!
    
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var eventImgView: UIImageView!
    @IBOutlet weak var lblEvent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
        setSideMenu()
        setupContent()
        getVolunteerAward()
//        getLatestIncomingEvent()
        getIncomingEvent()
//        gridData = [
//                    DashBoardGridModel(title: "", subTitle: "", bgColor: UIColor.darkBlueColor, icon: "ic_camp"),
//                    DashBoardGridModel(title: "Messages", subTitle: "02", bgColor: UIColor.orangeRedColor, icon: "ic_message"),
//                    DashBoardGridModel(title: "Volunteer", subTitle: "02", bgColor: UIColor.orangeColor, icon: "ic_communication"),
//                    DashBoardGridModel(title: "Events", subTitle: "02", bgColor: UIColor.darkFrozeColor, icon: "ic_event"),
//                    DashBoardGridModel(title: "Pending Shifts", subTitle: "02", bgColor: UIColor.lightBlueColor, icon: "ic_hour"),
//                    DashBoardGridModel(title: "Pending Events", subTitle: "06", bgColor: UIColor.themePrimaryColor, icon: "ic_pendingEvent")
//                ]
        
    }

    func setSideMenu(){
        
        self.sideMenu = SideMenuVC()
        if let list = sideMenu {
            
            list.delegate = self
            self.menu = SideMenuNavigationController(rootViewController: list)
            self.menu?.leftSide = false
            self.menu?.setNavigationBarHidden(true, animated: true)
            self.menu?.menuWidth = view.bounds.width * 0.8
            SideMenuManager.default.leftMenuNavigationController = menu
            SideMenuManager.default.addPanGestureToPresent(toView: self.view)
            
        }
    }

    func decorateUI(){
        
        profileImg.layer.cornerRadius = profileImg.frame.size.height/2
        campImgView.layer.cornerRadius = campImgView.frame.size.height/2
        messageImgView.layer.cornerRadius = messageImgView.frame.size.height/2
        checkInImgView.layer.cornerRadius = checkInImgView.frame.size.height/2
        calenderImgView.layer.cornerRadius = calenderImgView.frame.size.height/2
        hourImgView.layer.cornerRadius = hourImgView.frame.size.height/2
        eventImgView.layer.cornerRadius = eventImgView.frame.size.height/2
        
        campView.backgroundColor = UIColor.hexString(hex: "203152")
        messageView.backgroundColor = UIColor.hexString(hex: "DE5D41")
        checkInView.backgroundColor = UIColor.hexString(hex: "AC41DE")
        calenderView.backgroundColor = UIColor.hexString(hex: "2DD0DA")
        hourView.backgroundColor = UIColor.hexString(hex: "4151DE")
        eventView.backgroundColor = UIColor.hexString(hex: "41B8DE")
        
        lblCamp.font = UIFont.BoldFont(16)
        lblCampNum.font = UIFont.BoldFont(16)
        lblMessage.font = UIFont.BoldFont(16)
        lblMessageNum.font = UIFont.BoldFont(16)
        lblCheckIn.font = UIFont.BoldFont(16)
        lblCalender.font = UIFont.BoldFont(16)
        lblCalenderNum.font = UIFont.BoldFont(16)
        lblHour.font = UIFont.BoldFont(16)
        lblHourNum.font = UIFont.BoldFont(16)
        lblEvent.font = UIFont.BoldFont(16)
        
        lblCamp.textColor = UIColor.textWhiteColor
        lblCampNum.textColor = UIColor.textWhiteColor
        lblMessage.textColor = UIColor.textWhiteColor
        lblMessageNum.textColor = UIColor.textWhiteColor
        lblCheckIn.textColor = UIColor.textWhiteColor
        lblCalender.textColor = UIColor.textWhiteColor
        lblCalenderNum.textColor = UIColor.textWhiteColor
        lblHour.textColor = UIColor.textWhiteColor
        lblHourNum.textColor = UIColor.textWhiteColor
        lblEvent.textColor = UIColor.textWhiteColor
        awardNumView.backgroundColor = UIColor.red
        awardNumView.layer.cornerRadius = awardNumView.frame.size.height/2
        awardNumView.isHidden = true;
        lblAward.isHidden = true;
//        campView.backgroundColor = UIColor.hexString(hex: "203152")
//        messageView.backgroundColor = UIColor.hexString(hex: "DE5D41")
//        checkInView.backgroundColor = UIColor.hexString(hex: "AC41DE")
//        calenderView.backgroundColor = UIColor.hexString(hex: "2DD0DA")
        
        lblName.textColor = UIColor.themeColorSecondry
        lblActiveDate.textColor = UIColor.colorGrey72
        lblTotalHours.textColor = UIColor.colorGrey72
        lblServiceYears.textColor = UIColor.colorGrey72
        
        lblName.font = UIFont.BoldFont(24)
        lblActiveDate.font = UIFont.BoldFont(12)
        lblTotalHours.font = UIFont.BoldFont(12)
        lblServiceYears.font = UIFont.BoldFont(12)
        
    }
    
    func setupContent(){
        
        let date = DateFormatManager.shared.formatDateStrToStr(date: UserDefaults.standard.userInfo?.sjavms_activedate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
        let hours = String(format: "%.2f", UserDefaults.standard.userInfo?.msnfp_totalengagementhours ?? 0)
        lblName.text = UserDefaults.standard.userInfo?.fullname ?? ""
        lblActiveDate.text = "Active Date: \(date)"
        lblServiceYears.text = "Year of Service: \(UserDefaults.standard.userInfo?.sjavms_yearsofservice ?? 0)"
        lblTotalHours.text = "Total Hours: \(hours)"
        profileImg.image = ProcessUtils.shared.convertBase64StringToImage(imageBase64String: UserDefaults.standard.userInfo?.entityimage ?? "")
    }
    
//    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
//        let imageData = Data(base64Encoded: imageBase64String)
//        let image = UIImage(data: imageData!)
//        return image!
//    }
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        present(menu!, animated: true)
        
    }
    
    func didSelectMenuItem(named: String) {
        
        if (named == "Home") {
            dismiss(animated: true)
//            let vc = HomeVC(nibName: "HomeVC", bundle: nil)
//            self.navigationController?.pushViewController(vc , animated: true)
        }else if(named == "Profile"){
            
            self.navigationController?.popToRootViewController(animated: true)
            ENTALDControllers.shared.showContactInfoScreen(type: .ENTALDPUSH, from: self, callBack: nil)
                        
        }else if(named == "Qualifications/Certifications"){
            
            self.navigationController?.popToRootViewController(animated: true)
            ENTALDControllers.shared.showSideMenuQualificationScreen(type: .ENTALDPUSH, from: self,  callBack: nil)
                        
        }else if(named == "Availability"){
            
            self.navigationController?.popToRootViewController(animated: true)
            ENTALDControllers.shared.showSideMenuAvailabilityScreen(type: .ENTALDPUSH, from: self, callBack: nil)
            
        }else if(named == "Skills"){
            
            self.navigationController?.popToRootViewController(animated: true)
            ENTALDControllers.shared.showSideMenuSkillsScreen(type: .ENTALDPUSH, from: self,  callBack: nil)
                        
        }else if(named == "Language"){
            
            self.navigationController?.popToRootViewController(animated: true)
            ENTALDControllers.shared.showLanguageScreen(type: .ENTALDPUSH, from: self,  callBack: nil)
                        
        }else if(named == "Settings"){
            
            self.navigationController?.popToRootViewController(animated: true)
            ENTALDControllers.shared.showSettingScreen(type: .ENTALDPUSH, from: self,  callBack: nil)
                        
        }else if(named == "Change Password"){
            
            self.navigationController?.popToRootViewController(animated: true)
            ENTALDControllers.shared.showChangePasswordScreen(type: .ENTALDPUSH, from: self,  callBack: nil)
                        
        }else if(named == "Documents"){
            
            ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: { status in }) 
            
        }else if(named == "Logout"){
            
            UserDefaults.standard.signOut()
            
        }else{
            
            dismiss(animated: true)
        }
    }
    
  
    
    @IBAction func currentEventTapped(_ sender: Any) {
        
        UIView.transition(from: self.campView,
                          to: self.campView,
                          duration: 0.7,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews]) { status in
            if status{
                if (self.latestEventData?.count != 0 && self.latestEventData?.count != nil){
                    if ((self.latestEventData?[0]) != nil){
                        self.openNextScreen(controller: "latestEvent")
                    }
                }
            }
        }
    }
    
    @IBAction func messagTapped(_ sender: Any) {
        UIView.transition(from: self.messageView,
                          to: self.messageView,
                          duration: 0.7,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews]) { status in
            if status {
                self.openNextScreen(controller: "message")
            }
        }
    }
    
    @IBAction func checkInTapped(_ sender: Any) {
        
        UIView.transition(from: self.checkInView,
                          to: self.checkInView,
                          duration: 0.7,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews]) { status in
            if status{
                self.openNextScreen(controller: "checkIn")
            }
        }
    }
    @IBAction func scheduleTapped(_ sender: Any) {
        
        UIView.transition(from: self.calenderView,
                          to: self.calenderView,
                          duration: 0.7,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews]) { status in
            if status {
                self.openNextScreen(controller: "schedule")
            }
        }
    }
    
   
    @IBAction func eventTapped(_ sender: Any) {
        
        UIView.transition(from: self.eventView,
                          to: self.eventView,
                          duration: 0.7,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews]) { status in
            if status {
                self.openNextScreen(controller: "event")
            }
        }
    }
    
    @IBAction func hoursTapped(_ sender: Any) {
        
        UIView.transition(from: self.hourView,
                          to: self.hourView,
                          duration: 0.7,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews]) { status in
            if status {
                self.openNextScreen(controller: "hour")
            }
        }
    }
    
    // Bottom bar Action
    
    @IBAction func openLastestEvent(_ sender: Any) {
        self.openNextScreen(controller: "latestEvent")
    }
    
    @IBAction func openCheckInScreen(_ sender: Any) {
        self.openNextScreen(controller: "checkIn")
    }
    
    @IBAction func openEventScreen(_ sender: Any) {
        self.openNextScreen(controller:"event")
        
    }
    
    @IBAction func openHoursScreen(_ sender: Any) {
     
        self.openNextScreen(controller:"hour")
    }
    
    @IBAction func openMessagesScreen(_ sender: Any) {
        self.openNextScreen(controller:"message")
        
    }
    
    @IBAction func openScheduleScreen(_ sender: Any) {
        self.openNextScreen(controller:"schedule")
        
    }
    
    
    func openNextScreen(controller:String?){
        
        if (controller == "latestEvent"){
            ENTALDControllers.shared.showEventDetailScreen(type: .ENTALDPUSH, from: self, data: self.latestEventData?[0], eventName: "latestEvent") { params, controller in
                self.openNextScreen(controller:params as? String)
            }
        
            
        }else if (controller == "message"){
            ENTALDControllers.shared.showMessageScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreen(controller:params as? String)
            }
            
        }else if (controller == "checkIn" ){
            
            ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: { status in })
            
        }else if (controller == "schedule"){
            ENTALDControllers.shared.showVolunteerScheduleScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreen(controller:params as? String)
            }
        }else if (controller == "hour"){
            ENTALDControllers.shared.showVolunteerHourScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreen(controller:params as? String)
            }
        }else if (controller == "event"){
            ENTALDControllers.shared.showVolunteerEventScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreen(controller:params as? String)
            }
        }
        
        
    }
    
    
    // ==================  API  =====================
    
    func getVolunteerAward(){
        
        guard let contactId = UserDefaults.standard.contactIdToken  else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "_msnfp_awardid_value,msnfp_awarddate,msnfp_awardversionid",
//            ParameterKeys.expand : "msnfp_groupId",
            ParameterKeys.filter : "(msnfp_status eq 844060003 and _msnfp_primarycontactid_value eq \(contactId))",
            ParameterKeys.orderby : "_msnfp_awardid_value asc"
        ]
        
        self.getVolunteerAwardData(params: params)
    }
    
    fileprivate func getVolunteerAwardData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerAward(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                DispatchQueue.main.async {
                    if let award = response.value {
                        self.awardData = award
                        
                        self.lblAward.text = "\(award.count)"
                        self.awardNumView.isHidden = false
                        self.lblAward.isHidden = false
                        
                    }else{
                        self.awardNumView.isHidden = true
                        self.lblAward.isHidden = true
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
    
    
    
    
    
    func getLatestIncomingEvent(){
        
        guard let contactId = UserDefaults.standard.contactIdToken  else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_engagementopportunitystatus,msnfp_needsreviewedparticipants,msnfp_minimum,msnfp_maximum,_sjavms_group_value,msnfp_endingdate,msnfp_cancelledparticipants,msnfp_appliedparticipants,msnfp_startingdate,msnfp_engagementopportunityid",
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(statecode eq 0 and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(ProcessUtils.shared.groupListValue ?? "")])))",
            ParameterKeys.filter : "(statecode eq 0) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/statecode eq 0 and o1/Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(ProcessUtils.shared.groupListValue ?? "")]))))",
            ParameterKeys.orderby : "msnfp_engagementopportunitytitle asc"
        ]
        
        self.getLatestIncomingEventData(params: params)
    }
    
    fileprivate func getLatestIncomingEventData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerLatestEventInfo(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                DispatchQueue.main.async {
                    if let award = response.value {
                        self.latestEventIdData = award
                        self.getIncomingEvent()

                    }else{
                        self.lblCamp.text = ""
                        self.lblCampNum.text = ""
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
    
    func getIncomingEvent(){
        
                var propertyValues = ""
        
                for i in (0 ..< (self.latestEventIdData?.count ?? 0)){
                    var str = ""
        
                    if let groupid_value = self.latestEventIdData?[i].msnfp_engagementopportunityid {
        
                        if ( i == (self.latestEventIdData?.count ?? 0) - 1){
                            str = "'{\(groupid_value)}'"
                        }else{
                            str = "'{\(groupid_value)}',"
                        }
        
                        propertyValues += str
                    }
        
        
                }
        
        guard let contactId = UserDefaults.standard.contactIdToken  else {return}
        guard let currentDate = DateFormatManager.shared.getCurrentDateWithFormat(format: "yyyy-MM-dd") else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_name,msnfp_participationscheduleid,statuscode,statecode,msnfp_schedulestatus,sjavms_start,sjavms_end",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=msnfp_engagementopportunitytitle,msnfp_location)",

            ParameterKeys.filter : "(_sjavms_volunteer_value eq \(contactId) and msnfp_schedulestatus eq 335940000 and Microsoft.Dynamics.CRM.OnOrAfter(PropertyName='sjavms_end',PropertyValue='\(currentDate))') and Microsoft.Dynamics.CRM.In(PropertyName='sjavms_volunteerevent',PropertyValues=[\(propertyValues)]))",
            ParameterKeys.orderby : "msnfp_name asc"
        ]
        
        self.getVolunteerIncomingData(params: params)
    }
    
    fileprivate func getVolunteerIncomingData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerLatestEvents(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                DispatchQueue.main.async {
                    if let award = response.value {
                        self.latestEventData = award
                        
                        self.lblCamp.text = self.latestEventData?[0].sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle
                        if (self.latestEventData?[0].sjavms_start != nil && self.latestEventData?[0].sjavms_start != ""){
                            let startData = DateFormatManager.shared.formatDateStrToStr(date: self.latestEventData?[0].sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
                            self.lblCampNum.text = startData
                        }else{
                            self.lblCampNum.text = ""
                        }

                    }else{
                        self.lblCamp.isHidden = true
                        self.lblCampNum.isHidden = true
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
