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
    
    var allPorgram = ProcessUtils.shared.programsData
    
    var isAvaiableEvent = false
    var isPendingApprovalEvent = false
    var isUnpublishEvent = false
    var isPastEvent = false
    
    var isAvaiableLoadMoreShow = true
    var isPendingApprovalLoadMoreShow = true
    var isUnpublishLoadMoreShow = true
    var isPastLoadMoreShow = true
    
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSelectedGroup: UILabel!
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
    
    @IBOutlet weak var availableLoadMoreView: UIView!
    @IBOutlet weak var btnnAvailableLoadMore: UIButton!
    @IBOutlet weak var pendingLoadMoreView: UIView!
    @IBOutlet weak var btnnPendingLoadMore: UIButton!
    @IBOutlet weak var unpublishLoadMoreView: UIView!
    @IBOutlet weak var btnUpublishLoadMore: UIButton!
    @IBOutlet weak var pastLoadMoreView: UIView!
    @IBOutlet weak var btnnPastLoadMore: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        textSearch.delegate = self
        decorateUI()
        textSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        setupTableView()
        self.getAllProgramesfile( completion: {status in
            
            self.getPendingApproval()
            self.getCurrentEvents()
            self.getPastEvents()
            self.getpendingPublish()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
//        btnSelectGroup.setTitle(ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupName() ?? "", for: .normal)
        lblSelectedGroup.text =  ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupName() ?? ""
    }

    func decorateUI(){
        
        if (ProcessUtils.shared.selectedUserGroup == nil){
            if (ProcessUtils.shared.userGroupsList.count > 0 ){
                ProcessUtils.shared.selectedUserGroup = ProcessUtils.shared.userGroupsList[0]
//                btnSelectGroup.setTitle(ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupName() ?? "", for: .normal)
                lblSelectedGroup.text = ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupName() ?? ""
            }
        }
        lblTitle.font = UIFont.HeaderBoldFont(18)
        lblTitle.textColor = UIColor.headerGreen
        headerView.addBottomShadow()
        btnSelectGroup.backgroundColor = UIColor.clear
        btnSelectGroup.layer.cornerRadius = 3
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        btnSelectGroup.setTitleColor(UIColor.textWhiteColor, for: .normal)
        
        lblSelectedGroup.font = UIFont.BoldFont(14)
        lblSelectedGroup.textColor = UIColor.textWhiteColor
        
        btnAvailableView.backgroundColor = UIColor.themePrimaryColor
        btnPendingApprovalView.backgroundColor = UIColor.themePrimaryColor
        btnUnnpublishView.backgroundColor = UIColor.themePrimaryColor
        btnPastView.backgroundColor = UIColor.themePrimaryColor
        
        resetButtonView()
        isPendingApprovalEvent = true
        btnPendingApproval.setTitleColor(UIColor.themePrimaryColor, for: .normal)
        btnPendingApprovalView.isHidden = false
        pendingApprovalView.isHidden = false
        
        btnAvailable.titleLabel?.font = UIFont.BoldFont(16)
        btnPendingApproval.titleLabel?.font = UIFont.BoldFont(16)
        btnUnnpublish.titleLabel?.font = UIFont.BoldFont(16)
        btnPast.titleLabel?.font = UIFont.BoldFont(16)
        
        let originalImage = UIImage(named: "messages-bubble-square-text")!
        let tintedImage = ProcessUtils.shared.tintImage(originalImage)
        btnMessage.setImage(tintedImage, for: .normal)
        
        btnnAvailableLoadMore.titleLabel?.font = UIFont.MediumFont(16)
        btnnPendingLoadMore.titleLabel?.font = UIFont.MediumFont(16)
        btnUpublishLoadMore.titleLabel?.font = UIFont.MediumFont(16)
        btnnPastLoadMore.titleLabel?.font = UIFont.MediumFont(16)
        
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
    
    
    
    @IBAction func pastLoadMoreTapped(_ sender: Any) {
        isPastLoadMoreShow = false
        DispatchQueue.main.async {
            self.pastLoadMoreView.isHidden = true
            self.pastTableView.reloadData()
        }
    }
    
    @IBAction func pendingLoadMoreTapped(_ sender: Any) {
        isPendingApprovalLoadMoreShow = false
        DispatchQueue.main.async {
            self.pendingLoadMoreView.isHidden = true
            self.pendingApprovalTableView.reloadData()
        }
    }
       
    @IBAction func unpublishLoadMoreTapped(_ sender: Any) {
        isUnpublishLoadMoreShow = false
        DispatchQueue.main.async {
            self.unpublishLoadMoreView.isHidden = true
            self.unpublishTableView.reloadData()
        }
    }
    
    @IBAction func availableLoadMoreTapped(_ sender: Any) {
        isAvaiableLoadMoreShow = false
        DispatchQueue.main.async {
            self.availableLoadMoreView.isHidden = true
            self.availableTableView.reloadData()
            self.view.layoutIfNeeded()
        }
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
        
        btnAvailable.setTitleColor( UIColor.hexString(hex: "6E6E6E"), for: .normal)
        btnPendingApproval.setTitleColor( UIColor.hexString(hex: "6E6E6E"), for: .normal)
        btnUnnpublish.setTitleColor( UIColor.hexString(hex: "6E6E6E"), for: .normal)
        btnPast.setTitleColor( UIColor.hexString(hex: "6E6E6E"), for: .normal)
        
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
    
    
    func showGroupsPicker(list:[LandingGroupsModel] = []){
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.groups, dataObj: ProcessUtils.shared.userGroupsList) { params, controller in
            
            if let data = params as? LandingGroupsModel {
                ProcessUtils.shared.selectedUserGroup = data
                self.getCurrentEvents()
                self.getPendingApproval()
                self.getpendingPublish()
                self.getPastEvents()
//                self.btnSelectGroup.setTitle("\(data.sjavms_groupid?.getGroupName() ?? "")", for: .normal)
                self.lblSelectedGroup.text = "\(data.sjavms_groupid?.getGroupName() ?? "")"
                
            }
        }
    }
    
    func getPendingApproval(){
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupId() else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "sjavms_name,sjavms_address1name,sjavms_maxvolunteers,sjavms_eventstartdate,statecode,_sjavms_program_value,sjavms_eventrequestid",
            ParameterKeys.expand : "sjavms_msnfp_group_sjavms_eventrequest($filter=(msnfp_groupid eq \(groupId)))",
        
            ParameterKeys.filter : "(statecode eq 0 and (statuscode eq 1 or statuscode eq 802280002)) and (sjavms_msnfp_group_sjavms_eventrequest/any(o1:(o1/msnfp_groupid eq \(groupId))))"
        ]

        self.getPendingApprovalsData(params: params)
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
                DispatchQueue.main.async{
                    if let pendingData = response.value {
                        self.pendingApprovalData = pendingData
                        
                        // time filter
                        // self.pendingApprovalTimefilter()
                        
                        self.pendingApprovalData = self.pendingApprovalData?.sorted(by: { $0.sjavms_eventstartdate ?? "" < $1.sjavms_eventstartdate ?? "" })
                        
                        if (self.pendingApprovalData?.count == 0 || self.pendingApprovalData?.count == nil){
                            self.emptyView.isHidden = false
                        }else{
                            self.emptyView.isHidden = true
                        }
                        //                        self.pendingApprovalTableView.reloadData()
                        
                        self.filterPendingApprovalData = self.pendingApprovalData
                        
                        
                        self.pendingApprovalTableView.reloadData()
                    }else{
                        self.emptyView.isHidden = false
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
            
            
//            ParameterKeys.orderby : "msnfp_startingdate asc"
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
//                    self.pendingTimefilter()
                    
                    self.pendingPublishData = self.pendingPublishData?.sorted(by: { $0.msnfp_endingdate ?? "" < $1.msnfp_endingdate ?? "" })
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
            if (plusTime.count > 0){
                plusTime = plusTime.sorted(by: { ($0.time_difference ?? 0) < ($1.time_difference ?? 0) })
                
                //            minusTime = minusTime.sorted(by: { $0.time_difference ?? 0 < $1.time_difference ?? 0 })
                self.pendingPublishData = []
                self.pendingPublishData?.append(contentsOf: plusTime)
            }else{
                self.pendingPublishData = []
            }
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
            if (plusTime.count > 0){
                plusTime = plusTime.sorted(by: { ($0.time_difference ?? 0) < ($1.time_difference ?? 0) })
                //            minusTime = minusTime.sorted(by: { $0.time_difference ?? 0 < $1.time_difference ?? 0 })
                self.pendingApprovalData = []
                self.pendingApprovalData?.append(contentsOf: plusTime)
            }else{
                self.pendingApprovalData = []
            }
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
//                    if (self.currentEventData?.count == 0 || self.currentEventData?.count == nil){
//                            self.emptyView.isHidden = false
//                    }else{
//                            self.emptyView.isHidden = true
//                    }
                        self.availableTableView.reloadData()
                    
                }else{
//                    self.emptyView.isHidden = false
                }
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
               
//                self.emptyView.isHidden = false
                
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
    
    private func getAllProgramesfile( completion: @escaping(_ status:Bool)->Void) {
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestAllProgram(params: [:]){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let pastEvent = response.value {
                    self.allPorgram = pastEvent
                    ProcessUtils.shared.programsData = self.allPorgram
                    
                   
                }
                completion(true)
            case .error(let error, let errorResponse):
                completion(false)
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
    
    func getProgramName(_ programId:String)->String?{
        let programModel = self.allPorgram?.filter({$0.sjavms_programid == programId}).first
        return programModel?.sjavms_name
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
            cell.lblDateTime.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEE, MMM d, hh:mm a")
            cell.lblProgram.text = rowModel?.sjavms_program_value ?? ""
//            cell.lblparticipants.text = "\(rowModel?.msnfp_minimum ?? 0)"
            if let participant = rowModel?.sjavms_maxparticipants {
                cell.lblparticipants.text = "\(participant)"
            }else{
                cell.lblparticipants.text = "0"
            }
            cell.lblStatus.text = rowModel?.getStatus() ?? ""
            
            
            if (cell.lblStatus.text == "Pending"){
                cell.statusImg.image = UIImage(named: "hourglass Pending Yellow")
            }else if (cell.lblStatus.text == "Cancelled"){
                cell.statusImg.image = UIImage(named: "Cancelled Status")
            }else if (cell.lblStatus.text == "Approved"){
                cell.statusImg.image = UIImage(named: "check-double Green")
            }else{
                cell.statusImg.isHidden = true
            }
            cell.btnDetail.addTarget(self, action:#selector(showManageDetail(_:)), for:.touchUpInside)
            
            
            return cell
            
            
        }else if(tableView == self.pastTableView){
            
            let  cell = tableView.dequeueReusableCell(withIdentifier: "ManagerEventPendingCell", for: indexPath) as! ManagerEventPendingCell
           
            
            let rowModel = self.filterPastEventData?[indexPath.row]
            
            cell.lblTitle.text = rowModel?.msnfp_engagementopportunitytitle ?? ""
            cell.lblLocation.text = rowModel?.msnfp_location ?? "Not found"
            cell.lblDateTime.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEE, MMM d, hh:mm a")
            cell.lblProgram.text = rowModel?.sjavms_program_value ?? ""
            if let participant = rowModel?.sjavms_maxparticipants {
                cell.lblparticipants.text = "\(participant)"
            }else{
                cell.lblparticipants.text = "0"
            }
            
            cell.lblStatus.text = rowModel?.getStatus() ?? ""
            
            
            if (cell.lblStatus.text == "Pending"){
                cell.statusImg.image = UIImage(named: "hourglass Pending Yellow")
            }else if (cell.lblStatus.text == "Cancelled"){
                cell.statusImg.image = UIImage(named: "Cancelled Status")
            }else if (cell.lblStatus.text == "Approved"){
                cell.statusImg.image = UIImage(named: "check-double Green")
            }else{
                cell.statusImg.isHidden = true
            }
            
            cell.btnDetail.addTarget(self, action:#selector(showManageDetail(_:)), for:.touchUpInside)
            return cell
            
        }else if (tableView == self.pendingApprovalTableView){
            
            let  cell = tableView.dequeueReusableCell(withIdentifier: "ManagerEventPendingCell", for: indexPath) as! ManagerEventPendingCell
            let rowModel = self.filterPendingApprovalData?[indexPath.row]
            
            cell.lblTitle.text = rowModel?.sjavms_name ?? ""
            cell.lblLocation.text = rowModel?.sjavms_address1name ?? "Not found"
//            cell.lblHour.text = "\(rowModel?.time_difference ?? 0 )"
            cell.lblDateTime.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.sjavms_eventstartdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEE, MMM d, hh:mm a")
//            cell.lblparticipants.text = "\(rowModel?.sjavms_maxvolunteers ?? 0)"
            
            if let programName = self.getProgramName(rowModel?._sjavms_program_value ?? ""){
                cell.lblProgram.text = programName
            }else{
                cell.lblProgram.text = ""
            }
            
            
            if let participant = rowModel?.sjavms_maxvolunteers {
                cell.lblparticipants.text = "\(participant)"
            }else{
                cell.lblparticipants.text = "0"
            }
            
            cell.btnDetail.addTarget(self, action:#selector(showManageDetail(_:)), for:.touchUpInside)
            
            cell.lblStatus.text = rowModel?.msnfp_grouptype ?? ""
            
            
            if (cell.lblStatus.text == "Pending"){
                cell.statusImg.image = UIImage(named: "hourglass Pending Yellow")
            }else if (cell.lblStatus.text == "Cancelled"){
                cell.statusImg.image = UIImage(named: "Cancelled Status")
            }else if (cell.lblStatus.text == "Approved"){
                cell.statusImg.image = UIImage(named: "check-double Green")
            }else if (cell.lblStatus.text == "Unpublished"){
                cell.statusImg.image = UIImage(named: "hourglass Pending Yellow")
            }else{
                cell.statusImg.isHidden = true
            }
            
            return cell
            
        }else if (tableView == self.unpublishTableView){
            
            let  cell = tableView.dequeueReusableCell(withIdentifier: "ManagerEventPendingCell", for: indexPath) as! ManagerEventPendingCell
            let rowModel = self.filterPendingPublishData?[indexPath.row]
        
            cell.lblTitle.text = rowModel?.msnfp_engagementopportunitytitle ?? ""
            cell.lblLocation.text = rowModel?.msnfp_location ?? "Not found"
//            cell.lblHour.text = "\(rowModel?.time_difference ?? 0 )"
            if let date = rowModel?.msnfp_startingdate{
                cell.lblDateTime.text = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEE, MMM d, hh:mm a")
            }else{
                cell.lblDateTime.text = "...."
            }
            cell.lblProgram.text = rowModel?.sjavms_program_value ?? ""
            
            if let participant = rowModel?.msnfp_minimum {
                cell.lblparticipants.text = "\(participant)"
            }else{
                cell.lblparticipants.text = "0"
            }
            cell.btnDetail.addTarget(self, action:#selector(showManageDetail(_:)), for:.touchUpInside)
            
            cell.lblStatus.text = rowModel?.getStatus()
            if (cell.lblStatus.text == "Pending"){
                cell.statusImg.image = UIImage(named: "hourglass Pending Yellow")
            }else if (cell.lblStatus.text == "Cancelled"){
                cell.statusImg.image = UIImage(named: "Cancelled Status")
            }else if (cell.lblStatus.text == "Approved"){
                cell.statusImg.image = UIImage(named: "check-double Green")
            }else if (cell.lblStatus.text == "Unpublished"){
                cell.statusImg.image = UIImage(named: "hourglass Pending Yellow")
            }else{
                cell.statusImg.isHidden = true
            }
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
            let rowModel = self.filterPendingApprovalData?[index]
        
//            let eventdata = self.filterPendingApprovalData?[index]
//            let pendinngEventData : CurrentEventsModel? = CurrentEventsModel(msnfp_engagementopportunitytitle: rowModel?.sjavms_name , msnfp_startingdate: "" , address1_line1: rowModel?.sjavms_address1name, msnfp_location: rowModel?.sjavms_address1name, msnfp_engagementopportunitystatus: rowModel?.statecode, _sjavms_program_value: rowModel?._sjavms_program_value, msnfp_engagementopportunityid: rowModel?.sjavms_eventrequestid, msnfp_endingdate: "", msnfp_maximum: 0, msnfp_minimum: 0, _sjavms_contact_value: "pendingApproval", sjavms_maxparticipants: 0, sjavms_checkedin: false, sjavms_program_value: rowModel?._sjavms_program_value, time_difference: 0, msnfp_description: "", msnfp_shortdescription: "" )
//            
//            
            ENTALDControllers.shared.showPenndingApprovalSummaryScreen(type: .ENTALDPUSH, from: self , dataObj: rowModel) { params, controller in
                
            }
        }
        
        
    }

    func getNumberofRow(tableView : UITableView) -> Int{
        if (tableView == availableTableView){
            
            if ((filterCurrentEventData?.count ?? 0) > 3 && isAvaiableLoadMoreShow){
                availableLoadMoreView.isHidden = false
                return 3
            }
                availableLoadMoreView.isHidden = true
                return filterCurrentEventData?.count ?? 0
            
            
        }else if (tableView == pendingApprovalTableView){
            
            if ((filterPendingApprovalData?.count ?? 0) > 3 && isPendingApprovalLoadMoreShow){
                pendingLoadMoreView.isHidden = false
                return 3
            }
            pendingLoadMoreView.isHidden = true
                return filterPendingApprovalData?.count ?? 0
            
        }else if (tableView == unpublishTableView){
            if ((filterPendingPublishData?.count ?? 0) > 3 && isUnpublishLoadMoreShow){
                unpublishLoadMoreView.isHidden = false
                return 3
            }
                unpublishLoadMoreView.isHidden = true
                return filterPendingPublishData?.count ?? 0

            
        }else if (tableView == pastTableView){
            if ((filterPastEventData?.count ?? 0) > 3 && isPastLoadMoreShow){
                pastLoadMoreView.isHidden = false
                return 3
            }
            pastLoadMoreView.isHidden = true
                return filterPastEventData?.count ?? 0
         
            
        }else {
//            self.emptyView.isHidden = true
            return 0
        }
        return 0
    }
    
    
    
}
