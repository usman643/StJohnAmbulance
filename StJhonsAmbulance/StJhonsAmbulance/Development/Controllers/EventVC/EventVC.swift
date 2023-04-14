//
//  EventVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 27/01/2023.
//

import UIKit

protocol EventSummaryDelegate {
    
    func openViewSummaryScreen(eventdata : CurrentEventsModel)
}

class EventVC: ENTALDBaseViewController, UITextFieldDelegate,EventSummaryDelegate {
    
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
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var selectGroupView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSelectGroup: UIButton!
    @IBOutlet weak var btnCreateEvent: UIButton!
    @IBOutlet weak var lblCurrent: UILabel!
    @IBOutlet weak var btnCurrentFilter: UIButton!
    @IBOutlet weak var btnUpcomingFilter: UIButton!
    @IBOutlet weak var btnPastFilter: UIButton!
    @IBOutlet weak var lblUpcoming: UILabel!
    @IBOutlet weak var lblPast: UILabel!
    
    @IBOutlet weak var currentStackView: UIStackView!
    @IBOutlet weak var upcomingStackView: UIStackView!
    @IBOutlet weak var pastStackView: UIStackView!
    
    @IBOutlet weak var currentHeaderView: UIView!
    @IBOutlet weak var upcomingHeaderView: UIView!
    @IBOutlet weak var pastHeaderView: UIView!
    
    @IBOutlet weak var currentTableView: UITableView!
    @IBOutlet weak var upcomingTableView: UITableView!
    @IBOutlet weak var pastTableView: UITableView!
    
    @IBOutlet weak var lblCurrentEvent: UILabel!
    @IBOutlet weak var lblCurrentLocation: UILabel!
    @IBOutlet weak var lblCurrentStart: UILabel!
    @IBOutlet weak var lblCurrentEnd: UILabel!
    @IBOutlet weak var lblCurrentNeeded: UILabel!
    @IBOutlet weak var lblUpcomingEvent: UILabel!
    @IBOutlet weak var lblUpcomingLocation: UILabel!
    @IBOutlet weak var lblUpcomingStart: UILabel!
    @IBOutlet weak var lblUpcomingEnd: UILabel!
    @IBOutlet weak var lblUpcomingNeeded: UILabel!
    @IBOutlet weak var lblPastEvent: UILabel!
    @IBOutlet weak var lblPastLocation: UILabel!
    @IBOutlet weak var lblPastDate: UILabel!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var textSearch: UITextField!
    @IBOutlet weak var btnSearchClose: UIButton!
    
    @IBOutlet weak var lblTabTitle: UILabel!
    @IBOutlet weak var selectedTabImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textSearch.delegate = self
        
        registerCells()
        decorateUI()
        getCurrentEvents()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.btnSelectGroup.setTitle("\(ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupName() ?? "")", for: .normal)
    }
    
    func decorateUI(){
        
        textSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        selectGroupView.layer.cornerRadius = 3
        btnSelectGroup.layer.cornerRadius = 3
        btnCreateEvent.layer.cornerRadius = 3
        lblTitle.font = UIFont.BoldFont(20)
        lblTitle.textColor = UIColor.themePrimaryWhite
        
        currentHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        upcomingHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        pastHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        currentHeaderView.layer.borderWidth = 1.5
        upcomingHeaderView.layer.borderWidth = 1.5
        pastHeaderView.layer.borderWidth = 1.5
        lblUpcoming.font = UIFont.BoldFont(16)
        lblUpcoming.textColor = UIColor.themePrimaryWhite
        lblCurrent.font = UIFont.BoldFont(16)
        lblCurrent.textColor = UIColor.themePrimaryWhite
        lblPast.font = UIFont.BoldFont(16)
        lblPast.textColor = UIColor.themePrimaryWhite
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        btnCreateEvent.titleLabel?.font = UIFont.BoldFont(12)
        btnSelectGroup.backgroundColor = UIColor.themeSecondry
        
        btnSelectGroup.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnCreateEvent.setTitleColor(UIColor.textWhiteColor, for: .normal)
        lblCurrentEvent.font = UIFont.BoldFont(12)
        lblCurrentLocation.font = UIFont.BoldFont(12)
        lblCurrentStart.font = UIFont.BoldFont(12)
        lblCurrentEnd.font = UIFont.BoldFont(12)
        lblCurrentNeeded.font = UIFont.BoldFont(12)
        lblUpcomingEvent.font = UIFont.BoldFont(12)
        lblUpcomingLocation.font = UIFont.BoldFont(12)
        lblUpcomingStart.font = UIFont.BoldFont(12)
        lblUpcomingEnd.font = UIFont.BoldFont(12)
        lblUpcomingNeeded.font = UIFont.BoldFont(12)
        lblPastEvent.font = UIFont.BoldFont(12)
        lblPastLocation.font = UIFont.BoldFont(12)
        lblPastDate.font = UIFont.BoldFont(12)
        
        lblCurrentEvent.textColor = UIColor.themePrimaryWhite
        lblCurrentLocation.textColor = UIColor.themePrimaryWhite
        lblCurrentStart.textColor = UIColor.themePrimaryWhite
        lblCurrentEnd.textColor = UIColor.themePrimaryWhite
        lblCurrentNeeded.textColor = UIColor.themePrimaryWhite
        lblUpcomingEvent.textColor = UIColor.themePrimaryWhite
        lblUpcomingLocation.textColor = UIColor.themePrimaryWhite
        lblUpcomingStart.textColor = UIColor.themePrimaryWhite
        lblUpcomingEnd.textColor = UIColor.themePrimaryWhite
        lblUpcomingNeeded.textColor = UIColor.themePrimaryWhite
        lblPastEvent.textColor = UIColor.themePrimaryWhite
        lblPastLocation.textColor = UIColor.themePrimaryWhite
        lblPastDate.textColor = UIColor.themePrimaryWhite
        
        currentTableView.clipsToBounds = false
        currentTableView.layer.masksToBounds = false
        currentTableView.layer.shadowColor = UIColor.lightGray.cgColor
        currentTableView.layer.shadowOffset = .zero
        currentTableView.layer.shadowRadius = 0
        currentTableView.layer.shadowOpacity = 0.5
        
        upcomingTableView.clipsToBounds = false
        upcomingTableView.layer.masksToBounds = false
        upcomingTableView.layer.shadowColor = UIColor.lightGray.cgColor
        upcomingTableView.layer.shadowOffset = .zero
        upcomingTableView.layer.shadowRadius = 0
        upcomingTableView.layer.shadowOpacity = 0.5
        
        pastTableView.clipsToBounds = false
        pastTableView.layer.masksToBounds = false
        pastTableView.layer.shadowColor = UIColor.lightGray.cgColor
        pastTableView.layer.shadowOffset = .zero
        pastTableView.layer.shadowRadius = 0
        pastTableView.layer.shadowOpacity = 0.5
        
        searchView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        searchView.layer.borderWidth = 1.5
//        btnSearchClose.isHidden = true
        
        lblTabTitle.textColor = UIColor.themePrimaryColor
        lblTabTitle.font = UIFont.BoldFont(16)
        
        selectedTabImg.image = selectedTabImg.image?.withRenderingMode(.alwaysTemplate)
        selectedTabImg.tintColor = UIColor.themePrimaryColor
        searchView.isHidden = true
        
    }
    
    func registerCells(){
        currentTableView.delegate = self
        currentTableView.dataSource = self
        currentTableView.register(UINib(nibName: "EventTVC", bundle: nil), forCellReuseIdentifier: "EventTVC")
        
        upcomingTableView.delegate = self
        upcomingTableView.dataSource = self
        upcomingTableView.register(UINib(nibName: "EventTVC", bundle: nil), forCellReuseIdentifier: "EventTVC")
        
        pastTableView.delegate = self
        pastTableView.dataSource = self
        pastTableView.register(UINib(nibName: "PastEventTVC", bundle: nil), forCellReuseIdentifier: "PastEventTVC")

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
    
    @IBAction func homeTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectGroupTapped(_ sender: Any) {
        showGroupsPicker()
    }
    
    @IBAction func currentFilterTapped(_ sender: Any) {
        
        isCurrentEventTableSearch = true
        isUpcomingEventTableSearch = false
        isPastEventTableSearch = false
        self.searchView.isHidden = false
        self.textSearch.placeholder = "Filter Current Event"
        
    }
    
    @IBAction func upcomingFilterTapped(_ sender: Any) {
        
        isCurrentEventTableSearch = false
        isUpcomingEventTableSearch = true
        isPastEventTableSearch = false
        self.searchView.isHidden = false
        self.textSearch.placeholder = "Filter Upcoming Event"
        
    }
    
    @IBAction func pastFilterTapped(_ sender: Any) {
        
        isCurrentEventTableSearch = false
        isUpcomingEventTableSearch = false
        isPastEventTableSearch = true
        self.searchView.isHidden = false
        self.textSearch.placeholder = "Filter Past Event"
    }
    
    func openViewSummaryScreen(eventdata : CurrentEventsModel){
        
        ENTALDControllers.shared.showEventSummaryScreen(type: .ENTALDPUSH, from: self , dataObj: eventdata) { params, controller in
            
        }
        
    }
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        present(menu!, animated: true)
    }
    
// bottom bar action
    
    @IBAction func openMessagesScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("sjavms_messages", self)
    }
    @IBAction func openVolunteerScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("sjavms_volunteers", self)
    }
    @IBAction func openEventScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("sjavms_events", self)
    }
    @IBAction func openPendingEventScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("sjavms_pendingevents", self)
    }
    @IBAction func openPendingShiftsScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("sjavms_pendingshifts", self)
    }
    @IBAction func openDashBoardScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
 
    @IBAction func createEventTapped(_ sender: Any) {
//        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
//        return
        ENTALDControllers.shared.showCreateEventForm(type: .ENTALDPUSH, from: self, isNavigationController: true) { params, controller in
            
        }
        
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
                self.btnSelectGroup.setTitle("\(data.msnfp_groupId?.getGroupName() ?? "")", for: .normal)
                
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
    
//    ========================== Filters ========================//
    
    @IBAction func currentEevntFilter(_ sender: Any) {
        
        if !isCurrentEventFilterApplied{
            self.filterCurrentEventData = self.filterCurrentEventData?.sorted {
                $0.msnfp_engagementopportunitytitle ?? "" < $1.msnfp_engagementopportunitytitle ?? ""
            }
            isCurrentEventFilterApplied = true
        }else{
            self.filterCurrentEventData = self.filterCurrentEventData?.sorted {
                $0.msnfp_engagementopportunitytitle ?? "" > $1.msnfp_engagementopportunitytitle ?? ""
            }
            isCurrentEventFilterApplied = false
        }
        
        self.isCurrentLocatioFilterApplied = false
        self.isCurrentSatrtFilterApplied = false
        self.isCurrentEndFilterApplied = false
        
        DispatchQueue.main.async {
            self.currentTableView.reloadData()
        }
    }
        
    
    @IBAction func currentLocationFilter(_ sender: Any) {
        if !isCurrentLocatioFilterApplied{
            self.filterCurrentEventData = self.filterCurrentEventData?.sorted {
                $0.msnfp_location ?? "" < $1.msnfp_location ?? ""
            }
            isCurrentLocatioFilterApplied = true
        }else{
            self.filterCurrentEventData = self.filterCurrentEventData?.sorted {
                $0.msnfp_location ?? "" > $1.msnfp_location ?? ""
            }
            isCurrentLocatioFilterApplied = false
        }
    
        self.isCurrentEventFilterApplied = false
        self.isCurrentSatrtFilterApplied = false
        self.isCurrentEndFilterApplied = false
        
        DispatchQueue.main.async {
            self.currentTableView.reloadData()
        }
    }
    
    @IBAction func currentStartDateFilter(_ sender: Any) {
        if !isCurrentSatrtFilterApplied{
            self.filterCurrentEventData = self.filterCurrentEventData?.sorted {
                $0.msnfp_startingdate ?? "" < $1.msnfp_startingdate ?? ""
            }
            isCurrentSatrtFilterApplied = true
        }else{
            self.filterCurrentEventData = self.filterCurrentEventData?.sorted {
                $0.msnfp_startingdate ?? "" > $1.msnfp_startingdate ?? ""
            }
            isCurrentSatrtFilterApplied = false
        }
    
        self.isCurrentEventFilterApplied = false
        self.isCurrentLocatioFilterApplied = false
        self.isCurrentEndFilterApplied = false
        
        DispatchQueue.main.async {
            self.currentTableView.reloadData()
        }
    }
    
    @IBAction func currentEndDateFilter(_ sender: Any) {
        if !isCurrentEndFilterApplied{
            self.filterCurrentEventData = self.filterCurrentEventData?.sorted {
                $0.msnfp_endingdate ?? "" < $1.msnfp_endingdate ?? ""
            }
            isCurrentEndFilterApplied = true
        }else{
            self.filterCurrentEventData = self.filterCurrentEventData?.sorted {
                $0.msnfp_endingdate ?? "" > $1.msnfp_endingdate ?? ""
            }
            isCurrentEndFilterApplied = false

        }
    
        self.isCurrentEventFilterApplied = false
        self.isCurrentLocatioFilterApplied = false
        self.isCurrentSatrtFilterApplied = false
        
        DispatchQueue.main.async {
            self.currentTableView.reloadData()
        }
    }
    
    
    @IBAction func UpcomingEevntFilter(_ sender: Any) {
        if !isUpcomingEventFilterApplied{
            self.filterUpcomingEventData = self.filterUpcomingEventData?.sorted {
                $0.msnfp_engagementopportunitytitle ?? "" < $1.msnfp_engagementopportunitytitle ?? ""
            }
            isUpcomingEventFilterApplied = true
        }else{
            self.filterUpcomingEventData = self.filterUpcomingEventData?.sorted {
                $0.msnfp_engagementopportunitytitle ?? "" > $1.msnfp_engagementopportunitytitle ?? ""
            }
            isUpcomingEventFilterApplied = false

        }
    
        self.isUpcomingLocatioFilterApplied = false
        self.isUpcomingSatrtFilterApplied = false
        self.isUpcomingEndFilterApplied = false
        
        DispatchQueue.main.async {
            self.upcomingTableView.reloadData()
        }
    }
    
    @IBAction func UpcomingLocationFilter(_ sender: Any) {
        if !isUpcomingLocatioFilterApplied{
            self.filterUpcomingEventData = self.filterUpcomingEventData?.sorted {
                $0.msnfp_location ?? "" < $1.msnfp_location ?? ""
            }
            isUpcomingLocatioFilterApplied = true
        }else{
            self.filterUpcomingEventData = self.filterUpcomingEventData?.sorted {
                $0.msnfp_location ?? "" > $1.msnfp_location ?? ""
            }
            isUpcomingLocatioFilterApplied = false

        }
    
        self.isUpcomingEventFilterApplied = false
        self.isUpcomingSatrtFilterApplied = false
        self.isUpcomingEndFilterApplied = false
        
        DispatchQueue.main.async {
            self.upcomingTableView.reloadData()
        }
    }
    
    @IBAction func UpcomingStartDateFilter(_ sender: Any) {
        if !isUpcomingSatrtFilterApplied{
            self.filterUpcomingEventData = self.filterUpcomingEventData?.sorted {
                $0.msnfp_startingdate ?? "" < $1.msnfp_startingdate ?? ""
            }
            isUpcomingSatrtFilterApplied = true
        }else{
            self.filterUpcomingEventData = self.filterUpcomingEventData?.sorted {
                $0.msnfp_startingdate ?? "" > $1.msnfp_startingdate ?? ""
            }
            isUpcomingSatrtFilterApplied = false

        }
    
        self.isUpcomingEventFilterApplied = false
        self.isUpcomingLocatioFilterApplied = false
        self.isUpcomingEndFilterApplied = false
        
        DispatchQueue.main.async {
            self.upcomingTableView.reloadData()
        }
    }
    
    @IBAction func UpcomingEndDateFilter(_ sender: Any) {
        if !isUpcomingEndFilterApplied{
            self.filterUpcomingEventData = self.filterUpcomingEventData?.sorted {
                $0.msnfp_endingdate ?? "" < $1.msnfp_endingdate ?? ""
            }
            isUpcomingEndFilterApplied = true
        }else{
            self.filterUpcomingEventData = self.filterUpcomingEventData?.sorted {
                $0.msnfp_endingdate ?? "" > $1.msnfp_endingdate ?? ""
            }
            isUpcomingEndFilterApplied = false

        }
    
        self.isUpcomingEventFilterApplied = false
        self.isUpcomingLocatioFilterApplied = false
        self.isUpcomingSatrtFilterApplied = false
        
        DispatchQueue.main.async {
            self.upcomingTableView.reloadData()
        }
    }
    
    @IBAction func PastEevntFilter(_ sender: Any) {
        if !isPastEventFilterApplied{
            self.filterPastEventData = self.filterPastEventData?.sorted {
                $0.msnfp_location ?? "" < $1.msnfp_location ?? ""
            }
            isPastEventFilterApplied = true
        }else{
            self.filterPastEventData = self.filterPastEventData?.sorted {
                $0.msnfp_location ?? "" > $1.msnfp_location ?? ""
            }
            isPastEventFilterApplied = false
        }
    
        self.isPastLocatioFilterApplied = false
        self.isPastDateFilterApplied = false
        
        DispatchQueue.main.async {
            self.pastTableView.reloadData()
        }
    }
    
    @IBAction func pastLocationFilter(_ sender: Any) {
        if !isPastLocatioFilterApplied{
            self.filterPastEventData = self.filterPastEventData?.sorted {
                $0.msnfp_location ?? "" < $1.msnfp_location ?? ""
            }
            isPastLocatioFilterApplied = true
        }else{
            self.filterPastEventData = self.filterPastEventData?.sorted {
                $0.msnfp_location ?? "" > $1.msnfp_location ?? ""
            }
            isPastLocatioFilterApplied = false
        }
    
        self.isPastEventFilterApplied = false
        self.isPastDateFilterApplied = false
        
        DispatchQueue.main.async {
            self.pastTableView.reloadData()
        }
    }
    
    @IBAction func pastDateFilter(_ sender: Any) {
        if !isPastDateFilterApplied{
            self.filterPastEventData = self.filterPastEventData?.sorted {
                $0.msnfp_endingdate ?? "" < $1.msnfp_endingdate ?? ""
            }
            isPastDateFilterApplied = true
        }else{
            self.filterPastEventData = self.filterPastEventData?.sorted {
                $0.msnfp_endingdate ?? "" > $1.msnfp_endingdate ?? ""
            }
            isPastDateFilterApplied = false
        }
    
        self.isPastEventFilterApplied = false
        self.isPastLocatioFilterApplied = false
        
        DispatchQueue.main.async {
            self.pastTableView.reloadData()
        }
    }
    
    
    func getCurrentEvents(){
        
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() else {return}
        
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
        
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() else {return}
        
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
        
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() else {return}
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_startingdate,msnfp_location,msnfp_engagementopportunitystatus,_sjavms_program_value,msnfp_engagementopportunityid",
            
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


extension EventVC: UITableViewDelegate,UITableViewDataSource ,UITextViewDelegate{
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventTVC", for: indexPath) as! EventTVC
            let rowModel = self.filterCurrentEventData?[indexPath.row]

            if indexPath.row % 2 == 0{
            
                cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
            }else{
                cell.seperaterView.backgroundColor = UIColor.gray
            }
            cell.delegate = self
            cell.eventdata  = rowModel
            cell.mainView.backgroundColor = getEventColor(volunteerNum: rowModel?.msnfp_maximum ?? 0)

            cell.lblEvent.text = rowModel?.msnfp_engagementopportunitytitle ?? ""
            cell.lblLocation.text = rowModel?.msnfp_location ?? ""
            cell.lblStart.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
            cell.lblEnd.text =  DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
            cell.lblNeeded.text = "\(rowModel?.msnfp_minimum ?? 0)"
            
            return cell
            
            
        }else if (tableView == self.upcomingTableView){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventTVC", for: indexPath) as! EventTVC
            let rowModel = self.filterUpcomingEventData?[indexPath.row]

            if indexPath.row % 2 == 0{
                
                cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
            }else{
                cell.seperaterView.backgroundColor = UIColor.gray
            }
            cell.delegate = self
            cell.eventdata  = rowModel
            cell.mainView.backgroundColor = getEventColor(volunteerNum: rowModel?.msnfp_maximum ?? 0)
            
            cell.lblEvent.text = rowModel?.msnfp_engagementopportunitytitle ?? ""
            cell.lblLocation.text = rowModel?.msnfp_location ?? ""
            cell.lblStart.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
            cell.lblEnd.text =  DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
            cell.lblNeeded.text = "\(rowModel?.msnfp_minimum ?? 0)"
            
            return cell
            
        }else if(tableView == self.pastTableView){
            
            let  cell = tableView.dequeueReusableCell(withIdentifier: "PastEventTVC", for: indexPath) as! PastEventTVC
            if indexPath.row % 2 == 0{
                cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
                cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
            }else{
                cell.mainView.backgroundColor = UIColor.viewLightColor
                cell.seperaterView.backgroundColor = UIColor.gray
            }
            
            let rowModel = self.filterPastEventData?[indexPath.row]
            
            cell.lblEvent.text = rowModel?.msnfp_engagementopportunitytitle ?? ""
            cell.lblLocation.text = rowModel?.msnfp_location ?? ""
            cell.lblDate.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
            
            return cell
        }
        let cells = tableView.dequeueReusableCell(withIdentifier: "PastEventTVC", for: indexPath) as! PastEventTVC
        return cells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
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
    
    func getEventColor(volunteerNum: Int) -> UIColor {
        
        if volunteerNum < 50 {
            return UIColor.redPinkColor
        
        }else if volunteerNum < 100 {
            return UIColor.hexString(hex: "faf3c3")
        }else if volunteerNum >= 100{
            return UIColor.hexString(hex: "e6f2eb")
        }
        
        return UIColor.viewLightColor
    }
    
}
