//
//  VolunteerEventsVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 05/02/2023.
//

import UIKit

protocol VolunteerEventDetailDelegate {
    
//    func openEventDetailScreen(eventId:String)
    func openAvailableEventDetailScreen(rowModel: AvailableEventModel?)
    func openScheduleEventDetailScreen(rowModel: ScheduleModelThree?)
}
class VolunteerEventsVC: ENTALDBaseViewController,VolunteerEventDetailDelegate {

    var pastEventData : [VolunteerEventsModel]?
    var scheduleGroupData : [ScheduleGroupsModel]?
    var scheduleEngagementData : [ScheduleModelTwo]?
    var scheduleData : [ScheduleModelThree]?
    var availableEngagementData : [ScheduleModelTwo]?
    var availableData : [AvailableEventModel]?
    
    var filterAvailableData : [AvailableEventModel]?
    var filterScheduleData : [ScheduleModelThree]?
    var filterPastEventData : [VolunteerEventsModel]?
    
    var isAvailabilityTableSearch = false
    var isScheduleTableSearch = false
    var isPastTableSearch = false
    
    
    var isAvailableEventFilterApplied = false
    var isAvailableLocationFilterApplied = false
    var isAvailableDateFilterApplied = false
    var isAvailableStartFilterApplied = false
    var isAvailableEndFilterApplied = false
    
    var isScheduleEventFilterApplied = false
    var isScheduleLocationFilterApplied = false
    var isScheduleDateFilterApplied = false
    var isScheduleStartFilterApplied = false
    var isScheduleEndFilterApplied = false
    
    var isPastEventFilterApplied = false
    var isPastLocationFilterApplied = false
    var isPastDateFilterApplied = false
    var isPastStartFilterApplied = false
    var isPastEndFilterApplied = false
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!

    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var availableTable: UITableView!
    @IBOutlet weak var scheduleTable: UITableView!
    @IBOutlet weak var pastTable: UITableView!
    
    @IBOutlet weak var availableView: UIView!
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var pastView: UIView!
    
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var textSearch: UITextField!
    @IBOutlet weak var btnSearchClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        decorateUI()
        getScheduleInfo()
        getVolunteerPastEvent()
        getAvailableInfo()
    }

    func decorateUI(){
        
        searchView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        searchView.layer.borderWidth = 1.5
        searchView.isHidden = false
        
        textSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        self.availableView.isHidden = false
        self.scheduleView.isHidden = true
        self.pastView.isHidden = true

    }
    
    func registerCells(){
        
        availableTable.delegate = self
        availableTable.dataSource = self
        availableTable.register(UINib(nibName: "VolunteersEventsTVC", bundle: nil), forCellReuseIdentifier: "VolunteersEventsTVC")
        
        scheduleTable.delegate = self
        scheduleTable.dataSource = self
        scheduleTable.register(UINib(nibName: "VolunteersEventsTVC", bundle: nil), forCellReuseIdentifier: "VolunteersEventsTVC")
        
        pastTable.delegate = self
        pastTable.dataSource = self
        pastTable.register(UINib(nibName: "VolunteersEventsTVC", bundle: nil), forCellReuseIdentifier: "VolunteersEventsTVC")

    }
    
    @IBAction func segmenTapped(_ sender: Any) {
        if self.segment.selectedSegmentIndex == 0 {
            self.availableView.isHidden = false
            self.scheduleView.isHidden = true
            self.pastView.isHidden = true
           
        }else if (self.segment.selectedSegmentIndex == 1 ){
            self.availableView.isHidden = true
            self.scheduleView.isHidden = false
            self.pastView.isHidden = true
        }else if (self.segment.selectedSegmentIndex == 2 ){
            self.availableView.isHidden = true
            self.scheduleView.isHidden = true
            self.pastView.isHidden = false
        }
        self.textSearch.text = ""
        
        
    }
    
    
//    func openEventDetailScreen(eventId:String){
//
//        ENTALDControllers.shared.showVolunteerEventDetailScreen(type: .ENTALDPUSH, from: self, dataObj: eventId, callBack: nil)
//
//    }
    
    func openScheduleEventDetailScreen(rowModel: ScheduleModelThree?) {
        ENTALDControllers.shared.showVolunteerEventDetailScreen(type: .ENTALDPUSH, from: self, dataObj: rowModel, eventType : "schedule" )  { params, controller in
            self.getScheduleInfo()
           
        }
    }
    
    func openAvailableEventDetailScreen(rowModel: AvailableEventModel?) {
        ENTALDControllers.shared.showVolunteerEventDetailScreen(type: .ENTALDPUSH, from: self, dataObj: rowModel, eventType : "available" )  { params, controller in
           
            self.getAvailableInfo()
        }
    }
    
    @IBAction func searchCloseTapped(_ sender: Any) {
//        self.searchView.isHidden = true
        textSearch.endEditing(true)
        textSearch.text = ""
        filterScheduleData = scheduleData
        filterAvailableData = availableData
        filterPastEventData = pastEventData
        
        availableTable.reloadData()
        scheduleTable.reloadData()
        pastTable.reloadData()
    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func availableFilterTapped(_ sender: Any) {
        isAvailabilityTableSearch = true
        isScheduleTableSearch = false
        isPastTableSearch = false
        self.searchView.isHidden = false
        self.textSearch.placeholder = "Filter Availability Event"
    }
    
    @IBAction func scheduledFilterTapped(_ sender: Any) {
        isAvailabilityTableSearch = false
        isScheduleTableSearch = true
        isPastTableSearch = false
        self.searchView.isHidden = false
        self.textSearch.placeholder = "Filter Scheduled Event"
        
    }
    
    @IBAction func pastFilterTapped(_ sender: Any) {
        isAvailabilityTableSearch = false
        isScheduleTableSearch = false
        isPastTableSearch = true
        self.searchView.isHidden = false
        self.textSearch.placeholder = "Filter Past Event"
        
    }
    
    // Bottom bar Action
    
    @IBAction func openLatestEventScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("sjavms_youthcamp", self)
    }
    
    @IBAction func openCheckInScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("sjavms_checkin", self)
    }
    
    @IBAction func openEventScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("sjavms_events", self)
        
    }
    
    @IBAction func openHoursScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("sjavms_hours", self)
        
    }
    
    @IBAction func openMessagesScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("sjavms_messages", self)
        
    }
    
    @IBAction func openScheduleScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("sjavms_myschedule", self)
        
    }
    
    @IBAction func openDashBoardScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnSearchClose.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        btnSearchClose.isHidden = true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (textField.text != "" && isAvailabilityTableSearch == true ){
            
            filterAvailableData  =  availableData?.filter({
                if let name = $0.msnfp_engagementopportunitytitle, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                }
                return false
            })
            DispatchQueue.main.async {
                self.availableTable.reloadData()
            }
            
            
        }else if(textField.text != "" && isScheduleTableSearch == true ){
            
            filterScheduleData  =  scheduleData?.filter({
                if let name = $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                 }
               return false
             })
            
            DispatchQueue.main.async {
                self.scheduleTable.reloadData()
            }
            
        }else if(textField.text != "" && isPastTableSearch == true ){
            
            filterPastEventData  =  pastEventData?.filter({
                if let name = $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                }
                return false
            })
            DispatchQueue.main.async {
                self.pastTable.reloadData()
            }
            
        }else{
            DispatchQueue.main.async {
                self.filterAvailableData = self.availableData
                self.availableTable.reloadData()
                self.filterScheduleData = self.scheduleData
                self.scheduleTable.reloadData()
                self.filterPastEventData = self.pastEventData
                self.pastTable.reloadData()
            }
        }
    }
    
    // ================ Filter ================
    
    @IBAction func availableEventFilter(_ sender: Any) {
        
        if !isAvailableEventFilterApplied{
            self.filterAvailableData = self.filterAvailableData?.sorted {
                $0.msnfp_engagementopportunitytitle ?? "" < $1.msnfp_engagementopportunitytitle ?? ""
            }
            isAvailableEventFilterApplied = true
        }else{
            self.filterAvailableData = self.filterAvailableData?.sorted {
                $0.msnfp_engagementopportunitytitle ?? "" > $1.msnfp_engagementopportunitytitle ?? ""
            }
            isAvailableEventFilterApplied = false
        }

        DispatchQueue.main.async {
            self.availableTable.reloadData()
        }
        
        isAvailableLocationFilterApplied = false
        isAvailableDateFilterApplied = false
        isAvailableStartFilterApplied = false
        isAvailableEndFilterApplied = false

    }
    
    @IBAction func availableLocationFilter(_ sender: Any) {
        
        if !isAvailableLocationFilterApplied{
            self.filterAvailableData = self.filterAvailableData?.sorted {
                $0.msnfp_location ?? "" < $1.msnfp_location ?? ""
            }
            isAvailableLocationFilterApplied = true
        }else{
            self.filterAvailableData = self.filterAvailableData?.sorted {
                $0.msnfp_location ?? "" > $1.msnfp_location ?? ""
            }
            isAvailableLocationFilterApplied = false
        }

        DispatchQueue.main.async {
            self.availableTable.reloadData()
        }
        
            isAvailableEventFilterApplied = false
            isAvailableDateFilterApplied = false
            isAvailableStartFilterApplied = false
            isAvailableEndFilterApplied = false
        
    }
    
    @IBAction func availableDateFilter(_ sender: Any) {
        
        if !isAvailableDateFilterApplied{
            self.filterAvailableData = self.filterAvailableData?.sorted {
                $0.msnfp_startingdate ?? "" < $1.msnfp_startingdate ?? ""
            }
            isAvailableDateFilterApplied = true
        }else{
            self.filterAvailableData = self.filterAvailableData?.sorted {
                $0.msnfp_startingdate ?? "" > $1.msnfp_startingdate ?? ""
            }
            isAvailableDateFilterApplied = false
        }

        DispatchQueue.main.async {
            self.availableTable.reloadData()
        }
        
        isAvailableEventFilterApplied = false
            isAvailableLocationFilterApplied = false
            isAvailableStartFilterApplied = false
            isAvailableEndFilterApplied = false
        
    }
    
    @IBAction func availableStartFilter(_ sender: Any) {
        
        if !isAvailableStartFilterApplied{
            self.filterAvailableData = self.filterAvailableData?.sorted {
                $0.msnfp_startingdate ?? "" < $1.msnfp_startingdate ?? ""
            }
            isAvailableStartFilterApplied = true
        }else{
            self.filterAvailableData = self.filterAvailableData?.sorted {
                $0.msnfp_startingdate ?? "" > $1.msnfp_startingdate ?? ""
            }
            isAvailableStartFilterApplied = false
        }

        DispatchQueue.main.async {
            self.availableTable.reloadData()
        }
        
        isAvailableEventFilterApplied = false
            isAvailableLocationFilterApplied = false
            isAvailableDateFilterApplied = false
            isAvailableEndFilterApplied = false
        
    }
    
    @IBAction func availableEndFilter(_ sender: Any) {
        
        if !isAvailableEndFilterApplied{
            self.filterAvailableData = self.filterAvailableData?.sorted {
                $0.msnfp_endingdate ?? "" < $1.msnfp_endingdate ?? ""
            }
            isAvailableEndFilterApplied = true
        }else{
            self.filterAvailableData = self.filterAvailableData?.sorted {
                $0.msnfp_endingdate ?? "" > $1.msnfp_endingdate ?? ""
            }
            isAvailableEndFilterApplied = false
        }

        DispatchQueue.main.async {
            self.availableTable.reloadData()
        }
        
        isAvailableEventFilterApplied = false
            isAvailableLocationFilterApplied = false
            isAvailableDateFilterApplied = false
            isAvailableStartFilterApplied = false
    }
    
    
    
    
    @IBAction func scheduleEventFilter(_ sender: Any) {
        
        if !isScheduleLocationFilterApplied{
            self.filterScheduleData = self.filterScheduleData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" < $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isScheduleLocationFilterApplied = true
        }else{
            self.filterScheduleData = self.filterScheduleData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" > $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isScheduleLocationFilterApplied = false
        }

        DispatchQueue.main.async {
            self.availableTable.reloadData()
        }
        
        isScheduleEventFilterApplied = false
        isScheduleDateFilterApplied = false
        isScheduleStartFilterApplied = false
        isScheduleEndFilterApplied = false
    }
    
    @IBAction func scheduleLocationFilter(_ sender: Any) {
        
        if !isScheduleDateFilterApplied{
            self.filterScheduleData = self.filterScheduleData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_location ?? "" < $1.sjavms_VolunteerEvent?.msnfp_location ?? ""
            }
            isScheduleDateFilterApplied = true
        }else{
            self.filterScheduleData = self.filterScheduleData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_location ?? "" > $1.sjavms_VolunteerEvent?.msnfp_location ?? ""
            }
            isScheduleDateFilterApplied = false
        }

        DispatchQueue.main.async {
            self.scheduleTable.reloadData()
        }
        
        isScheduleEventFilterApplied = false
        isScheduleDateFilterApplied = false
        isScheduleStartFilterApplied = false
        isScheduleEndFilterApplied = false
        
    }
    
    @IBAction func scheduleDateFilter(_ sender: Any) {
        
        if !isScheduleDateFilterApplied{
            self.filterScheduleData = self.filterScheduleData?.sorted {
                $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
            }
            isScheduleDateFilterApplied = true
        }else{
            self.filterScheduleData = self.filterScheduleData?.sorted {
                $0.sjavms_start ?? "" > $1.sjavms_start ?? ""
            }
            isScheduleDateFilterApplied = false
        }

        DispatchQueue.main.async {
            self.scheduleTable.reloadData()
        }
        
        isScheduleEventFilterApplied = false
        isScheduleLocationFilterApplied = false
        isScheduleStartFilterApplied = false
        isScheduleEndFilterApplied = false
        
    }
    
    @IBAction func scheduleStartFilter(_ sender: Any) {
        
        if !isScheduleStartFilterApplied{
            self.filterScheduleData = self.filterScheduleData?.sorted {
                $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
            }
            isScheduleStartFilterApplied = true
        }else{
            self.filterScheduleData = self.filterScheduleData?.sorted {
                $0.sjavms_start ?? "" > $1.sjavms_start ?? ""
            }
            isScheduleStartFilterApplied = false
        }

        DispatchQueue.main.async {
            self.scheduleTable.reloadData()
        }
        
        isScheduleEventFilterApplied = false
        isScheduleLocationFilterApplied = false
        isScheduleDateFilterApplied = false
        isScheduleEndFilterApplied = false
        
    }
    
    @IBAction func scheduleEndFilter(_ sender: Any) {
        
        if !isScheduleEndFilterApplied{
            self.filterScheduleData = self.filterScheduleData?.sorted {
                $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
            }
            isScheduleEndFilterApplied = true
        }else{
            self.filterScheduleData = self.filterScheduleData?.sorted {
                $0.sjavms_start ?? "" > $1.sjavms_start ?? ""
            }
            isScheduleEndFilterApplied = false
        }

        DispatchQueue.main.async {
            self.scheduleTable.reloadData()
        }
        
        isScheduleEventFilterApplied = false
        isScheduleLocationFilterApplied = false
        isScheduleDateFilterApplied = false
        isScheduleStartFilterApplied = false
    }
    
    
    @IBAction func pastEventFilter(_ sender: Any) {
        
        if !isPastEventFilterApplied{
            self.filterPastEventData = self.filterPastEventData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" < $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isPastEventFilterApplied = true
        }else{
            self.filterPastEventData = self.filterPastEventData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" > $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isPastEventFilterApplied = false
        }

        DispatchQueue.main.async {
            self.pastTable.reloadData()
        }
      
        isPastLocationFilterApplied = false
        isPastDateFilterApplied = false
        isPastStartFilterApplied = false
        isPastEndFilterApplied = false
    }
    
    @IBAction func pastLocationFilter(_ sender: Any) {
        
        if !isPastLocationFilterApplied{
            self.filterPastEventData = self.filterPastEventData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_location ?? "" < $1.sjavms_VolunteerEvent?.msnfp_location ?? ""
            }
            isPastLocationFilterApplied = true
        }else{
            self.filterPastEventData = self.filterPastEventData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_location ?? "" > $1.sjavms_VolunteerEvent?.msnfp_location ?? ""
            }
            isPastLocationFilterApplied = false
        }

        DispatchQueue.main.async {
            self.pastTable.reloadData()
        }
        
        isPastEventFilterApplied = false
        isPastDateFilterApplied = false
        isPastStartFilterApplied = false
        isPastEndFilterApplied = false
        
    }
    
    @IBAction func pastDateFilter(_ sender: Any) {
        
        if !isPastDateFilterApplied{
            self.filterPastEventData = self.filterPastEventData?.sorted {
                $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
            }
            isPastDateFilterApplied = true
        }else{
            self.filterPastEventData = self.filterPastEventData?.sorted {
                $0.sjavms_start ?? "" > $1.sjavms_start ?? ""
            }
            isPastDateFilterApplied = false
        }

        DispatchQueue.main.async {
            self.pastTable.reloadData()
        }
        
        isPastEventFilterApplied = false
        isPastLocationFilterApplied = false
        isPastStartFilterApplied = false
        isPastEndFilterApplied = false
        
    }
    
    @IBAction func pastStartFilter(_ sender: Any) {
        
        if !isPastStartFilterApplied{
            self.filterPastEventData = self.filterPastEventData?.sorted {
                $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
            }
            isPastStartFilterApplied = true
        }else{
            self.filterPastEventData = self.filterPastEventData?.sorted {
                $0.sjavms_start ?? "" > $1.sjavms_start ?? ""
            }
            isPastStartFilterApplied = false
        }

        DispatchQueue.main.async {
            self.pastTable.reloadData()
        }
        
        isPastEventFilterApplied = false
        isPastLocationFilterApplied = false
        isPastDateFilterApplied = false
        isPastEndFilterApplied = false
        
    }
    
    @IBAction func pastEndFilter(_ sender: Any) {
        
        if !isPastEndFilterApplied{
            self.filterPastEventData = self.filterPastEventData?.sorted {
                $0.sjavms_end ?? "" < $1.sjavms_end ?? ""
            }
            isPastEndFilterApplied = true
        }else{
            self.filterPastEventData = self.filterPastEventData?.sorted {
                $0.sjavms_end ?? "" > $1.sjavms_end ?? ""
            }
            isPastEndFilterApplied = false
        }

        DispatchQueue.main.async {
            self.pastTable.reloadData()
        }
        
        isPastEventFilterApplied = false
        isPastLocationFilterApplied = false
        isPastDateFilterApplied = false
        isPastStartFilterApplied = false
    }
    
    
    
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
    
  // ============================== API ========================
    
    func getVolunteerPastEvent(){
        guard let contactId = UserDefaults.standard.contactIdToken else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "_sjavms_volunteerevent_value,msnfp_schedulestatus,sjavms_start,msnfp_participationscheduleid,sjavms_end,sjavms_checkedin",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=msnfp_engagementopportunitytitle,msnfp_location)",
            ParameterKeys.filter : "(msnfp_schedulestatus eq 335940001 and _sjavms_volunteer_value eq \(contactId)) and (sjavms_VolunteerEvent/msnfp_engagementopportunitystatus eq 844060004)",
            ParameterKeys.orderby : "sjavms_start asc,_sjavms_volunteerevent_value asc"
        ]
        
        self.getVolunteerPastEventData(params: params)
    }
    
    fileprivate func getVolunteerPastEventData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerPastEvent(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let pastEvents = response.value {
                    self.pastEventData = pastEvents
                    self.filterPastEventData = pastEvents
                    if (self.pastEventData?.count == 0 || self.pastEventData?.count == nil){
                        self.showEmptyView(tableVw: self.pastTable)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.pastTable.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.pastTable.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.pastTable)
                }
            
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.pastTable)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    //==================== Schedule API =====================

    
    func getScheduleInfo(){
      let groupList =   ProcessUtils.shared.groupListValue ?? ""
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_engagementopportunitystatus,msnfp_startingdate,msnfp_endingdate,msnfp_engagementopportunityid",
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=['{B651C666-CDC3-EB11-BACC-000D3A1FEB2E}','{80A4FB78-CDC3-EB11-BACC-000D3A1FEB2E}'])))",
            ParameterKeys.filter : "(statecode eq 0 and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002'])) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(groupList)]))))",
            ParameterKeys.orderby : "msnfp_engagementopportunitytitle asc"
        ]
        
        self.getScheduleInfoTwoData(params: params)
    }
    
    
    fileprivate func getScheduleInfoTwoData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestScheduleTwo(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let scheduleGroup = response.value {
                    self.scheduleEngagementData = scheduleGroup
                    if (self.scheduleEngagementData?.count == 0 || self.scheduleEngagementData?.count == nil){
                        self.showEmptyView(tableVw: self.scheduleTable)
                    }else{
                        self.getScheduleInfoThree()
                        DispatchQueue.main.async {
                            for subview in self.scheduleTable.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                }else{
                    self.showEmptyView(tableVw: self.scheduleTable)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.scheduleTable)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    func getScheduleInfoThree(){
        var propertyValues = ""
        
        for i in (0 ..< (self.scheduleEngagementData?.count ?? 0)){
            var str = ""
            if ( i == (self.scheduleEngagementData?.count ?? 0) - 1){
                str = "sjavms_VolunteerEvent/ msnfp_engagementopportunityid eq \(self.scheduleEngagementData?[i].msnfp_engagementopportunityid ?? "")"
            }else{
                str = "sjavms_VolunteerEvent/ msnfp_engagementopportunityid eq \(self.scheduleEngagementData?[i].msnfp_engagementopportunityid ?? "") or "
            }
            
            propertyValues += str
            
        }
        
        guard let contactId = UserDefaults.standard.contactIdToken  else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "_sjavms_volunteerevent_value,msnfp_schedulestatus,sjavms_start,msnfp_participationscheduleid,sjavms_end,sjavms_checkedin",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=msnfp_engagementopportunitytitle,msnfp_location)",
            ParameterKeys.filter : "(_sjavms_volunteer_value eq \(contactId) and msnfp_schedulestatus eq 335940000 and (\(propertyValues))) ",
            ParameterKeys.orderby : "msnfp_name asc"
        ]

        
        self.getScheduleInfoThreeData(params: params)
        
    }
    
    fileprivate func getScheduleInfoThreeData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestScheduleThree(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let scheduleGroup = response.value {
                    self.scheduleData = scheduleGroup
                    self.filterScheduleData = scheduleGroup
                    if (self.scheduleData?.count == 0 || self.scheduleData?.count == nil){
                        self.showEmptyView(tableVw: self.scheduleTable)
                        
                    }else{
                       
                        DispatchQueue.main.async {
                            for subview in self.scheduleTable.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.scheduleTable.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.scheduleTable)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.scheduleTable)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    // ========================= Available API ================================

    
    func getAvailableInfo(){
        
        let propertyValues = ProcessUtils.shared.groupListValue ?? ""
       
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_engagementopportunitystatus,msnfp_endingdate,msnfp_startingdate,msnfp_engagementopportunityid,_sjavms_program_value,msnfp_location,msnfp_maximum,msnfp_minimum,msnfp_multipledays",
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(propertyValues)])))",
            
            ParameterKeys.filter : "(Microsoft.Dynamics.CRM.In(PropertyName='statuscode',PropertyValues=['1','802280000']) and sjavms_adhocevent ne true and msnfp_engagementopportunitystatus eq 844060002 and (Microsoft.Dynamics.CRM.Today(PropertyName='msnfp_endingdate') or Microsoft.Dynamics.CRM.NextXYears(PropertyName='msnfp_endingdate',PropertyValue=10))) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(propertyValues)]))))",
            
            
//            ParameterKeys.filter : "(Microsoft.Dynamics.CRM.In(PropertyName='statuscode',PropertyValues=['1','802280000']) and sjavms_adhocevent ne true and msnfp_engagementopportunitystatus eq 844060002 and (Microsoft.Dynamics.CRM.Today(PropertyName='msnfp_endingdate') or Microsoft.Dynamics.CRM.NextXYears(PropertyName='msnfp_endingdate',PropertyValue=10))) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=['{9afc17ef-14b4-ec11-983e-0022486db8f0}','{7079a17f-0339-ed11-9db1-0022486dfdbd}','{49005e21-76f8-ec11-82e5-0022486dccc4}','{37371436-03d2-ec11-a7b5-0022486dfa41}','{a02e2a85-cdc3-eb11-bacc-000d3a1feb2e}','{18791306-d7bb-ec11-983f-000d3af4ed1b}','{80a4fb78-cdc3-eb11-bacc-000d3a1feb2e}','{b651c666-cdc3-eb11-bacc-000d3a1feb2e}']))))",
       ParameterKeys.orderby : "msnfp_engagementopportunitytitle asc"
        ]
        
        self.getAvailalbeInfoData(params: params)
        
    }
    
    fileprivate func getAvailalbeInfoData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerAvailableEventTwo(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let availableEvent = response.value {
                    self.availableData = availableEvent
                    self.filterAvailableData = availableEvent
                    if (self.availableData?.count == 0 || self.availableData?.count == nil){
                        self.showEmptyView(tableVw: self.availableTable)
                        
                    }else{
                        DispatchQueue.main.async {
                            self.availableTable.reloadData()
                            for subview in self.availableTable.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.availableTable.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.availableTable)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.availableTable)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
}



extension VolunteerEventsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == availableTable){
            return filterAvailableData?.count ?? 0
        }else if (tableView == scheduleTable){
            return filterScheduleData?.count ?? 0
        }else if (tableView == pastTable){
            return filterPastEventData?.count ?? 0
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VolunteersEventsTVC", for: indexPath) as! VolunteersEventsTVC
        
        if (tableView == availableTable){
            let rowModel = self.filterAvailableData?[indexPath.row]
            cell.setContent(cellModel: rowModel, indx : indexPath.row)
            cell.delegate = self
        }else if (tableView == scheduleTable){
            let rowModel = self.filterScheduleData?[indexPath.row]
            cell.setContent(cellModel: rowModel , indx : indexPath.row)
            cell.delegate = self
        }else if (tableView == pastTable){
            let rowModel = self.filterPastEventData?[indexPath.row]
            cell.setContent(cellModel: rowModel)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == availableTable){
            
            ENTALDControllers.shared.showEventDetailScreen(type: .ENTALDPUSH, from: self, data: self.filterAvailableData?[indexPath.row], eventName: "availableEvent", callBack: nil)

        }else if (tableView == scheduleTable){
            
            ENTALDControllers.shared.showEventDetailScreen(type: .ENTALDPUSH, from: self, data: self.filterScheduleData?[indexPath.row], eventName: "scheduleEvent", callBack: nil)
            
        }else if (tableView == pastTable){
            
            ENTALDControllers.shared.showEventDetailScreen(type: .ENTALDPUSH, from: self, data: self.filterPastEventData?[indexPath.row], eventName: "pastEvent", callBack: nil)
        }
    }
}
