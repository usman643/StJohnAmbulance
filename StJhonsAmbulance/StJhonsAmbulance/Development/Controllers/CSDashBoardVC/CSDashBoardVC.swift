//
//  CSDashBoardVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 24/01/2023.
//

import UIKit
import SideMenu


class CSDashBoardVC: ENTALDBaseViewController{
    var gridData : [DashBoardGridModel]?
    var latestEvent : [CurrentEventsModel]?
    var dashBoardOrder : DashBoardGridOrderModel?
    var params : [String:Any] = [:]
    let conId = UserDefaults.standard.contactIdToken ?? ""
    
    @IBOutlet weak var btnSideMenu: UIButton!
    @IBOutlet weak var lblGroupName: UILabel!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var btnMainView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnGroup: UIButton!
    @IBOutlet weak var lblLogoTitle: UILabel!
    
    @IBOutlet weak var btnGroupSelectView: UIButton!
    
    
    @IBOutlet weak var menuSelectedsImg: UIImageView!
    @IBOutlet weak var lblTabTitle: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
       
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        collectionView.register(UINib(nibName: "CSDashBaordCVC", bundle: nil), forCellWithReuseIdentifier: "CSDashBaordCVC")
        decorateUI()
//        getDashBoardOrder()
//        setSideMenu()
        
        gridData = [
                    DashBoardGridModel(title: "", subTitle: "", bgColor: UIColor.darkBlueColor, icon: "ic_camp",key: "sjavms_youthcamp"),
                    DashBoardGridModel(title: "Messages", subTitle: "", bgColor: UIColor.orangeRedColor, icon: "ic_message" ,key: "sjavms_messages"),
                    DashBoardGridModel(title: "Volunteers", subTitle: "", bgColor: UIColor.orangeColor, icon: "ic_communication" ,key:"sjavms_volunteers"),
                    DashBoardGridModel(title: "Events", subTitle: "", bgColor: UIColor.darkFrozeColor, icon: "ic_event", key: "sjavms_events"),
                    DashBoardGridModel(title: "Pending Shifts", subTitle: "", bgColor: UIColor.lightBlueColor, icon: "ic_hour",key: "sjavms_pendingshifts"),
                    DashBoardGridModel(title: "Pending Events", subTitle: "", bgColor: UIColor.themePrimaryColor, icon: "ic_pendingEvent", key: "sjavms_pendingevents")
                ]
        getDashBoardOrder()
        if (ProcessUtils.shared.selectedUserGroup == nil){
            if (ProcessUtils.shared.userGroupsList.count > 0 ){
                ProcessUtils.shared.selectedUserGroup = ProcessUtils.shared.userGroupsList[0]
                btnGroup.setTitle(ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupName() ?? "", for: .normal)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        btnGroup.setTitle(ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupName() ?? "", for: .normal)
        if ( self.latestEvent?.count == 0 || ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() != self.latestEvent?[0].msnfp_engagementopportunityid){
            getLatestUpcomingEvent()
        }
        
    }

    func decorateUI(){
        self.btnMainView.backgroundColor = UIColor.themePrimaryColor
        self.btnMainView.layer.cornerRadius = 3
        lblLogoTitle.textColor = UIColor.themePrimaryColor
        lblTabTitle.textColor = UIColor.themePrimaryColor
        lblTabTitle.font = UIFont.BoldFont(14)
        
        btnGroupSelectView.layer.cornerRadius = 3
        btnGroup.setTitleColor(UIColor.white, for: .normal)
        btnGroup.titleLabel?.font = UIFont.BoldFont(14)
        btnGroup.backgroundColor = UIColor.themePrimary
        
        lblGroupName.font = UIFont.BoldFont(16)
        lblGroupName.textColor = UIColor.themeBlackText
        self.view.backgroundColor = UIColor.themeWhiteText
        self.collectionView.backgroundColor = UIColor.themeWhiteText
    }

    @IBAction func selectGroupTapped(_ sender: Any) {
        showGroupsPicker()
    }
    @IBAction func sideMenuTapped(_ sender: Any) {
        present(menu!, animated: true)
    }
    
    
    @IBAction func openVolunteerScreen(_ sender: Any) {
        
        self.openNextScreecn(controller: "sjavms_volunteers")
    }
    
    @IBAction func openEventScreen(_ sender: Any) {
        self.openNextScreecn(controller: "sjavms_events")
        
    }
    
    @IBAction func openPendingShiftsScreen(_ sender: Any) {
        self.openNextScreecn(controller: "sjavms_pendingshifts")
        
    }
    
    @IBAction func openMessagesScreen(_ sender: Any) {
        self.openNextScreecn(controller: "sjavms_messages")
        
    }
    
    
    func getLatestUpcomingEvent(){
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() else {return}
        guard let currentDate = DateFormatManager.shared.getCurrentDateWithFormat(format: "yyyy/MM/dd") else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_startingdate,msnfp_location,msnfp_engagementopportunitystatus,_sjavms_program_value,_sjavms_program_value,msnfp_engagementopportunityid,sjavms_maxparticipants,msnfp_endingdate,msnfp_maximum,msnfp_minimum",
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(msnfp_groupid eq \(groupId)))",
            ParameterKeys.filter : "(statecode eq 0 and Microsoft.Dynamics.CRM.OnOrAfter(PropertyName='msnfp_endingdate',PropertyValue='\(currentDate)') and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002'])) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/msnfp_groupid eq \(groupId))))",
            ParameterKeys.orderby : "msnfp_startingdate asc,msnfp_engagementopportunitytitle asc",
            ParameterKeys.top : "1"
            
        ]
        
        self.getLatestUpcomingEventData(params: params)
    }
    
    fileprivate func getLatestUpcomingEventData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestLatestUpcomingEvent(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let eventData = response.value {
                    self.latestEvent = eventData
                    
                    var index = NSNotFound
                        
                        for i in (0..<(self.gridData?.count ?? 0 )){
                            if (self.gridData?[i].key ==  "sjavms_youthcamp"){
                                index = i
                            }
                        }
                    
                        if (self.latestEvent?.count != 0){
                            let date = DateFormatManager.shared.formatDateStrToStr(date: self.latestEvent?[0].msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "MMMM dd")
      
                            self.gridData?[index].title = self.latestEvent?[0].msnfp_engagementopportunitytitle ?? ""
                            self.gridData?[index].subTitle = date
                            
                            
                        }else{
                            self.gridData?[index].title =  "No Upcoming Event"
                            self.gridData?[index].subTitle = ""
                        }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
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
    
    
    fileprivate func getDashBoardOrder(){
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "statecode,sjavms_messages,sjavms_events,sjavms_checkin,sjavms_hours,sjavms_name,sjavms_myschedule,sjavms_dayofevent,sjavms_pendingevents,sjavms_csgrouplead,_sjavms_user_value,sjavms_volunteers,sjavms_youthcamp,sjavms_pendingshifts",
            ParameterKeys.filter : "(sjavms_csgrouplead eq true and statecode eq 0 and _sjavms_user_value eq \(UserDefaults.standard.contactIdToken ?? ""))",
            
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
                    if apidata.count > 0 {
                        self.dashBoardOrder = apidata[0]
                        var modeldata : [DashBoardGridModel] = []
                        
                        var _ = self.gridData?.compactMap({ model in
                            var model = model
                            
                            if model.key == "sjavms_youthcamp" {
                                model.order = self.dashBoardOrder?.sjavms_youthcamp
                            }else if model.key == "sjavms_messages" {
                                model.order = self.dashBoardOrder?.sjavms_messages
                            }else if model.key == "sjavms_volunteers" {
                                model.order = self.dashBoardOrder?.sjavms_volunteers
                            }else if model.key == "sjavms_events" {
                                model.order = self.dashBoardOrder?.sjavms_events
                            }else if model.key == "sjavms_pendingevents" {
                                model.order = self.dashBoardOrder?.sjavms_pendingevents
                            }else if model.key == "sjavms_pendingshifts" {
                                model.order = self.dashBoardOrder?.sjavms_pendingshifts
                            }
                            
                            modeldata.append(model)
                            return true
                        })
                        
                        self.gridData = modeldata
                        
                        self.gridData = self.gridData?.sorted {
                            $0.order ?? NSNotFound < $1.order ?? NSNotFound
                        }
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
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
               "sjavms_events": 4,
               "sjavms_pendingevents": 6,
               "sjavms_volunteers": 3,
               "sjavms_youthcamp": 1,
               "sjavms_pendingshifts": 5
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
            }else if model.key == "sjavms_volunteers" {
                model.order = 3
            }else if model.key == "sjavms_events" {
                model.order = 4
            }else if model.key == "sjavms_pendingshifts" {
                model.order = 5
            }else if model.key == "sjavms_pendingevents" {
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
                var message = error.message
                if error == .patchSuccess {
                    
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
    
    
    
    
    
    
    
    
    
    func showGroupsPicker(list:[LandingGroupsModel] = []){
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.groups, dataObj: ProcessUtils.shared.userGroupsList) { params, controller in
            
            if let data = params as? LandingGroupsModel {
                ProcessUtils.shared.selectedUserGroup = data
                self.getLatestUpcomingEvent()
                self.btnGroup.setTitle("\(data.msnfp_groupId?.getGroupName() ?? "")", for: .normal)
                
            }
        }
    }
    
    
    
    func openNextScreecn(controller:String?){
        if controller == "sjavms_youthcamp" {
            if !(self.latestEvent?.isEmpty ?? false){
                ENTALDControllers.shared.showEventManageScreen(type: .ENTALDPUSH, from: self, data: self.latestEvent?.first) { params, controller in
                    self.openNextScreecn(controller: params as? String)
                }
            }
        }else if controller == "sjavms_messages" {
            
            ENTALDControllers.shared.showMessageScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreecn(controller: params as? String)
            }
        }else if controller == "sjavms_volunteers" {
            
            ENTALDControllers.shared.showVolunteersScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreecn(controller: params as? String)
            }
        }else if controller == "sjavms_events" {
            
            ENTALDControllers.shared.showEventScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreecn(controller: params as? String)
            }
        }else if controller == "sjavms_pendingshifts" {
            
            ENTALDControllers.shared.showPendingShiftScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreecn(controller: params as? String)
            }
        }else if controller == "sjavms_pendingevents" {
            
            ENTALDControllers.shared.showPendingEventScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreecn(controller: params as? String)
            }
        }
    }
    
    
    
    
}

extension CSDashBoardVC : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate,UICollectionViewDropDelegate {
    
    
    
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         let cellWidth = (UIScreen.main.bounds.size.width - 6)/2

        let height = (self.collectionView.frame.size.height - 10 ) / 3
        
        return CGSize(width: cellWidth, height: height )
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        
        let cell = collectionView.cellForItem(at: indexPath) as! CSDashBaordCVC
        
        UIView.transition(from: cell.mainView,
                          to: cell.mainView,
                          duration: 0.7,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews]) { status in
            if status {
                self.openNextScreecn(controller:self.gridData?[indexPath.row].key)
            }
        }
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
            "sjavms_csgrouplead" : true,
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
 
}



