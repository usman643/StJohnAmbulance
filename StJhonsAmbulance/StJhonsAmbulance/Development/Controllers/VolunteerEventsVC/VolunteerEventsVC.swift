//
//  VolunteerEventsVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 05/02/2023.
//

import UIKit

class VolunteerEventsVC: ENTALDBaseViewController {

    var pastEventData : [VolunteerEventsModel]?
    var scheduleGroupData : [ScheduleGroupsModel]?
    var scheduleEngagementData : [ScheduleModelTwo]?
    var scheduleData : [ScheduleModelThree]?
    var availableEngagementData : [ScheduleModelTwo]?
    var availableData : [AvailableEventModel]?
    
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
    @IBOutlet var allHeadingLabels: [UILabel]!
    @IBOutlet var allLabels: [UILabel]!
    
    @IBOutlet weak var availableHeaderView: UIView!
    @IBOutlet weak var scheduleHeaderView: UIView!
    @IBOutlet weak var pastHeaderView: UIView!
    
    @IBOutlet weak var availableTable: UITableView!
    @IBOutlet weak var scheduleTable: UITableView!
    @IBOutlet weak var pastTable: UITableView!
    
    @IBOutlet weak var lblTabTitle: UILabel!
    @IBOutlet weak var selectedTabImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        decorateUI()
        getScheduleInfo()
        getVolunteerPastEvent()
        getAvailableInfo()
    }

    func decorateUI(){
        
        for lbltext in allLabels{
            lbltext.font = UIFont.BoldFont(12)
            lbltext.textColor = UIColor.themePrimaryWhite
        }
        for lbltext in allHeadingLabels{
            lbltext.font = UIFont.BoldFont(18)
            lbltext.textColor = UIColor.themePrimaryWhite
        }
        
        availableHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        availableHeaderView.layer.borderWidth = 1
        
        scheduleHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        scheduleHeaderView.layer.borderWidth = 1
        
        pastHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        pastHeaderView.layer.borderWidth = 1
        lblTabTitle.textColor = UIColor.themePrimaryColor
        lblTabTitle.font = UIFont.BoldFont(16)
        
        selectedTabImg.image = selectedTabImg.image?.withRenderingMode(.alwaysTemplate)
        selectedTabImg.tintColor = UIColor.themePrimaryColor

    }
    
    func registerCells(){
        
        availableTable.delegate = self
        availableTable.dataSource = self
        availableTable.register(UINib(nibName: "VolunteerEventTVC", bundle: nil), forCellReuseIdentifier: "VolunteerEventTVC")
        
        scheduleTable.delegate = self
        scheduleTable.dataSource = self
        scheduleTable.register(UINib(nibName: "VolunteerEventTVC", bundle: nil), forCellReuseIdentifier: "VolunteerEventTVC")
        
        pastTable.delegate = self
        pastTable.dataSource = self
        pastTable.register(UINib(nibName: "VolunteerEventTVC", bundle: nil), forCellReuseIdentifier: "VolunteerEventTVC")

    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func availableFilterTapped(_ sender: Any) {
        if !isAvailableEventFilterApplied{
            self.availableData = self.availableData?.sorted {
                $0.msnfp_engagementopportunitytitle ?? "" < $1.msnfp_engagementopportunitytitle ?? ""
            }
            isAvailableEventFilterApplied = true
        }else{
            self.availableData = self.availableData?.sorted {
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
    
    @IBAction func scheduledFilterTapped(_ sender: Any) {
        if !isScheduleLocationFilterApplied{
            self.scheduleData = self.scheduleData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" < $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isScheduleLocationFilterApplied = true
        }else{
            self.scheduleData = self.scheduleData?.sorted {
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
    
    @IBAction func pastFilterTapped(_ sender: Any) {
        if !isPastEventFilterApplied{
            self.pastEventData = self.pastEventData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" < $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isPastEventFilterApplied = true
        }else{
            self.pastEventData = self.pastEventData?.sorted {
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
    
    // Bottom bar Action
    
    @IBAction func openLatestEventScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("latestEvent", self)
    }
    
    @IBAction func openCheckInScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("checkIn", self)
    }
    
    @IBAction func openEventScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("event", self)
        
    }
    
    @IBAction func openHoursScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("hour", self)
        
    }
    
    @IBAction func openMessagesScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("message", self)
        
    }
    
    @IBAction func openScheduleScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("schedule", self)
        
    }
    
    @IBAction func openDashBoardScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        
    }
    
    // ================ Filter ================
    
    @IBAction func availableEventFilter(_ sender: Any) {
        
        if !isAvailableEventFilterApplied{
            self.availableData = self.availableData?.sorted {
                $0.msnfp_engagementopportunitytitle ?? "" < $1.msnfp_engagementopportunitytitle ?? ""
            }
            isAvailableEventFilterApplied = true
        }else{
            self.availableData = self.availableData?.sorted {
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
            self.availableData = self.availableData?.sorted {
                $0.msnfp_location ?? "" < $1.msnfp_location ?? ""
            }
            isAvailableLocationFilterApplied = true
        }else{
            self.availableData = self.availableData?.sorted {
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
            self.availableData = self.availableData?.sorted {
                $0.msnfp_startingdate ?? "" < $1.msnfp_startingdate ?? ""
            }
            isAvailableDateFilterApplied = true
        }else{
            self.availableData = self.availableData?.sorted {
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
            self.availableData = self.availableData?.sorted {
                $0.msnfp_startingdate ?? "" < $1.msnfp_startingdate ?? ""
            }
            isAvailableStartFilterApplied = true
        }else{
            self.availableData = self.availableData?.sorted {
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
            self.availableData = self.availableData?.sorted {
                $0.msnfp_endingdate ?? "" < $1.msnfp_endingdate ?? ""
            }
            isAvailableEndFilterApplied = true
        }else{
            self.availableData = self.availableData?.sorted {
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
            self.scheduleData = self.scheduleData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" < $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isScheduleLocationFilterApplied = true
        }else{
            self.scheduleData = self.scheduleData?.sorted {
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
            self.scheduleData = self.scheduleData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_location ?? "" < $1.sjavms_VolunteerEvent?.msnfp_location ?? ""
            }
            isScheduleDateFilterApplied = true
        }else{
            self.scheduleData = self.scheduleData?.sorted {
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
            self.scheduleData = self.scheduleData?.sorted {
                $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
            }
            isScheduleDateFilterApplied = true
        }else{
            self.scheduleData = self.scheduleData?.sorted {
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
            self.scheduleData = self.scheduleData?.sorted {
                $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
            }
            isScheduleStartFilterApplied = true
        }else{
            self.scheduleData = self.scheduleData?.sorted {
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
            self.scheduleData = self.scheduleData?.sorted {
                $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
            }
            isScheduleEndFilterApplied = true
        }else{
            self.scheduleData = self.scheduleData?.sorted {
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
            self.pastEventData = self.pastEventData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" < $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isPastEventFilterApplied = true
        }else{
            self.pastEventData = self.pastEventData?.sorted {
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
            self.pastEventData = self.pastEventData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_location ?? "" < $1.sjavms_VolunteerEvent?.msnfp_location ?? ""
            }
            isPastLocationFilterApplied = true
        }else{
            self.pastEventData = self.pastEventData?.sorted {
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
            self.pastEventData = self.pastEventData?.sorted {
                $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
            }
            isPastDateFilterApplied = true
        }else{
            self.pastEventData = self.pastEventData?.sorted {
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
            self.pastEventData = self.pastEventData?.sorted {
                $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
            }
            isPastStartFilterApplied = true
        }else{
            self.pastEventData = self.pastEventData?.sorted {
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
            self.pastEventData = self.pastEventData?.sorted {
                $0.sjavms_end ?? "" < $1.sjavms_end ?? ""
            }
            isPastEndFilterApplied = true
        }else{
            self.pastEventData = self.pastEventData?.sorted {
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
            
            ParameterKeys.select : "_sjavms_volunteerevent_value,msnfp_schedulestatus,sjavms_start,msnfp_participationscheduleid,sjavms_end",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=msnfp_location,msnfp_engagementopportunityid,msnfp_engagementopportunitytitle)",
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
    
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_engagementopportunitystatus,msnfp_startingdate,msnfp_endingdate,msnfp_engagementopportunityid",
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=['{B651C666-CDC3-EB11-BACC-000D3A1FEB2E}','{80A4FB78-CDC3-EB11-BACC-000D3A1FEB2E}'])))",
            ParameterKeys.filter : "(statecode eq 0 and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002'])) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(ProcessUtils.shared.groupListValue ?? "")]))))",
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
        
        for i in (0 ..< (self.scheduleGroupData?.count ?? 0)){
            var str = ""
            if ( i == (self.scheduleGroupData?.count ?? 0) - 1){
                str = "sjavms_VolunteerEvent/ msnfp_engagementopportunityid eq \(self.scheduleEngagementData?[i].msnfp_engagementopportunityid ?? "")"
            }else{
                str = "sjavms_VolunteerEvent/ msnfp_engagementopportunityid eq \(self.scheduleEngagementData?[i].msnfp_engagementopportunityid ?? "") or "
            }
            
            propertyValues += str
            
        }
        
        guard let contactId = UserDefaults.standard.contactIdToken  else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "_sjavms_volunteerevent_value,msnfp_schedulestatus,sjavms_start,msnfp_participationscheduleid,sjavms_end",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=msnfp_engagementopportunitytitle,msnfp_location)",
            ParameterKeys.filter : "(_sjavms_volunteer_value eq \(contactId) and msnfp_schedulestatus eq 335940000 and (\(propertyValues))) ",
//            ParameterKeys.filter : "(_sjavms_volunteer_value eq \(contactId) and msnfp_schedulestatus eq 335940000 and (\(propertyValues))) ",
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
       
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_engagementopportunitystatus,msnfp_endingdate,msnfp_startingdate,msnfp_engagementopportunityid,_sjavms_program_value,msnfp_location,msnfp_maximum,msnfp_minimum",
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=['{80A4FB78-CDC3-EB11-BACC-000D3A1FEB2E}','{B651C666-CDC3-EB11-BACC-000D3A1FEB2E}'])))",
            ParameterKeys.filter : "(Microsoft.Dynamics.CRM.In(PropertyName='statuscode',PropertyValues=['1','802280000']) and sjavms_adhocevent ne true and msnfp_engagementopportunitystatus eq 844060002 and (Microsoft.Dynamics.CRM.Today(PropertyName='msnfp_endingdate') or Microsoft.Dynamics.CRM.NextXYears(PropertyName='msnfp_endingdate',PropertyValue=10))) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(ProcessUtils.shared.groupListValue ?? "")]))))",
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
            return availableData?.count ?? 0
        }else if (tableView == scheduleTable){
            return scheduleData?.count ?? 0
        }else if (tableView == pastTable){
            return pastEventData?.count ?? 0
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VolunteerEventTVC", for: indexPath) as! VolunteerEventTVC
        
        if (tableView == availableTable){
            let rowModel = self.availableData?[indexPath.row]
            cell.setContent(cellModel: rowModel)
        }else if (tableView == scheduleTable){
            let rowModel = self.scheduleData?[indexPath.row]
            cell.setContent(cellModel: rowModel)
        }else if (tableView == pastTable){
            let rowModel = self.pastEventData?[indexPath.row]
            cell.setContent(cellModel: rowModel)
        }
        
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
            cell.seperatorView.backgroundColor = UIColor.themePrimaryColor
        }else{
            cell.backgroundColor = UIColor.viewLightColor
            cell.seperatorView.backgroundColor = UIColor.gray
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == availableTable){
            
            ENTALDControllers.shared.showEventDetailScreen(type: .ENTALDPUSH, from: self, data: self.availableData?[indexPath.row], eventName: "availableEvent", callBack: nil)

        }else if (tableView == scheduleTable){
            
            ENTALDControllers.shared.showEventDetailScreen(type: .ENTALDPUSH, from: self, data: self.scheduleData?[indexPath.row], eventName: "scheduleEvent", callBack: nil)
            
        }else if (tableView == pastTable){
            
            ENTALDControllers.shared.showEventDetailScreen(type: .ENTALDPUSH, from: self, data: self.pastEventData?[indexPath.row], eventName: "pastEvent", callBack: nil)
        }
    }
}
