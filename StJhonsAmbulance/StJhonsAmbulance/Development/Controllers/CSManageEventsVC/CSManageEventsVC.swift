//
//  CSManageEventsVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 27/09/2023.
//

import UIKit

class CSManageEventsVC: ENTALDBaseViewController,UITextFieldDelegate {
    
    var pendingApprovalData : [PendingApprovalEventsModel]?
    var pendingPublishData : [CurrentEventsModel]?
    var currentEventData : [CurrentEventsModel]?
    var upcomingEventData : [CurrentEventsModel]?
    var pastEventData : [CurrentEventsModel]?
    
    var filterCurrentEventData : [CurrentEventsModel]?
    var filterUpcomingEventData : [CurrentEventsModel]?
    var filterPastEventData : [CurrentEventsModel]?
    var filterPendingApprovalData : [PendingApprovalEventsModel]?
    var filterPendingPublishData : [CurrentEventsModel]?
    
    
    var isAvaiableEvent = false
    var isPendingApprovalEvent = false
    var isUnpublishEvent = false
    var isPastEvent = false
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var selectGroupView: UIView!
    @IBOutlet weak var btnSelectGroup: UIButton!
    
    @IBOutlet weak var searchMainView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var textSearch: UITextField!
    
    @IBOutlet weak var btnAvailable: UIButton!
    @IBOutlet weak var btnPendingApproval: UIButton!
    @IBOutlet weak var btnUnnpublish: UIButton!
    @IBOutlet weak var btnPast: UIButton!
    
    @IBOutlet weak var btnAvailableView: UIView!
    @IBOutlet weak var btnPendingApprovalView: UIView!
    @IBOutlet weak var btnUnnpublishView: UIView!
    @IBOutlet weak var btnPastView: UIView!
    
    @IBOutlet weak var availableView: UIView!
    @IBOutlet weak var pendingApprovalView: UIView!
    @IBOutlet weak var unpublishView: UIView!
    @IBOutlet weak var pastView: UIView!
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var availableTableView: UITableView!
    @IBOutlet weak var pendingApprovalTableView: UITableView!
    @IBOutlet weak var unpublishTableView: UITableView!
    @IBOutlet weak var pastTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textSearch.delegate = self
        decorateUI()
        textSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        setupTableView()
        getCurrentEvents()
        getPastEvents()
        getpendingPublish()
        getPendingApproval()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        btnSelectGroup.setTitle(ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupName() ?? "", for: .normal)
    }

    func decorateUI(){
        
        if (ProcessUtils.shared.selectedUserGroup == nil){
            if (ProcessUtils.shared.userGroupsList.count > 0 ){
                ProcessUtils.shared.selectedUserGroup = ProcessUtils.shared.volunteerGroupsList[0]
                btnSelectGroup.setTitle(ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupName() ?? "", for: .normal)
            }
        }
        
        headerView.addBottomShadow()
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        btnSelectGroup.backgroundColor = UIColor.themeSecondry
        btnSelectGroup.layer.cornerRadius = 3
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        btnSelectGroup.setTitleColor(UIColor.textWhiteColor, for: .normal)
        
        btnAvailableView.backgroundColor = UIColor.themePrimaryColor
        btnPendingApprovalView.backgroundColor = UIColor.themePrimaryColor
        btnUnnpublishView.backgroundColor = UIColor.themePrimaryColor
        btnPastView.backgroundColor = UIColor.themePrimaryColor
        
        resetButtonView()
        isAvaiableEvent = true
        btnAvailable.setTitleColor(UIColor.themePrimaryColor, for: .normal)
        btnAvailableView.isHidden = false
        availableView.isHidden = false
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func messageTapped(_ sender: Any) {
        
        ENTALDControllers.shared.showGroupMessageVC(type: .ENTALDPUSH, from: self, callBack: nil)
    }
    
    @IBAction func availableTapped(_ sender: Any) {
        
        resetButtonView()
        isAvaiableEvent = true
        btnAvailable.setTitleColor(UIColor.themePrimaryColor, for: .normal)
        btnAvailableView.isHidden = false
        availableView.isHidden = false
        
        if ((filterCurrentEventData?.count ?? 0) == 0){
            self.emptyView.isHidden = false
        }
    }
    
    @IBAction func pendingApprovalTapped(_ sender: Any) {
        resetButtonView()
        isPendingApprovalEvent = true
        btnPendingApproval.setTitleColor(UIColor.themePrimaryColor, for: .normal)
        btnPendingApprovalView.isHidden = false
        pendingApprovalView.isHidden = false
        if ((filterPendingApprovalData?.count ?? 0) == 0){
            self.emptyView.isHidden = false
        }
    }
    
    @IBAction func unpublishTapped(_ sender: Any) {
        resetButtonView()
        isUnpublishEvent = true
        btnUnnpublish.setTitleColor(UIColor.themePrimaryColor, for: .normal)
        btnUnnpublishView.isHidden = false
        unpublishView.isHidden = false
        if ((filterPendingPublishData?.count ?? 0) == 0){
            self.emptyView.isHidden = false
        }
    }
    
    @IBAction func pastTapped(_ sender: Any) {
        resetButtonView()
        isPastEvent = true
        btnPast.setTitleColor(UIColor.themePrimaryColor, for: .normal)
        btnPastView.isHidden = false
        pastView.isHidden = false
        if ((filterPastEventData?.count ?? 0) == 0){
            self.emptyView.isHidden = false
        }
    }
    
    @IBAction func selectGroupTapped(_ sender: Any) {
        showGroupsPicker()
    }
    
    
    
    func setupTableView(){

        availableTableView.delegate = self
        pendingApprovalTableView.delegate = self
        unpublishTableView.delegate = self
        pastTableView.delegate = self
        
        availableTableView.dataSource = self
        pendingApprovalTableView.dataSource = self
        unpublishTableView.dataSource = self
        pastTableView.dataSource = self
        
        availableTableView.register(UINib(nibName: "ManagerEventPendingCell", bundle: nil), forCellReuseIdentifier: "ManagerEventPendingCell")
        pendingApprovalTableView.register(UINib(nibName: "ManagerEventPendingCell", bundle: nil), forCellReuseIdentifier: "ManagerEventPendingCell")
        unpublishTableView.register(UINib(nibName: "ManagerEventPendingCell", bundle: nil), forCellReuseIdentifier: "ManagerEventPendingCell")
        pastTableView.register(UINib(nibName: "ManagerEventPendingCell", bundle: nil), forCellReuseIdentifier: "ManagerEventPendingCell")
        
        
        
    }
    
    func resetButtonView(){
        
        btnAvailable.setTitleColor( UIColor.gray, for: .normal)
        btnPendingApproval.setTitleColor( UIColor.gray, for: .normal)
        btnUnnpublish.setTitleColor( UIColor.gray, for: .normal)
        btnPast.setTitleColor( UIColor.gray, for: .normal)
        
        btnAvailableView.isHidden = true
        btnPendingApprovalView.isHidden = true
        btnUnnpublishView.isHidden = true
        btnPastView.isHidden = true
        
        isAvaiableEvent = false
        isPendingApprovalEvent = false
        isUnpublishEvent = false
        isPastEvent = false
        
        availableView.isHidden = true
        pendingApprovalView.isHidden = true
        unpublishView.isHidden = true
        pastView.isHidden = true
        emptyView.isHidden = true
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (isAvaiableEvent == true){
            
            
            
        }else if (isPendingApprovalEvent == true){
            
        }else if (isUnpublishEvent == true){
            
        }else if (isPastEvent == true){
            
        }
    }
    
    
    func getPendingApproval(){
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupId() else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "sjavms_name,sjavms_address1name,sjavms_maxvolunteers,sjavms_eventstartdate,statecode,_sjavms_program_value,sjavms_eventrequestid",
            ParameterKeys.expand : "sjavms_msnfp_group_sjavms_eventrequest($filter=(msnfp_groupid eq \(groupId)))",
            ParameterKeys.filter : "(statecode eq 0 and (statuscode eq 1 or statuscode eq 802280002)) and (sjavms_msnfp_group_sjavms_eventrequest/any(o1:(o1/msnfp_groupid eq \(groupId))))",
                        ParameterKeys.orderby : "sjavms_eventstartdate asc"
        ]
        
        self.getPendingApprovalsData(params: params)
    }
    
    func showGroupsPicker(list:[LandingGroupsModel] = []){
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.groups, dataObj: ProcessUtils.shared.userGroupsList) { params, controller in
            
            if let data = params as? LandingGroupsModel {
                ProcessUtils.shared.selectedUserGroup = data
                self.getCurrentEvents()
                self.btnSelectGroup.setTitle("\(data.sjavms_groupid?.getGroupName() ?? "")", for: .normal)
                
            }
        }
    }
    
    fileprivate func getPendingApprovalsData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestApprovalPendingApproval(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let pendingData = response.value {
                    self.pendingApprovalData = pendingData
                    
                    
                    self.pendingApprovalTimefilter()
                    
                    self.pendingApprovalData = self.pendingApprovalData?.sorted(by: { $0.sjavms_eventstartdate ?? "" < $1.sjavms_eventstartdate ?? "" })
                    
                    
                    self.filterPendingApprovalData = self.pendingApprovalData
                    
                    DispatchQueue.main.async {
                        self.pendingApprovalTableView.reloadData()
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
    func getpendingPublish(){
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupId() else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_location,msnfp_minimum,msnfp_startingdate,msnfp_endingdate,msnfp_engagementopportunitystatus,_sjavms_program_value,msnfp_engagementopportunityid,msnfp_maximum,_sjavms_contact_value,sjavms_maxparticipants",
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(msnfp_groupid eq \(groupId)))",
            ParameterKeys.filter : "(msnfp_engagementopportunitystatus eq 844060000) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/msnfp_groupid eq \(groupId))))",
            ParameterKeys.orderby : "msnfp_startingdate asc"
        ]
        
        self.getPendingPublishData(params: params)
    }
    
    fileprivate func getPendingPublishData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestPendingPublishEvents(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let pendingData = response.value {
                    self.pendingPublishData = pendingData
                    self.filterPendingPublishData = pendingData
                    self.pendingTimefilter()
                    
                    self.pendingPublishData = self.pendingPublishData?.sorted(by: { $0.msnfp_startingdate ?? "" < $1.msnfp_startingdate ?? "" })
                    self.filterPendingPublishData = self.pendingPublishData
                    
                    DispatchQueue.main.async {
                        self.unpublishTableView.reloadData()
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

    fileprivate func updatedata(eventId:String? , status:Int?){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        let params : [String:Any] = [ "sjavms_volunteerrequeststatus" : status ?? 0]
//        let eventId = self.eventData?.msnfp_engagementopportunityid ?? ""

        ENTALDLibraryAPI.shared.approvePendingEvent(eventId: eventId ?? "", params: params) { result in
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
                    self.getPendingApproval()
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
    
    
    
    @objc func updateEvent(_ sender:UIButton){
        
        let alert = UIAlertController(title: "Approval", message: "Do you want to approve event", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Approve", style: .default, handler: { action in
            let index = sender.tag
            
            let eventid = self.filterPendingApprovalData?[index].sjavms_eventrequestid
            self.updatedata(eventId: eventid, status: 802280000)
        }))
        alert.addAction(UIAlertAction(title: "Decline", style: .default, handler: { action in
            let index = sender.tag
            
            let eventid = self.filterPendingApprovalData?[index].sjavms_eventrequestid
            self.updatedata(eventId: eventid, status: 802280001)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
            
        }))
        
//        if let popoverController = alert.popoverPresentationController {
//            popoverController.sourceView = pointView
//            popoverController.sourceRect = pointView.bounds
//        }
        
        present(alert, animated: true)
    }
    
    func pendingTimefilter(){
        
        var minusTime : [CurrentEventsModel]  = []
        var plusTime : [CurrentEventsModel] = []
        if ((self.pendingPublishData?.count ?? 0) > 0){
            for i in (0 ..< (self.pendingPublishData?.count ?? 0) - 1){
                
                let eventDate = DateFormatManager.shared.getDateFromString(date: self.pendingPublishData?[i].msnfp_startingdate) ?? Date()
                let currentDate = DateFormatManager.shared.getCurrentDate()
                let calendar = Calendar.current
                
                let components = calendar.dateComponents([.minute, .second], from: currentDate, to: eventDate)
                self.pendingPublishData?[i].time_difference = components.minute
                
                if ((self.pendingPublishData?[i].time_difference ?? 0) >= 0){
                    
                    if let data = self.pendingPublishData?[i] {
                        plusTime.append(data)
                    }
                    
                }else{
                    
                    if let data = self.pendingPublishData?[i] {
                        minusTime.append(data)
                    }
                }
            }
            plusTime = plusTime.sorted(by: { ($0.time_difference ?? 0) < ($1.time_difference ?? 0) })
            //            minusTime = minusTime.sorted(by: { $0.time_difference ?? 0 < $1.time_difference ?? 0 })
            self.pendingPublishData = []
            self.pendingPublishData?.append(contentsOf: plusTime)
            //            self.latestEventData?.append(contentsOf: minusTime)

        }
    }
    
    func pendingApprovalTimefilter(){
        
        var minusTime : [PendingApprovalEventsModel]  = []
        var plusTime : [PendingApprovalEventsModel] = []
        if ((self.pendingApprovalData?.count ?? 0) > 0){
            for i in (0 ..< (self.pendingApprovalData?.count ?? 0) - 1){
                
                let eventDate = DateFormatManager.shared.getDateFromString(date: self.pendingApprovalData?[i].sjavms_eventstartdate) ?? Date()
                let currentDate = DateFormatManager.shared.getCurrentDate()
                let calendar = Calendar.current
                
                let components = calendar.dateComponents([.minute, .second], from: currentDate, to: eventDate)
                self.pendingApprovalData?[i].time_difference = components.minute
                
                if ((self.pendingApprovalData?[i].time_difference ?? 0) >= 0){
                    
                    if let data = self.pendingApprovalData?[i] {
                        plusTime.append(data)
                    }
                    
                }else{
                    
                    if let data = self.pendingApprovalData?[i] {
                        minusTime.append(data)
                    }
                }
            }
            plusTime = plusTime.sorted(by: { ($0.time_difference ?? 0) < ($1.time_difference ?? 0) })
            //            minusTime = minusTime.sorted(by: { $0.time_difference ?? 0 < $1.time_difference ?? 0 })
            self.pendingApprovalData = []
            self.pendingApprovalData?.append(contentsOf: plusTime)
            //            self.latestEventData?.append(contentsOf: minusTime)
            
            
        }
    }

    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
    
    
    func getCurrentEvents(){
        
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupId() else {return}
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_startingdate,msnfp_location,msnfp_engagementopportunitystatus,_sjavms_program_value,msnfp_engagementopportunityid,msnfp_endingdate,msnfp_maximum,msnfp_minimum",
            
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(msnfp_groupid eq \(groupId)))",
            ParameterKeys.filter : "(statecode eq 0 and sjavms_adhocevent ne true and Microsoft.Dynamics.CRM.Today(PropertyName='msnfp_startingdate') and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002'])) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/msnfp_groupid eq \(groupId))))",
            ParameterKeys.orderby : "msnfp_engagementopportunitytitle asc"
            
        ]
        
        self.getCurrentEventData(params: params)
        
    }
    
    
    fileprivate func getCurrentEventData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestCurrentEvents(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
//            self.getUpcomingEvents()
            switch result{
            case .success(value: let response):
                DispatchQueue.main.async{
                if let currentEvent = response.value {
                    self.currentEventData = currentEvent
                    self.filterCurrentEventData = currentEvent
                    if (self.currentEventData?.count == 0 || self.currentEventData?.count == nil){
                            self.emptyView.isHidden = false
                    }else{
                            self.emptyView.isHidden = true
                    }
                        self.availableTableView.reloadData()
                    
                }else{
                    self.emptyView.isHidden = false
                }
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
               
                self.emptyView.isHidden = false
                
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    
    // Upcoming Events API
    
//    func getUpcomingEvents(){
//
//        guard let groupId = ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupId() else {return}
//
//        let params : [String:Any] = [
//
//            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_startingdate,msnfp_location,msnfp_engagementopportunitystatus,_sjavms_program_value,_sjavms_program_value,msnfp_engagementopportunityid,sjavms_maxparticipants,msnfp_endingdate,msnfp_maximum,msnfp_minimum",
//
//            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(msnfp_groupid eq \(groupId)))",
//            ParameterKeys.filter : "(statecode eq 0 and sjavms_adhocevent ne true and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002']) and (Microsoft.Dynamics.CRM.Tomorrow(PropertyName='msnfp_startingdate') or Microsoft.Dynamics.CRM.NextXYears(PropertyName='msnfp_startingdate',PropertyValue=10))) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/msnfp_groupid eq \(groupId))))",
//            ParameterKeys.orderby : "msnfp_engagementopportunitytitle asc"
//
//        ]
//
//        self.getUpcomingEventData(params: params)
//
//    }
    
    
//    fileprivate func getUpcomingEventData(params : [String:Any]){
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
//
//        ENTALDLibraryAPI.shared.requestUpcomingEvents(params: params){ result in
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }
//            self.getPastEvents()
//            switch result{
//            case .success(value: let response):
//
//                if let upcomingEvent = response.value {
//                    self.upcomingEventData = upcomingEvent
//                    self.filterUpcomingEventData = upcomingEvent
//                    if (self.upcomingEventData?.count == 0 || self.upcomingEventData?.count == nil){
//                        self.showEmptyView(tableVw: self.upcomingTableView)
//                    }else{
//                        DispatchQueue.main.async {
//                            for subview in self.upcomingTableView.subviews {
//                                subview.removeFromSuperview()
//                            }
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        self.upcomingTableView.reloadData()
//                    }
//                }else{
//                    self.showEmptyView(tableVw: self.upcomingTableView)
//                }
//
//            case .error(let error, let errorResponse):
//                var message = error.message
//                if let err = errorResponse {
//                    message = err.error
//                }
//                self.showEmptyView(tableVw: self.currentTableView)
//                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
//                }
//            }
//        }
//    }
    
    // ================ Past Event API =================
    
    
    func getPastEvents(){
        
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupId() else {return}
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_startingdate,msnfp_endingdate,msnfp_location,msnfp_engagementopportunitystatus,_sjavms_program_value,msnfp_engagementopportunityid",
            
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(msnfp_groupid eq \(groupId)))",
            ParameterKeys.filter : "(statecode eq 0 and sjavms_adhocevent ne true and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002']) and (Microsoft.Dynamics.CRM.Yesterday(PropertyName='msnfp_startingdate') or Microsoft.Dynamics.CRM.LastXYears(PropertyName='msnfp_startingdate',PropertyValue=10))) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/msnfp_groupid eq \(groupId))))",
            ParameterKeys.orderby : "msnfp_engagementopportunitytitle asc"
            
        ]
        
        self.getPastEventData(params: params)
        
    }
    
    
    fileprivate func getPastEventData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestPastEvents(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let pastEvent = response.value {
                    self.pastEventData = pastEvent
                    self.filterPastEventData = pastEvent
                    DispatchQueue.main.async {
                        self.pastTableView.reloadData()
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



extension CSManageEventsVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getNumberofRow(tableView : tableView)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if (tableView == self.availableTableView){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ManagerEventPendingCell", for: indexPath) as! ManagerEventPendingCell
            let rowModel = self.filterCurrentEventData?[indexPath.row]

//            cell.delegate = self
            cell.eventdata  = rowModel

            cell.lblTitle.text = rowModel?.msnfp_engagementopportunitytitle ?? ""
            cell.lblLocation.text = rowModel?.msnfp_location ?? ""
            cell.lblDateTime.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
            cell.lblProgram.text = rowModel?.sjavms_program_value ?? ""
            cell.lblparticipants.text = "\(rowModel?.msnfp_minimum ?? 0)"
            
            cell.btnDetail.addTarget(self, action:#selector(showManageDetail(_:)), for:.touchUpInside)
            
            
            return cell
            
            
        }else if(tableView == self.pastTableView){
            
            let  cell = tableView.dequeueReusableCell(withIdentifier: "ManagerEventPendingCell", for: indexPath) as! ManagerEventPendingCell
           
            
            let rowModel = self.filterPastEventData?[indexPath.row]
            
            cell.lblTitle.text = rowModel?.msnfp_engagementopportunitytitle ?? ""
            cell.lblLocation.text = rowModel?.msnfp_location ?? ""
            cell.lblDateTime.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
            cell.lblProgram.text = rowModel?.sjavms_program_value ?? ""
            cell.lblparticipants.text = "\(rowModel?.msnfp_minimum ?? 0)"
            
            cell.btnDetail.addTarget(self, action:#selector(showManageDetail(_:)), for:.touchUpInside)
            return cell
            
        }else if (tableView == self.pendingApprovalTableView){
            
            let  cell = tableView.dequeueReusableCell(withIdentifier: "ManagerEventPendingCell", for: indexPath) as! ManagerEventPendingCell
            let rowModel = self.filterPendingApprovalData?[indexPath.row]
            
            cell.lblTitle.text = rowModel?.sjavms_name ?? ""
            cell.lblLocation.text = rowModel?.sjavms_address1name ?? ""
//            cell.lblHour.text = "\(rowModel?.time_difference ?? 0 )"
            cell.lblDateTime.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.sjavms_eventstartdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
            cell.lblparticipants.text = "\(rowModel?.sjavms_maxvolunteers ?? 0)"
            cell.lblProgram.text = rowModel?.sjavms_program_value ?? ""
            
            cell.btnDetail.addTarget(self, action:#selector(showManageDetail(_:)), for:.touchUpInside)
            return cell
            
        }else if (tableView == self.unpublishTableView){
            
            let  cell = tableView.dequeueReusableCell(withIdentifier: "ManagerEventPendingCell", for: indexPath) as! ManagerEventPendingCell
            let rowModel = self.filterPendingPublishData?[indexPath.row]
        
            cell.lblTitle.text = rowModel?.msnfp_engagementopportunitytitle ?? ""
            cell.lblLocation.text = rowModel?.msnfp_location ?? ""
//            cell.lblHour.text = "\(rowModel?.time_difference ?? 0 )"
            cell.lblDateTime.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
            cell.lblparticipants.text = ((rowModel?.msnfp_maximum) != nil) ? "\(rowModel?.msnfp_maximum ?? 0)" : ""
            cell.lblProgram.text = rowModel?.sjavms_program_value ?? ""
            
            cell.btnDetail.addTarget(self, action:#selector(showManageDetail(_:)), for:.touchUpInside)
            return cell
        }
        let cells = tableView.dequeueReusableCell(withIdentifier: "ManagerEventPendingCell", for: indexPath) as! ManagerEventPendingCell
        return cells
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if (tableView == availableTableView){
            
            ENTALDControllers.shared.showEventDetailScreen(type: .ENTALDPUSH, from: self, data: self.filterCurrentEventData?[indexPath.row], eventName: "availableEvent", callBack: nil)

        }else if (tableView == pastTableView){
            
            ENTALDControllers.shared.showEventDetailScreen(type: .ENTALDPUSH, from: self, data: self.filterPastEventData?[indexPath.row], eventName: "pastEvent", callBack: nil)
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

//        if (tableView == self.availableTableView){
//            
//            ENTALDControllers.shared.showEventManageScreen(type: .ENTALDPUSH, from: self, data:self.filterCurrentEventData?[indexPath.row], callBack: nil)
//        }else if(tableView == self.pastTableView){
//            
//            ENTALDControllers.shared.showEventManageScreen(type: .ENTALDPUSH, from: self, data:self.filterPastEventData?[indexPath.row], callBack: nil)
//        }else if (tableView == self.unpublishTableView){
//            
//            let eventdata = self.filterPendingPublishData?[indexPath.row]
//            
//            ENTALDControllers.shared.showEventSummaryScreen(type: .ENTALDPUSH, from: self , dataObj: eventdata) { params, controller in
//                
//            }
//        }
    }
    
    @objc func showManageDetail(_ sender:UIButton ){
        
        let index = sender.tag
        
        
        if (isAvaiableEvent == true){
            
            ENTALDControllers.shared.showEventManageScreen(type: .ENTALDPUSH, from: self, data:self.filterCurrentEventData?[index], callBack: nil)
            
        }else if(isPastEvent == true){
            
            ENTALDControllers.shared.showEventManageScreen(type: .ENTALDPUSH, from: self, data:self.filterPastEventData?[index], callBack: nil)
        }else if (isUnpublishEvent == true){
            
            let eventdata = self.filterPendingPublishData?[index]
            
            ENTALDControllers.shared.showEventSummaryScreen(type: .ENTALDPUSH, from: self , dataObj: eventdata) { params, controller in
                
            }
        }else if (isPendingApprovalEvent == true){
            
            let eventdata = self.filterPendingApprovalData?[index]
            
            ENTALDControllers.shared.showEventSummaryScreen(type: .ENTALDPUSH, from: self , dataObj: eventdata) { params, controller in
                
            }
        }
        
        
    }

    func getNumberofRow(tableView : UITableView) -> Int{
        if (tableView == availableTableView){
            
            if ((filterCurrentEventData?.count ?? 0) > 0){
                return filterCurrentEventData?.count ?? 0
            }else{
//                self.emptyView.isHidden = true
            }
            
        }else if (tableView == pendingApprovalTableView){
            
            if ((filterPendingApprovalData?.count ?? 0) > 0){
                return filterPendingApprovalData?.count ?? 0
            }else{
//                self.emptyView.isHidden = true
            }
            
        }else if (tableView == unpublishTableView){
            if ((filterPendingPublishData?.count ?? 0) > 0){
                return filterPendingPublishData?.count ?? 0
            }else{
//                self.emptyView.isHidden = true
            }
            
        }else if (tableView == pastTableView){
            if ((filterPastEventData?.count ?? 0) > 0){
                return filterPastEventData?.count ?? 0
            }else{
//                self.emptyView.isHidden = true
            }
            
        }else {
//            self.emptyView.isHidden = true
            return 0
        }
        return 0
    }
    
}
