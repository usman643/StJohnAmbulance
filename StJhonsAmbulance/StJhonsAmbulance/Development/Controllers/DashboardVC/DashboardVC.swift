//
//  DashboardVC.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 23/01/2023.
//

import UIKit
//import SideMenu

class DashboardVC: ENTALDBaseViewController{
    
    var gridData : [DashBoardGridModel]?
    var awardData : [VolunteerAwardModel]?
    var latestEventIdData : [LatestEventModel]?
    var latestEventData : [LatestEventDataModel]?
    var dashBoardOrder : DashBoardGridOrderModel?
    var params : [String:Any] = [:]
    let conId = UserDefaults.standard.contactIdToken ?? ""
    
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
    @IBOutlet weak var lblTabTitle: UILabel!
    
    @IBOutlet weak var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()

        setupContent()
        getVolunteerAward()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.getLatestIncomingEvent()
        }
        setupCollectionView()
        
        gridData = [
                    DashBoardGridModel(title: "", subTitle: "", bgColor: UIColor.darkBlueColor, icon: "ic_camp", key: "sjavms_youthcamp"),
                    DashBoardGridModel(title: "Messages", subTitle: "", bgColor: UIColor.orangeRedColor, icon: "ic_message", key: "sjavms_messages"),
                    DashBoardGridModel(title: "Check In", subTitle: "", bgColor: UIColor.hexString(hex: "AC41DE"), icon: "ic_checkIn", key: "sjavms_checkin"),
                    DashBoardGridModel(title: "Schedule", subTitle: "", bgColor: UIColor.hexString(hex: "2DD0DA"), icon: "ic_calender", key: "sjavms_myschedule"),
                    DashBoardGridModel(title: "Hours", subTitle: "", bgColor: UIColor.hexString(hex: "4151DE"), icon: "ic_hour", key: "sjavms_hours"),
                    DashBoardGridModel(title: "Events", subTitle: "", bgColor: UIColor.hexString(hex: "41B8DE"), icon: "ic_event", key: "sjavms_events")
                ]
        getDashBoardOrder()
        
    }

    func decorateUI(){
        
        profileImg.layer.cornerRadius = profileImg.frame.size.height/2
//        campImgView.layer.cornerRadius = campImgView.frame.size.height/2
//        messageImgView.layer.cornerRadius = messageImgView.frame.size.height/2
//        checkInImgView.layer.cornerRadius = checkInImgView.frame.size.height/2
//        calenderImgView.layer.cornerRadius = calenderImgView.frame.size.height/2
//        hourImgView.layer.cornerRadius = hourImgView.frame.size.height/2
//        eventImgView.layer.cornerRadius = eventImgView.frame.size.height/2
//
//        campView.backgroundColor = UIColor.hexString(hex: "203152")
//        messageView.backgroundColor = UIColor.hexString(hex: "DE5D41")
//        checkInView.backgroundColor = UIColor.hexString(hex: "AC41DE")
//        calenderView.backgroundColor = UIColor.hexString(hex: "2DD0DA")
//        hourView.backgroundColor = UIColor.hexString(hex: "4151DE")
//        eventView.backgroundColor = UIColor.hexString(hex: "41B8DE")
//
//        lblCamp.font = UIFont.BoldFont(16)
//        lblCampNum.font = UIFont.BoldFont(16)
//        lblMessage.font = UIFont.BoldFont(16)
//        lblMessageNum.font = UIFont.BoldFont(16)
//        lblCheckIn.font = UIFont.BoldFont(16)
//        lblCalender.font = UIFont.BoldFont(16)
//        lblCalenderNum.font = UIFont.BoldFont(16)
//        lblHour.font = UIFont.BoldFont(16)
//        lblHourNum.font = UIFont.BoldFont(16)
//        lblEvent.font = UIFont.BoldFont(16)
//
//        lblCamp.textColor = UIColor.textWhiteColor
//        lblCampNum.textColor = UIColor.textWhiteColor
//        lblMessage.textColor = UIColor.textWhiteColor
//        lblMessageNum.textColor = UIColor.textWhiteColor
//        lblCheckIn.textColor = UIColor.textWhiteColor
//        lblCalender.textColor = UIColor.textWhiteColor
//        lblCalenderNum.textColor = UIColor.textWhiteColor
//        lblHour.textColor = UIColor.textWhiteColor
//        lblHourNum.textColor = UIColor.textWhiteColor
//        lblEvent.textColor = UIColor.textWhiteColor
        awardNumView.backgroundColor = UIColor.red
        awardNumView.layer.cornerRadius = awardNumView.frame.size.height/2
        awardNumView.isHidden = true;
        lblAward.isHidden = true;
        
////        campView.backgroundColor = UIColor.hexString(hex: "203152")
////        messageView.backgroundColor = UIColor.hexString(hex: "DE5D41")
////        checkInView.backgroundColor = UIColor.hexString(hex: "AC41DE")
////        calenderView.backgroundColor = UIColor.hexString(hex: "2DD0DA")
//
        lblName.textColor = UIColor.themeColorSecondry
        lblActiveDate.textColor = UIColor.colorGrey72
        lblTotalHours.textColor = UIColor.colorGrey72
        lblServiceYears.textColor = UIColor.colorGrey72

        lblName.font = UIFont.BoldFont(24)
        lblActiveDate.font = UIFont.BoldFont(12)
        lblTotalHours.font = UIFont.BoldFont(12)
        lblServiceYears.font = UIFont.BoldFont(12)

        lblActiveDate.isHidden = true
        lblTotalHours.isHidden = true
        lblServiceYears.isHidden = true

        lblTabTitle.font = UIFont.BoldFont(16)
        lblTabTitle.textColor = UIColor.themePrimary
    }
    
    func setupContent(){
        
        let date = DateFormatManager.shared.formatDateStrToStr(date: UserDefaults.standard.userInfo?.sjavms_activedate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
        let hours = String(format: "%.2f", UserDefaults.standard.userInfo?.msnfp_totalengagementhours ?? 0)
        lblName.text = UserDefaults.standard.userInfo?.fullname ?? ""
        lblActiveDate.text = "Active Date: \(date)"
        lblServiceYears.text = "Year of Service: \(UserDefaults.standard.userInfo?.sjavms_yearsofservice ?? 0)"
        lblTotalHours.text = "Total Hours: \(hours)"
        profileImg.image = ProcessUtils.shared.convertBase64StringToImage(imageBase64String: UserDefaults.standard.userInfo?.entityimage ?? "") ?? UIImage(named: "ic_profile")
    }
    
    private func setupCollectionView(){
        collectionview.register(UINib(nibName: "CSDashBaordCVC", bundle: nil), forCellWithReuseIdentifier: "CSDashBaordCVC")
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.collectionViewLayout = generateLayout()
        collectionview.dragDelegate = self
        collectionview.dropDelegate = self
        collectionview.dragInteractionEnabled = true
    }

    
    @IBAction func sideMenuTapped(_ sender: Any) {
        present(menu!, animated: true)
        
    }
    
    @IBAction func achivementTapped(_ sender: Any) {
        ENTALDControllers.shared.showAchivementScreen(type: .ENTALDPRESENT_POPOVER, from: self, dataObj: self.awardData, callBack: nil)
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
        self.openNextScreen(controller: "sjavms_youthcamp")
    }
    
    @IBAction func openCheckInScreen(_ sender: Any) {
        self.openNextScreen(controller: "sjavms_checkin")
    }
    
    @IBAction func openEventScreen(_ sender: Any) {
        self.openNextScreen(controller:"sjavms_events")
        
    }
    
    @IBAction func openHoursScreen(_ sender: Any) {
     
        self.openNextScreen(controller:"sjavms_hours")
    }
    
    @IBAction func openMessagesScreen(_ sender: Any) {
        self.openNextScreen(controller:"sjavms_messages")
        
    }
    
    @IBAction func openScheduleScreen(_ sender: Any) {
        self.openNextScreen(controller:"sjavms_myschedule")
        
    }
    
    
    func openNextScreen(controller:String?){
        
        if (controller == "sjavms_youthcamp"){
            
            if (self.latestEventData?.count != 0 && self.latestEventData?.count != nil){
                if ((self.latestEventData?[0]) != nil){
                    ENTALDControllers.shared.showEventDetailScreen(type: .ENTALDPUSH, from: self, data: self.latestEventData?[0], eventName: "latestEvent") { params, controller in
                        self.openNextScreen(controller:params as? String)

                    }
                }
            }
        
            
        }else if (controller == "sjavms_messages"){
            ENTALDControllers.shared.showMessageScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreen(controller:params as? String)
            }
            
        }else if (controller == "sjavms_checkin" ){
            
            ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: { status in })
            
        }else if (controller == "sjavms_myschedule"){
            ENTALDControllers.shared.showVolunteerScheduleScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreen(controller:params as? String)
            }
        }else if (controller == "sjavms_hours"){
            ENTALDControllers.shared.showVolunteerHourScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreen(controller:params as? String)
            }
        }else if (controller == "sjavms_events"){
            ENTALDControllers.shared.showVolunteerEventScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreen(controller:params as? String)
            }
        }
        
        
    }
    
    
    // ==================  API  =====================
    
    func getVolunteerAward(){
        
        guard let contactId = UserDefaults.standard.contactIdToken  else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "_msnfp_awardid_value,msnfp_awarddate,msnfp_awardversionid,msnfp_name",
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
                        
//                        self.lblAward.text = "\(award.count)"
//                        self.awardNumView.isHidden = false
//                        self.lblAward.isHidden = false
                        
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
//                        self.lblCamp.text = "No Upcoming Event"
//                        self.lblCampNum.text = ""
                        
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
            
            ParameterKeys.select : "msnfp_name,msnfp_participationscheduleid,statuscode,statecode,msnfp_schedulestatus,sjavms_start,sjavms_end,sjavms_checkedin",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=msnfp_engagementopportunitytitle,msnfp_location)",

            ParameterKeys.filter : "(_sjavms_volunteer_value eq \(contactId) and msnfp_schedulestatus eq 335940000 and Microsoft.Dynamics.CRM.OnOrAfter(PropertyName='sjavms_end',PropertyValue='\(currentDate)') and Microsoft.Dynamics.CRM.In(PropertyName='sjavms_volunteerevent',PropertyValues=[\(propertyValues)]))",
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
               
                    
                    var index = NSNotFound
                    for i in (0..<(self.gridData?.count ?? 0 )){
                        if (self.gridData?[i].key ==  "sjavms_youthcamp"){
                            index = i
                        }
                    }
                DispatchQueue.main.async {
                    if let award = response.value {
                        self.latestEventData = award
                        if ((self.latestEventData?.count ?? 0 ) > 0){
                            self.gridData?[index].title = self.latestEventData?[0].sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle
                            if (self.latestEventData?[0].sjavms_start != nil && self.latestEventData?[0].sjavms_start != ""){
                                let startData = DateFormatManager.shared.formatDateStrToStr(date: self.latestEventData?[0].sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
                                self.gridData?[index].subTitle = startData
                            }else{
                                self.gridData?[index].subTitle  = ""
                            }
                        }else{
                            self.gridData?[index].title  = "No Upcoming Event"
                        }
                    }else{
                        self.gridData?[index].title  = "No Upcoming Event"
                        self.gridData?[index].subTitle  = ""
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


extension DashboardVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDragDelegate,UICollectionViewDropDelegate {
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridData?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CSDashBaordCVC", for: indexPath) as! CSDashBaordCVC
        
        cell.lblTitle.text = gridData?[indexPath.item].title
        cell.lblCount.text = gridData?[indexPath.item].subTitle
        cell.imgView.image = UIImage(named: gridData?[indexPath.item].icon ?? "")
        cell.mainView.backgroundColor = gridData?[indexPath.item].bgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CSDashBaordCVC
        
                UIView.transition(from: cell.mainView,
                                  to: cell.mainView,
                                  duration: 0.7,
                                  options: [.transitionFlipFromLeft, .showHideTransitionViews]) { status in
                    if status {
                        self.openNextScreen(controller:self.gridData?[indexPath.row].key)
                    }
                }
//        self.openNextScreen(controller:self.gridData?[indexPath.row].key)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.view.endEditing(true)
//
//        let cell = collectionView.cellForItem(at: indexPath) as! CSDashBaordCVC
//
//        UIView.transition(from: cell.mainView,
//                          to: cell.mainView,
//                          duration: 0.7,
//                          options: [.transitionFlipFromLeft, .showHideTransitionViews]) { status in
//            if status {
//                self.openNextScreen(controller:self.gridData?[indexPath.row].key)
//            }
//        }
//    }
    
    private func generateLayout() -> UICollectionViewLayout {
        
        // First Section
        let pairMainPhotoSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/2),
            heightDimension: .fractionalHeight(1.0))
        let pairMainPhotoItem = NSCollectionLayoutItem(layoutSize: pairMainPhotoSize)
        
        pairMainPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let pairSmallPhotoSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(2),
            heightDimension: .fractionalHeight(1/2))
        let pairSmallPhotoItem = NSCollectionLayoutItem(layoutSize: pairSmallPhotoSize)
        pairSmallPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let stackedSmallPhotoGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(1.0)), subitem: pairSmallPhotoItem, count: 2)
        
//        First Section Group
        let mainAndSmallPhotoGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/2)), subitems: [pairMainPhotoItem, stackedSmallPhotoGroup])
        
        
        
        
        
        
        let smallPhotoSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let smallPhotoItem = NSCollectionLayoutItem(layoutSize: smallPhotoSize)
        smallPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
//
        let tripleSmallPhotoGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1)), subitem: smallPhotoItem, count: 1)
        
        let stackedTripleSmallPhotoGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/4)), subitems: [smallPhotoItem, tripleSmallPhotoGroup])
        
        
        
        
        
        let smallPhotoSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1))
        let smallPhotoItem2 = NSCollectionLayoutItem(layoutSize: smallPhotoSize2)
        smallPhotoItem2.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
//
        
        let tripleSmallPhotoGroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: smallPhotoItem2, count: 2)
        
        let stackedTripleSmallPhotoGroup2 = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/4)), subitems: [tripleSmallPhotoGroup2])
      
        
        
    
        let allGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)),
            subitems: [
                mainAndSmallPhotoGroup,
                stackedTripleSmallPhotoGroup,
                stackedTripleSmallPhotoGroup2
                
            ])
        let section = NSCollectionLayoutSection(group: allGroup)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let item = self.gridData?[indexPath.row]
        let itemProvider = NSItemProvider(object: item?.title as! NSString )
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag{
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator)  {
        
        var destinationIndexPath : IndexPath
        if let indexPath = coordinator.destinationIndexPath{
            destinationIndexPath = indexPath
        }else{
            let row = collectionView.numberOfItems(inSection: 0)
            destinationIndexPath = IndexPath(item: row - 1 , section: 0)
        }
        
        if coordinator.proposal.operation == .move {
            self.reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
        }
        
        
    }
    
    fileprivate func reorderItems (coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView:UICollectionView){
        
        
        if let item = coordinator.items.first,
           let sourceIndexPath = item.sourceIndexPath {
            collectionView.performBatchUpdates({
                self.gridData?.remove(at: sourceIndexPath.item)
                self.gridData?.insert(item.dragItem.localObject as! DashBoardGridModel, at: destinationIndexPath.item)
                
                collectionView.deleteItems (at: [sourceIndexPath])
                collectionView.insertItems (at: [destinationIndexPath])}, completion: nil)
                
            
            
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
        
        params = [
            "sjavms_user@odata.bind" : "/contacts(\(self.conId))",
            "sjavms_csgrouplead" : false,
            ]
        for i in (0..<(self.gridData?.count ?? 0 )){
            self.gridData?[i].order = i + 1
            
            var key = (self.gridData?[i].key ?? "") as String
            var order = (self.gridData?[i].order ?? NSNotFound) as Int
            params[key] = order

        }

        self.updateDashboardGridOrder(params: params)
        params = [:]
    }
    
    
    
    fileprivate func getDashBoardOrder(){
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "statecode,sjavms_messages,sjavms_events,sjavms_checkin,sjavms_hours,sjavms_name,sjavms_myschedule,sjavms_dayofevent,sjavms_pendingevents,sjavms_csgrouplead,_sjavms_user_value,sjavms_volunteers,sjavms_youthcamp,sjavms_pendingshifts",
            ParameterKeys.filter : "(sjavms_csgrouplead eq false and statecode eq 0 and _sjavms_user_value eq \(UserDefaults.standard.contactIdToken ?? ""))",
            
        ]
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getDashBoardTileOrder(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let apidata = response.value {
                    if apidata.count > 0{
    
                        self.dashBoardOrder = apidata[0]
                        var modeldata : [DashBoardGridModel] = []
                        
                        var _ = self.gridData?.compactMap({ model in
                            var model = model
                            
                            
                            if model.key == "sjavms_youthcamp" {
                                model.order = self.dashBoardOrder?.sjavms_youthcamp
                            }else if model.key == "sjavms_messages" {
                                model.order = self.dashBoardOrder?.sjavms_messages
                            }else if model.key == "sjavms_checkin" {
                                model.order = self.dashBoardOrder?.sjavms_checkin
                            }else if model.key == "sjavms_myschedule" {
                                model.order = self.dashBoardOrder?.sjavms_myschedule
                            }else if model.key == "sjavms_hours" {
                                model.order = self.dashBoardOrder?.sjavms_hours
                            }else if model.key == "sjavms_events" {
                                model.order = self.dashBoardOrder?.sjavms_events
                            }
                            
                            modeldata.append(model)
                            return true
                        })
                        
                        self.gridData = modeldata
                        
                        self.gridData = self.gridData?.sorted {
                            $0.order ?? NSNotFound < $1.order ?? NSNotFound
                        }
                        DispatchQueue.main.async {
                            self.collectionview.reloadData()
                        }
                        
                    }else{
                            self.saveDashboardGridOrder()
                        }
                }else{
                    self.saveDashboardGridOrder()
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
    
    fileprivate func saveDashboardGridOrder(){
        
        let params : [String:Any] = [
            "sjavms_user@odata.bind" : "/contacts(\(self.conId))",
               "sjavms_csgrouplead" : true,
               "sjavms_messages": 2,
               "sjavms_myschedule": 4,
               "sjavms_events": 6,
               "sjavms_checkin": 3,
               "sjavms_youthcamp": 1,
               "sjavms_hours": 5
        ]

        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.saveDashBoardTileOrder(params: params) { result in
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
                if error == .patchSuccess {
                    self.getDashBoardOrder()
                }else{
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
        
        var modeldata : [DashBoardGridModel] = []
        
        var _ = self.gridData?.compactMap({ model in
            var model = model
            
            if model.key == "sjavms_youthcamp" {
                model.order = 1
            }else if model.key == "sjavms_messages" {
                model.order = 2
            }else if model.key == "sjavms_checkin" {
                model.order = 3
            }else if model.key == "sjavms_myschedule" {
                model.order = 4
            }else if model.key == "sjavms_hours" {
                model.order = 5
            }else if model.key == "sjavms_events" {
                model.order = 6
            }
            
            modeldata.append(model)
            return true
        })
        
        self.gridData = modeldata
    }
    
    
    fileprivate func updateDashboardGridOrder(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.updateDashBoardTileOrder(orderid: self.dashBoardOrder?.sjavms_dashboard_orderid ?? "", params: params) { result in
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
                if error == .patchSuccess {
//                    DispatchQueue.main.async {
//                        ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: "patch sucess", actionTitle: .KOK, completion: {status in })
//                    }
                }else{
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
    
    
}
    
    
