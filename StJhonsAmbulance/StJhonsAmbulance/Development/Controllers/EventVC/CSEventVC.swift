//
//  CSEventVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 18/07/2023.
//

import UIKit

class CSEventVC:ENTALDBaseViewController, UITextFieldDelegate {
    
    var currentEventData : [CurrentEventsModel]?
    var upcomingEventData : [CurrentEventsModel]?
    var pastEventData : [CurrentEventsModel]?
    
    var filterCurrentEventData : [CurrentEventsModel]?
    var filterUpcomingEventData : [CurrentEventsModel]?
    var filterPastEventData : [CurrentEventsModel]?
    
    var isCurrentEventFilterApplied = false
    var isCurrentLocatioFilterApplied = false
    var isCurrentSatrtFilterApplied = false
    var isCurrentEndFilterApplied = false
    
    var isUpcomingEventFilterApplied = false
    var isUpcomingLocatioFilterApplied = false
    var isUpcomingSatrtFilterApplied = false
    var isUpcomingEndFilterApplied = false
    
    var isPastEventFilterApplied = false
    var isPastLocatioFilterApplied = false
    var isPastDateFilterApplied = false
    
    var isCurrentEventTableSearch = false
    var isUpcomingEventTableSearch = false
    var isPastEventTableSearch = false
    
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var selectGroupView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSelectGroup: UIButton!
    @IBOutlet weak var btnCreateEvent: UIButton!

    @IBOutlet weak var currentView: UIView!
    @IBOutlet weak var upcomingView: UIView!
    @IBOutlet weak var pastView: UIView!
    @IBOutlet weak var currentTableView: UITableView!
    @IBOutlet weak var upcomingTableView: UITableView!
    @IBOutlet weak var pastTableView: UITableView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var textSearch: UITextField!
    @IBOutlet weak var btnSearchClose: UIButton!

    @IBOutlet weak var segment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        textSearch.delegate = self
        
        registerCells()
        decorateUI()
        getCurrentEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.btnSelectGroup.setTitle("\(ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupName() ?? "")", for: .normal)
    }
    
    func decorateUI(){
        
        textSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        selectGroupView.layer.cornerRadius = 3
        btnSelectGroup.layer.cornerRadius = 3
        btnCreateEvent.layer.cornerRadius = 3
        lblTitle.font = UIFont.BoldFont(20)
        lblTitle.textColor = UIColor.themePrimaryWhite

        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        btnCreateEvent.titleLabel?.font = UIFont.BoldFont(12)
        btnSelectGroup.backgroundColor = UIColor.themeSecondry
        
        btnSelectGroup.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnCreateEvent.setTitleColor(UIColor.textWhiteColor, for: .normal)
        
        searchView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        searchView.layer.borderWidth = 1.5
//        btnSearchClose.isHidden = true
        
//        lblTabTitle.textColor = UIColor.themePrimaryColor
//        lblTabTitle.font = UIFont.BoldFont(16)
//
//        selectedTabImg.image = selectedTabImg.image?.withRenderingMode(.alwaysTemplate)
//        selectedTabImg.tintColor = UIColor.themePrimaryColor
        searchView.isHidden = true
        self.currentView.isHidden = false
        self.upcomingView.isHidden = true
        self.pastView.isHidden = true
        
    }
    
    func registerCells(){
        currentTableView.delegate = self
        currentTableView.dataSource = self
        currentTableView.register(UINib(nibName: "CSEventTVC", bundle: nil), forCellReuseIdentifier: "CSEventTVC")
        
        upcomingTableView.delegate = self
        upcomingTableView.dataSource = self
        upcomingTableView.register(UINib(nibName: "CSEventTVC", bundle: nil), forCellReuseIdentifier: "CSEventTVC")
        
        pastTableView.delegate = self
        pastTableView.dataSource = self
        pastTableView.register(UINib(nibName: "CSEventTVC", bundle: nil), forCellReuseIdentifier: "CSEventTVC")

    }
    
    @IBAction func searchCloseTapped(_ sender: Any) {
        self.searchView.isHidden = true
        textSearch.endEditing(true)
        textSearch.text = ""
        filterCurrentEventData = currentEventData
        filterUpcomingEventData = upcomingEventData
        filterPastEventData = pastEventData
        
        currentTableView.reloadData()
        upcomingTableView.reloadData()
        pastTableView.reloadData()
    }
    
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectGroupTapped(_ sender: Any) {
        showGroupsPicker()
    }
    
    func openViewSummaryScreen(eventdata : CurrentEventsModel){
        
        ENTALDControllers.shared.showEventSummaryScreen(type: .ENTALDPUSH, from: self , dataObj: eventdata) { params, controller in
            
        }
        
    }
    
    @objc func showEventDetail(_ sender:UIButton){
        let index = sender.tag
        var eventdata : CurrentEventsModel?
        
        if self.segment.selectedSegmentIndex == 0 {
            
            eventdata = self.filterCurrentEventData?[index]
            
        }else  if self.segment.selectedSegmentIndex == 1 {
            eventdata = self.filterUpcomingEventData?[index]
        }else{
            return
        }
        
        ENTALDControllers.shared.showEventSummaryScreen(type: .ENTALDPUSH, from: self , dataObj: eventdata) { params, controller in
            
        }
        
    }
    
    @IBAction func createEventTapped(_ sender: Any) {
//        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
//        return
        ENTALDControllers.shared.showCreateEventForm(type: .ENTALDPUSH, from: self, isNavigationController: true) { params, controller in
            
        }
        
    }
    
    @IBAction func segmentsTapped(_ sender: Any) {
        if self.segment.selectedSegmentIndex == 0 {
            self.currentView.isHidden = false
            self.upcomingView.isHidden = true
            self.pastView.isHidden = true
           
        }else if (self.segment.selectedSegmentIndex == 1 ){
            self.currentView.isHidden = true
            self.upcomingView.isHidden = false
            self.pastView.isHidden = true
        }else if (self.segment.selectedSegmentIndex == 2 ){
            self.currentView.isHidden = true
            self.upcomingView.isHidden = true
            self.pastView.isHidden = false
        }
        self.textSearch.text = ""
    }
    
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
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
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnSearchClose.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        btnSearchClose.isHidden = true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (textField.text != "" && isCurrentEventTableSearch == true ){
            
            filterCurrentEventData  =  currentEventData?.filter({
                if let name = $0.msnfp_engagementopportunitytitle, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                }
                return false
            })
            DispatchQueue.main.async {
                self.currentTableView.reloadData()
            }
            
            
        }else if(textField.text != "" && isUpcomingEventTableSearch == true ){
            
            filterUpcomingEventData  =  upcomingEventData?.filter({
                if let name = $0.msnfp_engagementopportunitytitle, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                 }
               return false
             })
            
            DispatchQueue.main.async {
                self.upcomingTableView.reloadData()
            }
            
        }else if(textField.text != "" && isPastEventTableSearch == true ){
            
            filterPastEventData  =  pastEventData?.filter({
                if let name = $0.msnfp_engagementopportunitytitle, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                }
                return false
            })
            DispatchQueue.main.async {
                self.pastTableView.reloadData()
            }
            
        }else{
            DispatchQueue.main.async {
                self.filterCurrentEventData = self.currentEventData
                self.currentTableView.reloadData()
                self.filterPastEventData = self.pastEventData
                self.pastTableView.reloadData()
                self.filterUpcomingEventData = self.upcomingEventData
                self.upcomingTableView.reloadData()
            }
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
            self.getUpcomingEvents()
            switch result{
            case .success(value: let response):
                
                if let currentEvent = response.value {
                    self.currentEventData = currentEvent
                    self.filterCurrentEventData = currentEvent
                    if (self.currentEventData?.count == 0 || self.currentEventData?.count == nil){
                        self.showEmptyView(tableVw: self.currentTableView)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.currentTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.currentTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.currentTableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
               
                self.showEmptyView(tableVw: self.currentTableView)
                
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    
    // Upcoming Events API
    
    func getUpcomingEvents(){
        
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupId() else {return}
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_startingdate,msnfp_location,msnfp_engagementopportunitystatus,_sjavms_program_value,_sjavms_program_value,msnfp_engagementopportunityid,sjavms_maxparticipants,msnfp_endingdate,msnfp_maximum,msnfp_minimum",
            
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(msnfp_groupid eq \(groupId)))",
//            ParameterKeys.filter : "(statecode eq 0 and sjavms_adhocevent ne true and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002']) and (Microsoft.Dynamics.CRM.Tomorrow(PropertyName='msnfp_startingdate') or Microsoft.Dynamics.CRM.NextXYears(PropertyName='msnfp_startingdate',PropertyValue=10))) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/msnfp_groupid eq \(groupId))))",
  
            ParameterKeys.filter : "(statecode eq 0 and sjavms_adhocevent ne true and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002']) and (Microsoft.Dynamics.CRM.Tomorrow(PropertyName='msnfp_startingdate') or Microsoft.Dynamics.CRM.NextXYears(PropertyName='msnfp_startingdate',PropertyValue=10))) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/msnfp_groupid eq \(groupId))))",
            ParameterKeys.orderby : "msnfp_engagementopportunitytitle asc"
            
        ]
        
        self.getUpcomingEventData(params: params)
        
    }
    
    
    fileprivate func getUpcomingEventData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestUpcomingEvents(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            self.getPastEvents()
            switch result{
            case .success(value: let response):
                
                if let upcomingEvent = response.value {
                    self.upcomingEventData = upcomingEvent
                    self.filterUpcomingEventData = upcomingEvent
                    if (self.upcomingEventData?.count == 0 || self.upcomingEventData?.count == nil){
                        self.showEmptyView(tableVw: self.upcomingTableView)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.upcomingTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.upcomingTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.upcomingTableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.currentTableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
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
                    if (self.pastEventData?.count == 0 || self.pastEventData?.count == nil){
                        self.showEmptyView(tableVw: self.pastTableView)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.pastTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.pastTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.pastTableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.pastTableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}






















extension CSEventVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.currentTableView){
           return self.filterCurrentEventData?.count ?? 0
        }else if (tableView == self.upcomingTableView){
            return self.filterUpcomingEventData?.count ?? 0
        }else if(tableView == self.pastTableView){
            return self.filterPastEventData?.count ?? 0
            
        }
        
        return self.filterCurrentEventData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        
        if (tableView == self.currentTableView){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CSEventTVC", for: indexPath) as! CSEventTVC
            let rowModel = self.filterCurrentEventData?[indexPath.row]
            cell.setupContent(cellModel: rowModel)
            
            
//            cell.delegate = self
//            cell.eventdata  = rowModel
//            cell.mainView.backgroundColor = getEventColor(volunteerNum: rowModel?.msnfp_maximum ?? 0)

//            cell.lblEvent.text = rowModel?.msnfp_engagementopportunitytitle ?? ""
//            cell.lblLocation.text = rowModel?.msnfp_location ?? ""
//            cell.lblStart.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
//            cell.lblEnd.text =  DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
//            cell.lblNeeded.text = "\(rowModel?.msnfp_minimum ?? 0)"
            
            return cell
            
            
        }else if (tableView == self.upcomingTableView){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CSEventTVC", for: indexPath) as! CSEventTVC

                cell.btnView.tag = indexPath.row
                cell.btnView.addTarget(self, action: #selector(showEventDetail(_ :)), for: .touchUpInside)
            
            let rowModel = self.filterUpcomingEventData?[indexPath.row]
            cell.setupContent(cellModel: rowModel)
        
//            cell.delegate = self
//            cell.eventdata  = rowModel
//            cell.mainView.backgroundColor = getEventColor(volunteerNum: rowModel?.msnfp_maximum ?? 0)
            
//            cell.lblEvent.text = rowModel?.msnfp_engagementopportunitytitle ?? ""
//            cell.lblLocation.text = rowModel?.msnfp_location ?? ""
//            cell.lblStart.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
//            cell.lblEnd.text =  DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
//            cell.lblNeeded.text = "\(rowModel?.msnfp_minimum ?? 0)"
            
            
            
            return cell
            
        }else if(tableView == self.pastTableView){
            
            let  cell = tableView.dequeueReusableCell(withIdentifier: "CSEventTVC", for: indexPath) as! CSEventTVC
        
            
         let rowModel = self.filterPastEventData?[indexPath.row]
                cell.btnView.tag = indexPath.row
                cell.setupContent(cellModel: rowModel)
                cell.btnView.addTarget(self, action: #selector(showEventDetail(_ :)), for: .touchUpInside)
            
            
//            cell.lblEvent.text = rowModel?.msnfp_engagementopportunitytitle ?? ""
//            cell.lblLocation.text = rowModel?.msnfp_location ?? ""
//            cell.lblDate.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
            
//            cell.btnView.tag = indexPath.row
//            cell.btnView.addTarget(self, action: #selector(openViewSummaryScreen(eventdata: rowModel)), for: .touchUpInside)
            
            return cell
        }
        let cells = tableView.dequeueReusableCell(withIdentifier: "PastEventTVC", for: indexPath) as! PastEventTVC
        return cells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        if (tableView == self.currentTableView){
            
            ENTALDControllers.shared.showEventManageScreen(type: .ENTALDPUSH, from: self, data:self.filterCurrentEventData?[indexPath.row], callBack: nil)
        }else if (tableView == self.upcomingTableView){
            
            ENTALDControllers.shared.showEventManageScreen(type: .ENTALDPUSH, from: self, data:self.filterUpcomingEventData?[indexPath.row], callBack: nil)
        }else if(tableView == self.pastTableView){
            
            ENTALDControllers.shared.showEventManageScreen(type: .ENTALDPUSH, from: self, data:self.filterPastEventData?[indexPath.row], callBack: nil)
        }

    }
    
    
    
    
    
    
}
