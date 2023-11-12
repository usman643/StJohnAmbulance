//
//  AvailabilityVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 15/02/2023.
//

import UIKit

class AvailabilityVC: ENTALDBaseViewController,UITextFieldDelegate {

    
    var adhocData : [SideMenuHoursModel]?
    var volunteerHourData : [SideMenuHoursModel]?
    var availablityData : [AvailablityHourModel]?
    var filterAdhocData : [SideMenuHoursModel]?
    var filterVolunteerHourData : [SideMenuHoursModel]?
    var filterAvailablityData : [AvailablityHourModel]?
    var programsData : [ProgramModel]?
    let contactId = UserDefaults.standard.contactIdToken ?? ""
    
    var isAdhocTableSearch = false
    var isVolunteerHourTableSearch = false
    var isAvailablityTableSearch = false
    
    var isAdhocTitle = false
    var isAdhocPrgram = false
    var isAdhocHours = false
    
    var isVolunteerEvent = false
    var isVolunteerProgram = false
    var isVolunteerSchedule = false
    var isVolunteerStart = false
    var isVolunteerEnd = false
    var isVolunteerHour = false

    var isAvailabilityTitle = false
    var isAvailabilityEffectiveFrom = false
    var isAvailabilityEffectiveTo = false
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLabelView: UIView!
    @IBOutlet var allHeadingLabel: [UILabel]!
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var lblTitile: UILabel!
    
  
    @IBOutlet weak var adhocView: UIView!
    @IBOutlet weak var volunteerHourView: UIView!
    @IBOutlet weak var availablityView: UIView!
    
    
    
    @IBOutlet weak var adhocTableView: UITableView!
    @IBOutlet weak var voluteerHourTableView: UITableView!
    @IBOutlet weak var availablityTableView: UITableView!
    
    @IBOutlet weak var lblPending: UILabel!
    @IBOutlet weak var lblYeartoDate: UILabel!
    @IBOutlet weak var lblLifeTime: UILabel!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var textSearch: UITextField!
    @IBOutlet weak var btnSearchClose: UIButton!
    
//    @IBOutlet weak var lblTabTitle: UILabel!
//    @IBOutlet weak var selectedTabImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
        setupContent()
        registerCell()
        textSearch.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false // or true
    }


    
    func registerCell(){
        adhocTableView.delegate = self
        voluteerHourTableView.delegate = self
        availablityTableView.delegate = self
        adhocTableView.dataSource = self
        voluteerHourTableView.dataSource = self
        availablityTableView.dataSource = self
        adhocTableView.register(UINib(nibName: "AdhocHourCell", bundle: nil), forCellReuseIdentifier: "AdhocHourCell")
        voluteerHourTableView.register(UINib(nibName: "VolunteerHourCell", bundle: nil), forCellReuseIdentifier: "VolunteerHourCell")
        
        availablityTableView.register(UINib(nibName: "AvailablityCell", bundle: nil), forCellReuseIdentifier: "AvailablityCell")
    
    }
    
    func setupContent(){
        lblPending.text = UserDefaults.standard.userInfo?.sjavms_totalpendinghrs?.getFormattedNumber()
        lblYeartoDate.text = UserDefaults.standard.userInfo?.sjavms_totalhourscompletedthisyear?.getFormattedNumber()
        lblLifeTime.text = UserDefaults.standard.userInfo?.msnfp_totalengagementhours?.getFormattedNumber()
        
        self.getAllProgramesfile( completion: {status in
            
            self.getAdhocHour()
            self.getAvailability()
            self.getVolunteerHour()
        })
        
        
    }

    func decorateUI(){
        
        headerView.addBottomShadow()
        lblTitile.font = UIFont.boldSystemFont(ofSize: 18)
        lblTitile.textColor = UIColor.headerGreen
        headerLabelView.layer.borderWidth = 1
        headerLabelView.layer.borderColor = UIColor.themePrimaryColor.cgColor

        for lbltext in allHeadingLabel{
            lbltext.font = UIFont.BoldFont(14)
            lbltext.textColor = UIColor.themePrimaryWhite
        }
        
        lblPending.textColor = UIColor.themePrimaryWhite
        lblPending.font = UIFont.BoldFont(16)
        lblYeartoDate.textColor = UIColor.themePrimaryWhite
        lblYeartoDate.font = UIFont.BoldFont(16)
        lblLifeTime.textColor = UIColor.themePrimaryWhite
        lblLifeTime.font = UIFont.BoldFont(16)
        
        searchView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        searchView.layer.borderWidth = 1.5
        
        textSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        isAdhocTableSearch = true
        searchView.isHidden = false
        searchView.layer.cornerRadius = 8
        segment.selectedSegmentIndex = 0
        self.adhocView.isHidden = false
        self.volunteerHourView.isHidden = true
        self.availablityView.isHidden = true
        
        isAdhocTableSearch = true
        isVolunteerHourTableSearch = false
        isAvailablityTableSearch = false
    }
    
    @IBAction func addAdhocHourTapped(_ sender: Any) {
        ENTALDControllers.shared.showAddAdhocHourScreen(type: .ENTALDPUSH, from: self) { params, controller in
            
            if(params as? Int == 1){
                self.getAdhocHour()
            }
        }
        
        
    }
    
    @IBAction func addAvailabilityTapped(_ sender: Any) {
        
        ENTALDControllers.shared.showAddAvilabilityScreen(type: .ENTALDPUSH, from: self, action: "") { params, controller in
            
            if(params as? Int == 1){
                
                self.getAvailability()
            }
        }
    }
    
    
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func messageTapped(_ sender: Any) {
        ENTALDControllers.shared.showGroupMessageVC(type: .ENTALDPUSH, from: self, callBack: nil)
    }
    @IBAction func homeTapped(_ sender: Any) {
    
    }
    @IBAction func closeSearch(_ sender: Any) {

        textSearch.endEditing(true)
        textSearch.text = ""
        filterAvailablityData = availablityData
        filterVolunteerHourData = volunteerHourData
        filterAdhocData = adhocData
        
        availablityTableView.reloadData()
        voluteerHourTableView.reloadData()
        adhocTableView.reloadData()
        
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        
        if self.segment.selectedSegmentIndex == 0 {
            self.adhocView.isHidden = false
            self.volunteerHourView.isHidden = true
            self.availablityView.isHidden = true
            
            isAdhocTableSearch = true
            isVolunteerHourTableSearch = false
            isAvailablityTableSearch = false
           
        }else if (self.segment.selectedSegmentIndex == 1 ){
            self.adhocView.isHidden = true
            self.volunteerHourView.isHidden = false
            self.availablityView.isHidden = true
            
            isAdhocTableSearch = false
            isVolunteerHourTableSearch = true
            isAvailablityTableSearch = false
            
        }else if (self.segment.selectedSegmentIndex == 2 ){
            self.adhocView.isHidden = true
            self.volunteerHourView.isHidden = true
            self.availablityView.isHidden = false
            
            isAdhocTableSearch = false
            isVolunteerHourTableSearch = false
            isAvailablityTableSearch = true
        }
        self.textSearch.text = ""
    }
    
    
    
    @IBAction func adhocFilterTapped(_ sender: Any) {
        isAdhocTableSearch = true
        isVolunteerHourTableSearch = false
        isAvailablityTableSearch = false
        self.searchView.isHidden = false
        self.textSearch.placeholder = "Filter Adhoc Hour"
        
    }
    
    @IBAction func volunteerFilterTapped(_ sender: Any) {
        isAdhocTableSearch = false
        isVolunteerHourTableSearch = true
        isAvailablityTableSearch = false
        self.searchView.isHidden = false
        self.textSearch.placeholder = "Filter Volunteer Hour"
       
    }
    
    @IBAction func availablityFilterTapped(_ sender: Any) {
        
        isAdhocTableSearch = false
        isVolunteerHourTableSearch = false
        isAvailablityTableSearch = true
        self.searchView.isHidden = false
        self.textSearch.placeholder = "Filter Availability"
    }

    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnSearchClose.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        btnSearchClose.isHidden = true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (textField.text != "" && isAdhocTableSearch == true ){
            
            filterAdhocData  =  adhocData?.filter({
                if let name = $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                }
                return false
            })
            DispatchQueue.main.async {
                self.adhocTableView.reloadData()
            }
            
            
        }else if(textField.text != "" && isVolunteerHourTableSearch == true ){
            
            filterVolunteerHourData  =  volunteerHourData?.filter({
                if let name = $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle , name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                 }
               return false
             })
            
            DispatchQueue.main.async {
                self.voluteerHourTableView.reloadData()
            }
            
        }else if(textField.text != "" && isAvailablityTableSearch == true ){
            
            filterAvailablityData  =  availablityData?.filter({
                if let name = $0.msnfp_availabilitytitle, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                }
                return false
            })
            DispatchQueue.main.async {
                self.availablityTableView.reloadData()
            }
            
        }else{
            DispatchQueue.main.async {
                self.filterAdhocData = self.adhocData
                self.adhocTableView.reloadData()
                self.filterAvailablityData = self.availablityData
                self.availablityTableView.reloadData()
                self.filterVolunteerHourData = self.volunteerHourData
                self.voluteerHourTableView.reloadData()
            }
        }
    }
    
    // ============================  Filters  ===============================
    
    @IBAction func adhocTitleFilter(_ sender: Any) {
        if !isAdhocTitle{
            self.filterAdhocData = self.filterAdhocData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" < $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isAdhocTitle = true
        }else{
            self.filterAdhocData = self.filterAdhocData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" > $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isAdhocTitle = false
        }
        
        DispatchQueue.main.async {
            self.adhocTableView.reloadData()
        }
        
        self.isAdhocPrgram = false
        self.isAdhocHours = false
    }
    
    @IBAction func adhocProgramFilter(_ sender: Any) {
        if !isAdhocPrgram{
            self.filterAdhocData = self.filterAdhocData?.sorted {
                $0.program_name ?? "" < $1.program_name ?? ""
            }
            isAdhocPrgram = true
        }else{
            self.filterAdhocData = self.filterAdhocData?.sorted {
                $0.program_name ?? "" > $1.program_name ?? ""
            }
            isAdhocPrgram = false
        }
        
        DispatchQueue.main.async {
            self.adhocTableView.reloadData()
        }
        self.isAdhocTitle = false
        self.isAdhocHours = false
    }
    
    @IBAction func adhocHourFilter(_ sender: Any) {
        
        if !isAdhocHours{
            self.filterAdhocData = self.filterAdhocData?.sorted {
                $0.sjavms_hours ?? 0 < $1.sjavms_hours ?? 0
            }
            isAdhocHours = true
        }else{
            self.filterAdhocData = self.filterAdhocData?.sorted {
                $0.sjavms_hours ?? 0 > $1.sjavms_hours ?? 0
            }
            isAdhocHours = false
        }
        
        DispatchQueue.main.async {
            self.adhocTableView.reloadData()
        }
        
        self.isAdhocTitle = false
        self.isAdhocPrgram = false
    }
    
    @IBAction func volunteerTitleFilter(_ sender: Any) {
        if !isVolunteerEvent{
            self.filterVolunteerHourData = self.filterVolunteerHourData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" < $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isVolunteerEvent = true
        }else{
            self.filterVolunteerHourData = self.filterVolunteerHourData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" > $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isVolunteerEvent = false
        }
        
        DispatchQueue.main.async {
            self.voluteerHourTableView.reloadData()
        }
        

        self.isVolunteerProgram = false
        self.isVolunteerSchedule = false
        self.isVolunteerStart = false
        self.isVolunteerEnd = false
        self.isVolunteerHour = false
    }
    
    @IBAction func volunteerProgramFilter(_ sender: Any) {
        
        if !isVolunteerProgram{
            self.filterVolunteerHourData = self.filterVolunteerHourData?.sorted {
                $0.program_name ?? "" < $1.program_name ?? ""
            }
            isVolunteerProgram = true
        }else{
            self.filterVolunteerHourData = self.filterVolunteerHourData?.sorted {
                $0.program_name ?? "" > $1.program_name ?? ""
            }
            isVolunteerProgram = false
        }
        
        DispatchQueue.main.async {
            self.voluteerHourTableView.reloadData()
        }
        
        self.isVolunteerEvent = false
        self.isVolunteerSchedule = false
        self.isVolunteerStart = false
        self.isVolunteerEnd = false
        self.isVolunteerHour = false
    }
    
    @IBAction func volunteerScheduleFilter(_ sender: Any) {
        
        if !isVolunteerSchedule{
            self.filterVolunteerHourData = self.filterVolunteerHourData?.sorted {
                $0.msnfp_schedulestatus ?? 0 < $1.msnfp_schedulestatus ?? 0
            }
            isVolunteerSchedule = true
        }else{
            self.filterVolunteerHourData = self.filterVolunteerHourData?.sorted {
                $0.msnfp_schedulestatus ?? 0 > $1.msnfp_schedulestatus ?? 0
            }
            isVolunteerSchedule = false
        }
        
        DispatchQueue.main.async {
            self.voluteerHourTableView.reloadData()
        }
        
        self.isVolunteerEvent = false
        self.isVolunteerProgram = false
        self.isVolunteerStart = false
        self.isVolunteerEnd = false
        self.isVolunteerHour = false
    }
    @IBAction func volunteerStartFilter(_ sender: Any) {
        
        if !isVolunteerStart{
            self.filterVolunteerHourData = self.filterVolunteerHourData?.sorted {
                $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
            }
            isVolunteerStart = true
        }else{
            self.filterVolunteerHourData = self.filterVolunteerHourData?.sorted {
                $0.sjavms_start ?? "" > $1.sjavms_start ?? ""
            }
            isVolunteerStart = false
        }
        
        DispatchQueue.main.async {
            self.voluteerHourTableView.reloadData()
        }
        
        self.isVolunteerEvent = false
        self.isVolunteerProgram = false
        self.isVolunteerSchedule = false
        self.isVolunteerEnd = false
        self.isVolunteerHour = false
    }
    @IBAction func volunteerEndFilter(_ sender: Any) {
        
        if !isVolunteerEnd{
            self.filterVolunteerHourData = self.filterVolunteerHourData?.sorted {
                $0.sjavms_end ?? "" < $1.sjavms_end ?? ""
            }
            isVolunteerEnd = true
        }else{
            self.filterVolunteerHourData = self.filterVolunteerHourData?.sorted {
                $0.sjavms_end ?? "" > $1.sjavms_end ?? ""
            }
            isVolunteerEnd = false
        }
        
        DispatchQueue.main.async {
            self.voluteerHourTableView.reloadData()
        }
        
        self.isVolunteerEvent = false
        self.isVolunteerProgram = false
        self.isVolunteerSchedule = false
        self.isVolunteerStart = false
        self.isVolunteerHour = false
    }
    
    @IBAction func volunteerHourFilter(_ sender: Any) {
        
        if !isVolunteerHour{
            self.filterVolunteerHourData = self.filterVolunteerHourData?.sorted {
                $0.sjavms_hours ?? 0 < $1.sjavms_hours ?? 0
            }
            isVolunteerHour = true
        }else{
            self.filterVolunteerHourData = self.filterVolunteerHourData?.sorted {
                $0.sjavms_hours ?? 0 > $1.sjavms_hours ?? 0
            }
            isVolunteerHour = false
        }
        
        DispatchQueue.main.async {
            self.voluteerHourTableView.reloadData()
        }
        
        self.isVolunteerEvent = false
        self.isVolunteerProgram = false
        self.isVolunteerSchedule = false
        self.isVolunteerStart = false
        self.isVolunteerEnd = false
    }
    
    @IBAction func availabilityTitleFilter(_ sender: Any) {
        
        if !isAvailabilityTitle{
            self.filterAvailablityData = self.filterAvailablityData?.sorted {
                $0.msnfp_availabilitytitle ?? "" < $1.msnfp_availabilitytitle ?? ""
            }
            isAvailabilityTitle = true
        }else{
            self.filterAvailablityData = self.filterAvailablityData?.sorted {
                $0.msnfp_availabilitytitle ?? "" > $1.msnfp_availabilitytitle ?? ""
            }
            isAvailabilityTitle = false
        }
        
        DispatchQueue.main.async {
            self.availablityTableView.reloadData()
        }
        

        self.isAvailabilityEffectiveFrom = false
        self.isAvailabilityEffectiveTo = false
    }
    @IBAction func availabilityEffectiveFromFilter(_ sender: Any) {
        
        if !isAvailabilityEffectiveFrom{
            self.filterAvailablityData = self.filterAvailablityData?.sorted {
                $0.msnfp_effectivefrom ?? "" < $1.msnfp_effectivefrom ?? ""
            }
            isAvailabilityEffectiveFrom = true
        }else{
            self.filterAvailablityData = self.filterAvailablityData?.sorted {
                $0.msnfp_effectivefrom ?? "" > $1.msnfp_effectivefrom ?? ""
            }
            isAvailabilityEffectiveFrom = false
        }
        
        DispatchQueue.main.async {
            self.availablityTableView.reloadData()
        }
        
        self.isAvailabilityTitle = false
        self.isAvailabilityEffectiveTo = false
    }
    
    @IBAction func availabilityEffectiveToFilter(_ sender: Any) {
        
        if !isAvailabilityEffectiveTo{
            self.filterAvailablityData = self.filterAvailablityData?.sorted {
                $0.msnfp_effectiveto ?? "" < $1.msnfp_effectiveto ?? ""
            }
            isAvailabilityEffectiveTo = true
        }else{
            self.filterAvailablityData = self.filterAvailablityData?.sorted {
                $0.msnfp_effectiveto ?? "" > $1.msnfp_effectiveto ?? ""
            }
            isAvailabilityEffectiveTo = false
        }
        
        DispatchQueue.main.async {
            self.availablityTableView.reloadData()
        }

        
        self.isAvailabilityTitle = false
        self.isAvailabilityEffectiveFrom = false
    }
    
    
    
    



// ============================  API  ===============================



    
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
                    self.programsData = pastEvent
                    ProcessUtils.shared.programsData = self.programsData
//                    self.eventProgramData = self.getProgramName(self.eventData?._sjavms_program_value ?? "")
                    
                    DispatchQueue.main.async {
//                        self.lblProgramType.text = self.eventProgramData?.sjavms_name ?? ""
                        //contact info
                    }
//                    self.getAdhocHour()
//                    self.getAvailability()
//                    self.getVolunteerHour()
                    
                }
                completion(true)
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                completion(false)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
            
        }
        
        
    }

    func getAvailability(){
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_availabilitytitle,msnfp_effectivefrom,msnfp_effectiveto,msnfp_workingdays,msnfp_availabilityid",
            ParameterKeys.filter : "(_msnfp_contactid_value eq \(self.contactId))",
            ParameterKeys.orderby : "msnfp_effectivefrom desc"
            
        ]
        
        self.getAvailabilityData(params: params)
    }
    
    fileprivate func getAvailabilityData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestSideMenuAvailablityHour(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let availablity = response.value {
                    self.availablityData = availablity
                    self.filterAvailablityData = availablity
                    if (self.availablityData?.count == 0 || self.availablityData?.count == nil){
                        self.showEmptyView(tableVw: self.availablityTableView)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.availablityTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.availablityTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.availablityTableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
               
                self.showEmptyView(tableVw: self.availablityTableView)
                
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    func getVolunteerHour(){
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_schedulestatus,sjavms_start,sjavms_end,_sjavms_volunteerevent_value,_msnfp_engagementopportunityscheduleid_value,sjavms_hours,msnfp_participationscheduleid",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=_sjavms_program_value,msnfp_engagementopportunitytitle),msnfp_engagementOpportunityScheduleId($select=msnfp_shiftname,msnfp_engagementopportunityschedule)",
            ParameterKeys.filter : "(statecode eq 0 and _sjavms_volunteer_value eq \(self.contactId)) and (sjavms_VolunteerEvent/sjavms_adhocevent ne true)",
            ParameterKeys.orderby : "sjavms_start asc"
            
        ]
        self.getVolunteerHourData(params: params)
    }
    
    
    fileprivate func getVolunteerHourData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestSideMenuVolunteerHour(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let hours = response.value {
                    self.volunteerHourData = hours
                    self.filterVolunteerHourData = hours
                    if (self.volunteerHourData?.count == 0 || self.volunteerHourData?.count == nil){
                        self.showEmptyView(tableVw: self.voluteerHourTableView)
                    }else{
                        for i in (0 ..< (self.volunteerHourData?.count ?? 0)) {
                            if let value = self.getProgramName(self.volunteerHourData?[i].sjavms_VolunteerEvent?._sjavms_program_value  ?? ""){
                                self.volunteerHourData?[i].sjavms_VolunteerEvent?.program_name = value
                            }
                            

                        }
                        DispatchQueue.main.async {
                            for subview in self.voluteerHourTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.voluteerHourTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.voluteerHourTableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
               
                self.showEmptyView(tableVw: self.voluteerHourTableView)
                
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    
    func getAdhocHour(){
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_schedulestatus,sjavms_hours,msnfp_participationscheduleid",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=msnfp_engagementopportunitytitle,_sjavms_program_value)",
            ParameterKeys.filter : "(statecode eq 0 and _sjavms_volunteer_value eq \(self.contactId)) and (sjavms_VolunteerEvent/sjavms_adhocevent eq true)",
            ParameterKeys.orderby : "msnfp_schedulestatus desc"
            
        ]
        self.getAdhocHourData(params: params)
    }
    
    
    fileprivate func getAdhocHourData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestAdhocHour(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let hours = response.value {
                    self.adhocData = hours
                    
                    self.adhocData = self.adhocData?.sorted {
                        $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
                    }
                    
                    self.filterAdhocData = hours
                    if (self.adhocData?.count == 0 || self.adhocData?.count == nil){
                        self.showEmptyView(tableVw: self.adhocTableView)
                    }else{
                        
                        for i in (0 ..< (self.adhocData?.count ?? 0)) {
                            if let value = self.getProgramName(self.adhocData?[i].sjavms_VolunteerEvent?._sjavms_program_value ?? ""){
                                self.adhocData?[i].program_name = value
                            }

                        }
                        
                        
                        
                        DispatchQueue.main.async {
                            for subview in self.adhocTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.adhocTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.adhocTableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
               
                self.showEmptyView(tableVw: self.adhocTableView)
                
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    func getProgramName(_ programId:String)->String?{
        let programName = self.programsData?.filter({$0.sjavms_programid == programId}).first?.sjavms_name
        return programName
    }
    

}


extension AvailabilityVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.adhocTableView){
            return filterAdhocData?.count ?? 0
        }else if (tableView == voluteerHourTableView){
            return filterVolunteerHourData?.count ?? 0
        }else if (tableView == availablityTableView){
            return filterAvailablityData?.count ?? 0
        }

        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        if (tableView == self.adhocTableView){
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdhocHourCell", for: indexPath) as! AdhocHourCell


            let rowModel = self.filterAdhocData?[indexPath.row]
            let programName = self.getProgramName(rowModel?.sjavms_VolunteerEvent?._sjavms_program_value ?? "")
            cell.setContent(cellModel: rowModel , programName: programName)
            return cell

        }else if (tableView == voluteerHourTableView){

            let cell = tableView.dequeueReusableCell(withIdentifier: "VolunteerHourCell", for: indexPath) as! VolunteerHourCell
            
            let rowModel = self.filterVolunteerHourData?[indexPath.row]
            let programName = self.getProgramName(rowModel?.sjavms_VolunteerEvent?._sjavms_program_value ?? "")
            cell.setContent(cellModel: rowModel , programName: programName)
            return cell

        }else if (tableView == availablityTableView){

            let cell = tableView.dequeueReusableCell(withIdentifier: "AvailablityCell", for: indexPath) as! AvailablityCell

            let rowModel = self.filterAvailablityData?[indexPath.row]
            cell.setContent(cellModel: rowModel)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AvailablityCell", for: indexPath) as! AvailablityCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == availablityTableView {
            let rowModel = self.filterAvailablityData?[indexPath.row]
            ENTALDControllers.shared.showAddAvilabilityScreen(type: .ENTALDPUSH, from: self, dataObj : rowModel, action: "edit") { params, controller in
                if(params as? Int == 1){
                    self.getAvailability()
                }
            }
        }
    }
    
}

