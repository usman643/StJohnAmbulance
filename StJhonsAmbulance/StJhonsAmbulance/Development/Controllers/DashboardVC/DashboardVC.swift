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
    var checkInData : [CheckInModel]?
    var dashBoardOrder : DashBoardGridOrderModel?
    var mapArr : [CheckInModel] = []
    var params : [String:Any] = [:]
    let conId = UserDefaults.standard.contactIdToken ?? ""
    //    let tabbar = ENTALDTabbarViewController()
    
    var selectedUserGroup : LandingGroupsModel?
    var genderData : [LanguageModel] = []
    //    var prefferedLanguageData : [LanguageModel] = []
    var prefferedPronounData : [LanguageModel] = []
    var prefferedMethodContactData : [LanguageModel] = []
    var languageData : [LanguageModel] = []
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSideMenu: UIButton!
    
    @IBOutlet weak var lblIncomingTitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptybtnView: UIView!
    
    @IBOutlet weak var emptyBtnImg: UIImageView!
    @IBOutlet weak var lblEmptybtn: UILabel!
    @IBOutlet weak var emptyViewMsg: UILabel!
    @IBOutlet weak var emptyviewImg: UIImageView!
    //    @IBOutlet weak var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        decorateUI()
        getGroups()
        setupContent()
        //        getVolunteerAward()
        setupTableView()
//        setupCollectionView()
        
//        gridData = [
            //                    DashBoardGridModel(title: "No Upcoming Event", subTitle: "", bgColor: UIColor.darkBlueColor, icon: "ic_camp", key: "sjavms_youthcamp"),
            
//            DashBoardGridModel(title: "Hours", subTitle: "", bgColor: UIColor.hexString(hex: "4151DE"), icon: "ic_hour", key: "sjavms_hours"),
            //
//            DashBoardGridModel(title: "My Schedule", subTitle: "", bgColor: UIColor.hexString(hex: "2DD0DA"), icon: "ic_calender", key: "sjavms_myschedule"),
//            DashBoardGridModel(title: "Events", subTitle: "", bgColor: UIColor.hexString(hex: "41B8DE"), icon: "ic_event", key: "sjavms_events"),
//            DashBoardGridModel(title: "Hours", subTitle: "", bgColor: UIColor.hexString(hex: "4151DE"), icon: "ic_hour", key: "sjavms_hours"),
//            DashBoardGridModel(title: "Check In", subTitle: "", bgColor: UIColor.hexString(hex: "AC41DE"), icon: "ic_checkIn", key: "sjavms_checkin"),
//            DashBoardGridModel(title: "Messages", subTitle: "", bgColor: UIColor.orangeRedColor, icon: "ic_message", key: "sjavms_messages")
//        ]
        //        getDashBoardOrder()
        
        
        getGender()
        getPrefferedNoun()
        getPrefferedMethodContact()
        getPrefferedLanguage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false // or true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func decorateUI(){
        lblTitle.font = UIFont.HeaderBoldFont(18)
        lblTitle.textColor = UIColor.headerTitleColor
        lblIncomingTitle.font = UIFont.HeaderBoldFont(14)
        lblIncomingTitle.textColor = UIColor.themeBlackText
        lblTitle.font = UIFont.HeaderBoldFont(14)
        lblTitle.textColor = UIColor.themeBlackText
        lblName.font = UIFont.BoldFont(14)
        lblName.textColor = UIColor.themePrimaryColor
        lblDesc.font = UIFont.RegularFont(12)
        profileImg.layer.cornerRadius = profileImg.frame.size.height/2
        headerView.dropShadow(color: UIColor.blue, opacity: 1.0, offSet: .zero, radius: 0, scale: true)
        emptyView.isHidden = true
    }
    
    func setupContent(){
        
//        let date = DateFormatManager.shared.formatDateStrToStr(date: UserDefaults.standard.userInfo?.sjavms_activedate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
//        let hours = String(format: "%.2f", UserDefaults.standard.userInfo?.msnfp_totalengagementhours ?? 0)
        lblName.text = "Welcome \(UserDefaults.standard.userInfo?.fullname ?? "")."
        profileImg.image = ProcessUtils.shared.convertBase64StringToImage(imageBase64String: UserDefaults.standard.userInfo?.entityimage ?? "") ?? UIImage(named: "ic_profile")
    }
    
//    private func setupCollectionView(){
//        collectionview.register(UINib(nibName: "CSDashBaordCVC", bundle: nil), forCellWithReuseIdentifier: "CSDashBaordCVC")
//        collectionview.dataSource = self
//        collectionview.delegate = self
//        //        collectionview.collectionViewLayout = generateLayout()
//        //        collectionview.dragDelegate = self
//        //        collectionview.dropDelegate = self
//        //        collectionview.dragInteractionEnabled = true
//    }
    
    private func setupTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "VolunteerIncomingCell", bundle: nil), forCellReuseIdentifier: "VolunteerIncomingCell")
    }
    
    @IBAction func messageTapped(_ sender: Any) {
        ENTALDControllers.shared.showGroupMessageVC(type: .ENTALDPUSH, from: self, callBack: nil)
    }
    
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        present(menu!, animated: true)
        
    }
 
    @IBAction func showProfile(_ sender: Any) {
        ENTALDControllers.shared.showContactInfoScreen(type: .ENTALDPUSH, from: self, callBack: nil)
        
    }
    
    @IBAction func emptyEventBtnTapped(_ sender: Any) {
        
        self.tabBarController?.selectedIndex = 1
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
            //            self.tabbar.selectedIndex = 4
            //            let vc = SignalRVC()
            //            self.navigationController?.pushViewController(vc, animated: true)
            //            self.tabBarController?.selectedIndex = 4
            ENTALDControllers.shared.showMessageScreen(type: .ENTALDPUSH, from: self,  dataObj: true) { params, controller in
                self.openNextScreen(controller:params as? String)
            }
            
        }else if (controller == "sjavms_checkin" ){
            
            ENTALDControllers.shared.showVolunteerMap(type: .ENTALDPUSH, from: self, callBack:  { params, controller in
                self.openNextScreen(controller:params as? String)
            })
            
            
            
            
            
            //            let dispatchQueue = DispatchQueue(label: "myQueu", qos: .background)
            //            //Create a semaphore
            //            let semaphore = DispatchSemaphore(value: 0)
            //
            //            dispatchQueue.async {
            //                for i in (0 ..< (self.latestEventIdData?.count ?? 0)){
            //                    self.getCheckInData(eventOppId: self.latestEventIdData?[i].msnfp_engagementopportunityid ?? "", completion:{ [weak self] model in
            //                        semaphore.signal()
            //                        guard let self = self else {return}
            //                        if let checkInData = model?.value {
            //                            self.checkInData = checkInData
            //                            if ((self.checkInData?.count ?? 0) > 0){
            //                                self.mapArr.append(contentsOf: (checkInData))
            //                            }
            //                        }
            //
            //                    })
            //                    semaphore.wait()
            //                }
            //
            //                DispatchQueue.main.async(execute: {
            //                    ENTALDControllers.shared.showVolunteerMap(type: .ENTALDPUSH, from: self, isNavigationController:true, dataObj: self.mapArr, callBack: nil)
            //
            //                })
            //            }
//            self.tabBarController?.selectedIndex = 3
            
        }else if (controller == "sjavms_myschedule"){
            //            ENTALDControllers.shared.showVolunteerScheduleScreen(type: .ENTALDPUSH, from: self) { params, controller in
            //                self.openNextScreen(controller:params as? String)
            //            }
            self.tabBarController?.selectedIndex = 1
        }else if (controller == "sjavms_hours"){
            self.tabBarController?.selectedIndex = 3
            ENTALDControllers.shared.showVolunteerHourScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreen(controller:params as? String)
            }
        }else if (controller == "sjavms_events"){
            //            ENTALDControllers.shared.showVolunteerEventScreen(type: .ENTALDPUSH, from: self) { params, controller in
            //                self.openNextScreen(controller:params as? String)
            //            }
            self.tabBarController?.selectedIndex = 2
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
//                        self.awardNumView.isHidden = true
//                        self.lblAward.isHidden = true
                    }
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                                DispatchQueue.main.async {
                                    LoadingView.hide()
                //                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                                }
            }
        }
    }
    
    
    
    

    func getLatestIncomingEvent(){

        let params : [String:Any] = [

            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_engagementopportunitystatus,msnfp_needsreviewedparticipants,msnfp_minimum,msnfp_maximum,_sjavms_group_value,msnfp_endingdate,msnfp_cancelledparticipants,msnfp_appliedparticipants,msnfp_startingdate,msnfp_engagementopportunityid",
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(statecode eq 0 and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(ProcessUtils.shared.groupListValue ?? "")])))",

            //  "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(statecode eq 0 and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(ProcessUtils.shared.groupListValue ?? "")])))",
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
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }

            switch result{
            case .success(value: let response):

                if let award = response.value {
                    self.latestEventIdData = award
                    self.getIncomingEvent()

                }else{

//                    DispatchQueue.main.async {
//                        self.collectionview.reloadData()
//                    }
                }


            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                                DispatchQueue.main.async {
                                    LoadingView.hide()
                //                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
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
            
            ParameterKeys.filter : "(_sjavms_volunteer_value eq \(contactId) and msnfp_schedulestatus eq 335940000 and Microsoft.Dynamics.CRM.OnOrAfter(PropertyName='sjavms_end',PropertyValue='\(currentDate)') and Microsoft.Dynamics.CRM.In(PropertyName='sjavms_volunteerevent',PropertyValues=[\(propertyValues)]))",
            ParameterKeys.orderby : "msnfp_name asc"
        ]
        
        self.getVolunteerIncomingData(params: params)
    }
    
    fileprivate func getVolunteerIncomingData(params : [String:Any]){
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
        
        ENTALDLibraryAPI.shared.requestVolunteerLatestEvents(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                
                //                    var index = NSNotFound
                //                    for i in (0..<(self.gridData?.count ?? 0 )){
                //                        if (self.gridData?[i].key ==  "sjavms_youthcamp"){
                //                            index = i
                //                        }
                //                    }
                //                DispatchQueue.main.async {
                //                    if let award = response.value {
                //                        self.latestEventData = award
                //                        if ((self.latestEventData?.count ?? 0 ) > 0){
                //                            self.gridData?[index].title = self.latestEventData?[0].sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle
                //                            if (self.latestEventData?[0].sjavms_start != nil && self.latestEventData?[0].sjavms_start != ""){
                //                                let startData = DateFormatManager.shared.formatDateStrToStr(date: self.latestEventData?[0].sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
                //                                self.gridData?[index].subTitle = startData
                //                                self.collectionview.reloadData()
                //                            }else{
                //                                self.gridData?[index].subTitle  = ""
                //                            }
                //                        }else{
                //                            DispatchQueue.main.async {
                //                                self.gridData?[index].title  = "No Upcoming Event"
                //                                self.collectionview.reloadData()
                //                            }
                //                        }
                //                    }else{
                //                        DispatchQueue.main.async {
                //                            self.gridData?[index].title  = "No Upcoming Event"
                //                            self.collectionview.reloadData()
                //                        }
                //                    }
                //                }
                
                DispatchQueue.main.async {
                    if let apiData = response.value {
                        self.latestEventData = apiData
                        self.timefilter()
                        
                        self.latestEventData = self.latestEventData?.sorted(by: { $0.sjavms_start ?? "" < $1.sjavms_start ?? "" })
                        
                        //time filter
                        
                        
                        
                        if (self.latestEventData?.count == 0 || self.latestEventData?.count == nil){
                            self.emptyView.isHidden = false
                            //                        self.showEmptyView(tableVw: self.tableView)
                        }else{
                            //                        DispatchQueue.main.async {
                            //                            for subview in self.tableView.subviews {
                            //                                subview.removeFromSuperview()
                            //                            }
                            self.emptyView.isHidden = true
                            //                        }
                        }
                        //                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        //                    }
                    }else{
                        //                    self.showEmptyView(tableVw: self.tableView)
                        self.emptyView.isHidden = false
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
    
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
    
    func timefilter(){
        var minusTime : [LatestEventDataModel]  = []
        var plusTime : [LatestEventDataModel] = []

        if ((self.latestEventData?.count ?? 0) > 0){
        for i in (0 ..< (self.latestEventData?.count ?? 0) - 1){
            
            let eventDate = DateFormatManager.shared.getDateFromString(date: self.latestEventData?[i].sjavms_start) ?? Date()
            let currentDate = DateFormatManager.shared.getCurrentDate()
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.minute, .second], from: currentDate, to: eventDate)
            self.latestEventData?[i].time_difference = components.minute
        }
        
            for i in (0 ..< (self.latestEventData?.count ?? 0) - 1){
                //            debugPrint(self.latestEventData)
                if ((self.latestEventData?[i].time_difference ?? 0) >= 0){
                    
                    if let data = self.latestEventData?[i] {
                        plusTime.append(data)
                    }
                }
            }
            if (plusTime.count > 0){
                plusTime = plusTime.sorted(by: { $0.time_difference ?? 0 < $1.time_difference ?? 0 })
                self.latestEventData = []
                self.latestEventData?.append(contentsOf: plusTime)
            }else{
                self.latestEventData = []
            }
            
            
        }
    }
}


extension DashboardVC : UITableViewDelegate,UITableViewDataSource{
//,UICollectionViewDragDelegate,UICollectionViewDropDelegate {
    
    
    
    

    
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
    // old alyout
//    private func generateLayout() -> UICollectionViewLayout {
//
//        // First Section
//        let pairMainPhotoSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1/2),
//            heightDimension: .fractionalHeight(1.0))
//        let pairMainPhotoItem = NSCollectionLayoutItem(layoutSize: pairMainPhotoSize)
//
//        pairMainPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
//
//        let pairSmallPhotoSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(2),
//            heightDimension: .fractionalHeight(1/2))
//        let pairSmallPhotoItem = NSCollectionLayoutItem(layoutSize: pairSmallPhotoSize)
//        pairSmallPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
//
//        let stackedSmallPhotoGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(1.0)), subitem: pairSmallPhotoItem, count: 2)
//
////        First Section Group
//        let mainAndSmallPhotoGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/2)), subitems: [pairMainPhotoItem, stackedSmallPhotoGroup])
//
//        let smallPhotoSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
//        let smallPhotoItem = NSCollectionLayoutItem(layoutSize: smallPhotoSize)
//        smallPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
////
//        let tripleSmallPhotoGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1)), subitem: smallPhotoItem, count: 1)
//
//        let stackedTripleSmallPhotoGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/4)), subitems: [smallPhotoItem, tripleSmallPhotoGroup])
//
//
//
//
//
//        let smallPhotoSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1))
//        let smallPhotoItem2 = NSCollectionLayoutItem(layoutSize: smallPhotoSize2)
//        smallPhotoItem2.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
////
//
//        let tripleSmallPhotoGroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: smallPhotoItem2, count: 2)
//
//        let stackedTripleSmallPhotoGroup2 = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/4)), subitems: [tripleSmallPhotoGroup2])
//
//
//
//
//        let allGroup = NSCollectionLayoutGroup.vertical(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1.0),
//                heightDimension: .fractionalHeight(1.0)),
//            subitems: [
//                mainAndSmallPhotoGroup,
//                stackedTripleSmallPhotoGroup,
//                stackedTripleSmallPhotoGroup2
//
//            ])
//        let section = NSCollectionLayoutSection(group: allGroup)
//        return UICollectionViewCompositionalLayout(section: section)
//    }
//  drag drop delegate
//    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        //to lock first 2 items
////        if (indexPath.item  < 2){
////            return []
////        }
//
//        let item = self.gridData?[indexPath.row]
//        let itemProvider = NSItemProvider(object: item?.title as! NSString )
//        let dragItem = UIDragItem(itemProvider: itemProvider)
//        dragItem.localObject = item
//        return [dragItem]
//    }
//
//    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
//        // to lock first 2 items
////        if (destinationIndexPath?.item ?? 0 < 2){
////            return UICollectionViewDropProposal(operation: .forbidden)
////        }
//        if collectionView.hasActiveDrag{
//            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
//        }
//
//        return UICollectionViewDropProposal(operation: .forbidden)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator)  {
//
//        var destinationIndexPath : IndexPath
//        if let indexPath = coordinator.destinationIndexPath{
//            destinationIndexPath = indexPath
//        }else{
//            let row = collectionView.numberOfItems(inSection: 0)
//            destinationIndexPath = IndexPath(item: row - 1 , section: 0)
//        }
//
//        if coordinator.proposal.operation == .move {
//            self.reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
//        }
//
//
//    }
//
//    fileprivate func reorderItems (coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView:UICollectionView){
//
//
//        if let item = coordinator.items.first,
//           let sourceIndexPath = item.sourceIndexPath {
//            collectionView.performBatchUpdates({
//                self.gridData?.remove(at: sourceIndexPath.item)
//                self.gridData?.insert(item.dragItem.localObject as! DashBoardGridModel, at: destinationIndexPath.item)
//
//                collectionView.deleteItems (at: [sourceIndexPath])
//                collectionView.insertItems (at: [destinationIndexPath])}, completion: nil)
//
//
//
//            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
//        }
//
//        params = [
//            "sjavms_user@odata.bind" : "/contacts(\(self.conId))",
//            "sjavms_csgrouplead" : false,
//            ]
//        for i in (0..<(self.gridData?.count ?? 0 )){
//            self.gridData?[i].order = i + 1
//
//            var key = (self.gridData?[i].key ?? "") as String
//            var order = (self.gridData?[i].order ?? NSNotFound) as Int
//            params[key] = order
//
//        }
//
//
//        self.updateDashboardGridOrder(params: params)
//        params = [:]
//    }
    
    
//
//    fileprivate func getDashBoardOrder(){
//
//        let params : [String:Any] = [
//
//            ParameterKeys.select : "statecode,sjavms_messages,sjavms_events,sjavms_checkin,sjavms_hours,sjavms_name,sjavms_myschedule,sjavms_dayofevent,sjavms_pendingevents,sjavms_csgrouplead,_sjavms_user_value,sjavms_volunteers,sjavms_youthcamp,sjavms_pendingshifts",
//            ParameterKeys.filter : "(sjavms_csgrouplead eq false and statecode eq 0 and _sjavms_user_value eq \(UserDefaults.standard.contactIdToken ?? ""))",
//
//        ]
//
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
//
//        ENTALDLibraryAPI.shared.getDashBoardTileOrder(params: params){ result in
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }
//
//            switch result{
//            case .success(value: let response):
//
//                if let apidata = response.value {
//                    if apidata.count > 0{
//
//                        self.dashBoardOrder = apidata[0]
//                        var modeldata : [DashBoardGridModel] = []
//
//                        var _ = self.gridData?.compactMap({ model in
//                            var model = model
//
//
//                            if model.key == "sjavms_youthcamp" {
//                                model.order = self.dashBoardOrder?.sjavms_youthcamp
//                            }else if model.key == "sjavms_messages" {
//                                model.order = self.dashBoardOrder?.sjavms_messages
//                            }else if model.key == "sjavms_checkin" {
//                                model.order = self.dashBoardOrder?.sjavms_checkin
//                            }else if model.key == "sjavms_myschedule" {
//                                model.order = self.dashBoardOrder?.sjavms_myschedule
//                            }else if model.key == "sjavms_hours" {
//                                model.order = self.dashBoardOrder?.sjavms_hours
//                            }else if model.key == "sjavms_events" {
//                                model.order = self.dashBoardOrder?.sjavms_events
//                            }
//
//                            modeldata.append(model)
//                            return true
//                        })
//
//                        self.gridData = modeldata
//
//                        self.gridData = self.gridData?.sorted {
//                            $0.order ?? NSNotFound < $1.order ?? NSNotFound
//                        }
//                        DispatchQueue.main.async {
//                            self.collectionview.reloadData()
//                        }
//
//                    }else{
//                            self.saveDashboardGridOrder()
//                        }
//                }else{
//                    self.saveDashboardGridOrder()
//                }
//
//            case .error(let error, let errorResponse):
//                var message = error.message
//                if let err = errorResponse {
//                    message = err.error
//                }
////                DispatchQueue.main.async {
////                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
////                }
//            }
//        }
//    }
//
//    fileprivate func saveDashboardGridOrder(){
//
//        let params : [String:Any] = [
//            "sjavms_user@odata.bind" : "/contacts(\(self.conId))",
//               "sjavms_csgrouplead" : false,
//               "sjavms_messages": 2,
//               "sjavms_myschedule": 1,
//               "sjavms_events": 4,
////               "sjavms_checkin": 3,
////               "sjavms_youthcamp": 1,
//               "sjavms_hours": 3
//        ]
//
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
//
//        ENTALDLibraryAPI.shared.saveDashBoardTileOrder(params: params) { result in
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }
//
//            switch result{
//            case .success(value: _):
//                DispatchQueue.main.async {
//                    LoadingView.hide()
//                }
//
//            case .error(let error, let errorResponse):
//                DispatchQueue.main.async {
//                    LoadingView.hide()
//                }
//                if error == .patchSuccess {
//                    self.getDashBoardOrder()
//                }else{
//                    var message = error.message
//                    if let err = errorResponse {
//                        message = err.error
//                    }
////                    DispatchQueue.main.async {
////                        ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
////                    }
//                }
//            }
//        }
//
//        var modeldata : [DashBoardGridModel] = []
//
//        var _ = self.gridData?.compactMap({ model in
//            var model = model
//
////            if model.key == "sjavms_youthcamp" {
////                model.order = 1
////            }else
//            if model.key == "sjavms_messages" {
//                model.order = 2
////            }else if model.key == "sjavms_checkin" {
////                model.order = 3
//            }else if model.key == "sjavms_myschedule" {
//                model.order = 1
//            }else if model.key == "sjavms_hours" {
//                model.order = 3
//            }else if model.key == "sjavms_events" {
//                model.order = 4
//            }
//
////            if model.key == "sjavms_youthcamp" {
////                model.order = 1
////            }else if model.key == "sjavms_messages" {
////                model.order = 2
////            }else if model.key == "sjavms_checkin" {
////                model.order = 3
////            }else if model.key == "sjavms_myschedule" {
////                model.order = 4
////            }else if model.key == "sjavms_hours" {
////                model.order = 5
////            }else if model.key == "sjavms_events" {
////                model.order = 6
////            }
//
//
//
//
//            modeldata.append(model)
//            return true
//        })
//
//        self.gridData = modeldata
//    }
//
//
//    fileprivate func updateDashboardGridOrder(params : [String:Any]){
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
//
//        ENTALDLibraryAPI.shared.updateDashBoardTileOrder(orderid: self.dashBoardOrder?.sjavms_dashboard_orderid ?? "", params: params) { result in
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }
//
//            switch result{
//            case .success(value: _):
//                DispatchQueue.main.async {
//                    LoadingView.hide()
//                }
//
//            case .error(let error, let errorResponse):
//                DispatchQueue.main.async {
//                    LoadingView.hide()
//                }
//                if error == .patchSuccess {
////                    DispatchQueue.main.async {
////                        ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: "patch sucess", actionTitle: .KOK, completion: {status in })
////                    }
//                }else{
//                    var message = error.message
//                    if let err = errorResponse {
//                        message = err.error
//                    }
////                    DispatchQueue.main.async {
////                        ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
////                    }
//                }
//            }
//        }
//    }
    
    fileprivate func getCheckInData(eventOppId:String, completion:@escaping((_ model : CheckInResponseModel?) -> Void )){
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "fullname,telephone1,_ownerid_value,emailaddress1,bdo_province,address1_postalcode,address1_city,bdo_contactid,_parentcustomerid_value,contactid,entityimage",
            ParameterKeys.expand : "sjavms_contact_msnfp_participationschedule_Volunteer($select=sjavms_checkedin,sjavms_checkedinlatitude,sjavms_checkedinlongitude,sjavms_checkedinlatitudevalue,sjavms_checkedinlongitudevalue,sjavms_checkedinat,sjavms_checkedinlocation;$filter=(_sjavms_volunteerevent_value eq \(eventOppId) and msnfp_schedulestatus eq 335940000))",
            ParameterKeys.filter : "(sjavms_contact_msnfp_participationschedule_Volunteer/any(o1:(o1/_sjavms_volunteerevent_value eq \(eventOppId) and o1/msnfp_schedulestatus eq 335940000)))",
            ParameterKeys.orderby : "fullname asc"
        ]
        
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
        
        ENTALDLibraryAPI.shared.requestCheckInData(params: params){ result in
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }
            
            switch result{
            case .success(value: let response):
                completion(response)
                
            case .error(let error, let errorResponse):
                completion(nil)
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                print("Error Message \(message)")
            }
        }
    }
    
    
    
    //MARK:  Landing screen APIs
    
    fileprivate func getGender() {
        
        let params : [String:Any] = [
            ParameterKeys.filter : "objecttypecode eq 'contact' and attributename eq 'sjavms_gender' and langid eq 1033"
        ]
    
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
        
        ENTALDLibraryAPI.shared.requestProfileInfoDetail(params: params){ result in
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }
            switch result{
            case .success(value: let response):
                
                if let genderData = response.value {
                    ProcessUtils.shared.genderData = genderData
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }

//                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
//                }
            }
        }
    }
    
    
    fileprivate func getPrefferedNoun() {
        
        let params : [String:Any] = [
            ParameterKeys.filter : "objecttypecode eq 'contact' and attributename eq 'sjavms_preferredpronouns' and langid eq 1033"
        ]
    
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
        
        ENTALDLibraryAPI.shared.requestProfileInfoDetail(params: params){ result in
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }
            switch result{
            case .success(value: let response):
                
                if let genderData = response.value {
                    ProcessUtils.shared.prefferedPronounData = genderData
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }

//                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
//                }
            }
        }
    }
    
    fileprivate func getPrefferedMethodContact() {
        
        let params : [String:Any] = [
            ParameterKeys.filter : "objecttypecode eq 'contact' and attributename eq 'preferredcontactmethodcode' and langid eq 1033"
        ]
    
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
        
        ENTALDLibraryAPI.shared.requestProfileInfoDetail(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let genderData = response.value {
                    ProcessUtils.shared.prefferedMethodContactData = genderData
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }

//                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
//                }
            }
        }
    }
    
    fileprivate func getPrefferedLanguage() {
        
        let params : [String:Any] = [
            ParameterKeys.select : "adx_portallanguageid,adx_name,createdon",
            ParameterKeys.expand : "adx_adx_portallanguage_adx_websitelanguage($filter=(_adx_websiteid_value eq 24684e99-f092-4556-8b54-060fd532e73b))",
            ParameterKeys.filter : "(adx_adx_portallanguage_adx_websitelanguage/any(o1:(o1/_adx_websiteid_value eq 24684e99-f092-4556-8b54-060fd532e73b)))",
            
            ParameterKeys.orderby : "adx_name asc"
            
        ]
    
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
        
        ENTALDLibraryAPI.shared.requestPreferedLanguage(params: params){ result in
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }
            switch result{
            case .success(value: let response):
                
                if let language = response.value {
                    ProcessUtils.shared.prefferedLanguageData = language
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }

//                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
//                }
            }
        }
    }
 
    func getGroups(){
        
        let params : [String:Any] = [
            ParameterKeys.select : "sjavms_groupmembershipid,sjavms_groupmembershipname,_sjavms_contactid_value,_sjavms_groupid_value",
            ParameterKeys.expand : "sjavms_groupid($select=msnfp_groupname),sjavms_contactid($select=fullname),sjavms_RoleType($select=sjavms_rolecategory)",
            ParameterKeys.filter : "(statecode eq 0 and _sjavms_contactid_value eq \(self.conId)) and (sjavms_groupid/statecode eq 0)",
            ParameterKeys.orderby : "_sjavms_groupid_value asc"
        ]
        
        self.getAssociatedGroups(params: params)
    }
    
    
    fileprivate func getAssociatedGroups(params:[String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestAssociatedGroups(params: params) { result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            self.getGender()
            self.getPrefferedNoun()
            self.getPrefferedMethodContact()
            self.getPrefferedLanguage()
            
            switch result {
            case .success(let response):
                if let userGroups = response.value {
                    
                    ProcessUtils.shared.allGroupsList = userGroups
                    
                    var leadGroupArr :[LandingGroupsModel] = []
                    var volunteerGroupArr :[LandingGroupsModel] = []
                   
                    
                    for i in (0 ..< (userGroups.count )){
                        if userGroups[i].sjavms_RoleType?.sjavms_rolecategory == 802280001 {
                            leadGroupArr.append(userGroups[i])

                        }else if userGroups[i].sjavms_RoleType?.sjavms_rolecategory == 802280000 {
                            volunteerGroupArr.append(userGroups[i])
                        }
                    }
                    ProcessUtils.shared.volunteerGroupsList = volunteerGroupArr
                    ProcessUtils.shared.userGroupsList = leadGroupArr
                    
                    var propertyValues = ""
                    
                    for i in (0 ..< (ProcessUtils.shared.allGroupsList.count )){
                        var str = ""
                        
                        if let groupid_value = ProcessUtils.shared.allGroupsList[i]._sjavms_groupid_value {
                            
                            if ( i == (ProcessUtils.shared.allGroupsList.count) - 1){
                                str = "'{\(groupid_value)}'"
                            }else{
                                str = "'{\(groupid_value)}',"
                            }
                            propertyValues += str
                        }
                    }
                    ProcessUtils.shared.groupListValue = propertyValues
                    
                    if ProcessUtils.shared.userGroupsList.count == 0 {
                        DispatchQueue.main.async {
                            let button = UIButton()
//                            self.volunteerTapped(button)
                        }
                    }else if let data = ProcessUtils.shared.userGroupsList.first, ProcessUtils.shared.userGroupsList.count == 1 {
                        ProcessUtils.shared.selectedUserGroup = data
//                        DispatchQueue.main.async {
//                            self.setSelectedGroup(data: data)
//                        }
                    }
                    self.getLatestIncomingEvent()
                    
                }
                break
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
//                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
//                }
            }
        }
    }
    
//MARK: CollectionView Deletegate
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return gridData?.count ?? 0
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CSDashBaordCVC", for: indexPath) as! CSDashBaordCVC
//
//        cell.lblTitle.text = gridData?[indexPath.item].title
//        cell.lblCount.text = gridData?[indexPath.item].subTitle
//        cell.imgView.image = UIImage(named: gridData?[indexPath.item].icon ?? "")
//        cell.mainView.backgroundColor = gridData?[indexPath.item].bgColor
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! CSDashBaordCVC
//
//                UIView.transition(from: cell.mainView,
//                                  to: cell.mainView,
//                                  duration: 0.7,
//                                  options: [.transitionFlipFromLeft, .showHideTransitionViews]) { status in
//                    if status {
//                        self.openNextScreen(controller:self.gridData?[indexPath.row].key)
//                    }
//                }
////        self.openNextScreen(controller:self.gridData?[indexPath.row].key)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//         let cellWidth = (UIScreen.main.bounds.size.width - 6)/2
//
//        let height = (self.collectionview.frame.size.height - 20) / 2
//
//        return CGSize(width: cellWidth, height: height )
//
//    }
    
    
    //MARK: TableView Deletegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.latestEventData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VolunteerIncomingCell") as! VolunteerIncomingCell
        
        let rowModel = self.latestEventData?[indexPath.row]
        cell.setupContent(cellModel: rowModel)
        
        
        cell.btnView.tag = indexPath.row
        cell.btnView.addTarget(self, action: #selector(self.viewDetail(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
   
    
    @objc func viewDetail(_ sender:UIButton){
        let tag = sender.tag
        let rowModel = self.latestEventData?[tag]
        
        ENTALDControllers.shared.showEventDetailScreen(type: .ENTALDPUSH, from: self, data: rowModel, eventName: "latestEvent") { params, controller in
           

        }
        
        
        
        
        

//        ENTALDControllers.shared.showVolunteerEventDetailScreen(type: .ENTALDPUSH, from: self, dataObj: rowModel, eventType : "schedule" )  { params, controller in
//            self.getScheduleInfo()
//        }
    }
    
    
}
