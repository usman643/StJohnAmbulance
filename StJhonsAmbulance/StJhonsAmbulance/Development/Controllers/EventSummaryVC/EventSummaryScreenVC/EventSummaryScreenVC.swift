//
//  EventSummaryScreenVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 24/03/2023.
//

import UIKit

class EventSummaryScreenVC: ENTALDBaseViewController {

    var eventData : CurrentEventsModel?
    var summaryData : EventSummaryModel?
    var reportedShifts : [VolunteerOfEventDataModel]?
    var participantCount : [ParticipantsCountModel]?
    var programsData : [ProgramModel]?
    var selectedStatus : String?
    var adhocSelected : Bool?
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblProgram: UILabel!
    @IBOutlet weak var lblShortDesc: UILabel!
    @IBOutlet weak var btnSelectStatus: UIButton!
    @IBOutlet weak var btnSelectProgram: UIButton!
    @IBOutlet weak var txtEventName: UITextField!
    @IBOutlet weak var txtEventDesc: UITextView!
    @IBOutlet weak var btnAdhoc: UIButton!
    @IBOutlet weak var lblAdhoc: UILabel!
    @IBOutlet weak var tableHeadingView: UIView!
    @IBOutlet weak var eventDescTxtView: UIView!
    @IBOutlet weak var eventNameTxtView: UIView!
    @IBOutlet weak var selectStatusView: UIView!
    @IBOutlet weak var selectProgramView: UIView!
    @IBOutlet var lblTitles: [UILabel]!
    @IBOutlet var lblTableHeading: [UILabel]!
    @IBOutlet var lblShiftSchedule: [UILabel]!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblCancelShiftCount: UILabel!
    @IBOutlet weak var lblPendingShiftCount: UILabel!
    @IBOutlet weak var lblApprovedParticipantsCount: UILabel!
    @IBOutlet weak var lblCancelParticipantsCount: UILabel!
    @IBOutlet weak var lblPendingParticipantsCount: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EventSummaryScreenTVC", bundle: nil), forCellReuseIdentifier: "EventSummaryScreenTVC")
        decorateUI()
        getParticipantsCount()
        getSummaryData()
        getReportedShifts()
        getAllProgramesfile()
    }

    func decorateUI(){
        
        lblTitle.font = UIFont.BoldFont(22)
        lblStatus.font = UIFont.BoldFont(14)
        lblStatus.textColor = UIColor.themePrimaryColor
        lblEventName.font = UIFont.BoldFont(14)
        lblEventName.textColor = UIColor.themePrimaryColor
        lblProgram.font = UIFont.BoldFont(14)
        lblProgram.textColor = UIColor.themePrimaryColor
        lblShortDesc.font = UIFont.BoldFont(14)
        lblShortDesc.textColor = UIColor.themePrimaryColor
        lblAdhoc.font = UIFont.RegularFont(12)
        lblAdhoc.textColor = UIColor.themePrimaryColor
        selectStatusView.layer.cornerRadius = 5
        selectProgramView.layer.cornerRadius = 5
        eventNameTxtView.layer.borderWidth = 1
        eventNameTxtView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        eventDescTxtView.layer.borderWidth = 1
        eventDescTxtView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        tableHeadingView.layer.borderWidth = 1
        tableHeadingView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        txtEventName.font = UIFont.RegularFont(12)
        txtEventName.textColor = UIColor.themeBlackText
        txtEventDesc.font = UIFont.RegularFont(12)
        txtEventDesc.textColor = UIColor.themeBlackText
        btnSelectProgram.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSelectProgram.titleLabel?.font = UIFont.BoldFont(14)
        btnAdhoc.layer.cornerRadius = 3
        
        for label in lblTitles{
            label.font = UIFont.BoldFont(14)
            label.textColor = UIColor.themePrimaryWhite
        }
        
        for label in lblShiftSchedule{
            label.font = UIFont.BoldFont(13)
            label.textColor = UIColor.themePrimaryWhite
        }
        
        for label in lblTableHeading{
            label.font = UIFont.BoldFont(12)
            label.textColor = UIColor.themePrimaryWhite
        }
        
//        self.txtEventName.isUserInteractionEnabled = false
//        self.lblShortDesc.isUserInteractionEnabled = false
        
    }
    
    
    @IBAction func adhocEventTapped(_ sender: Any) {
        
        if (self.adhocSelected == true){
            self.adhocSelected = false
            self.btnAdhoc.setImage(UIImage(named: ""), for: .normal)
            self.btnAdhoc.backgroundColor = UIColor.viewLightGrayColor
        }else{
            self.adhocSelected = true
            self.btnAdhoc.setImage(UIImage(named: "ic_check"), for: .normal)
            self.btnAdhoc.backgroundColor = UIColor.clear
        }
        
        
    }
    @IBAction func submitTapped(_ sender: Any) {
        
        self.updatedata()
    }
    
    @IBAction func volunteerFilter(_ sender: Any) {
    }
    
    @IBAction func evnetFilter(_ sender: Any) {
    }
    
    @IBAction func startFilter(_ sender: Any) {
    }
    
    @IBAction func hourFilter(_ sender: Any) {
    }
    
    @IBAction func eventStatusChange(_ sender: Any) {
        self.showGroupsPicker()
    }
    
    
    func setupData(){
//        let locationType = ProcessUtils.shared.getLocationType(code: self.summaryData?.msnfp_locationtype ?? 00)
//        btnSelectProgram.setTitle(locationType, for: .normal)
        self.txtEventName.text = self.summaryData?.msnfp_engagementopportunitytitle ?? ""
        self.txtEventDesc.text = self.summaryData?.msnfp_shortdescription ?? ""
        if (self.summaryData?.sjavms_adhocevent == true) {
            self.adhocSelected = true
            self.btnAdhoc.setImage(UIImage(named: "ic_check"), for: .normal)
            self.btnAdhoc.backgroundColor = UIColor.clear
        }else{
            self.adhocSelected = false
            self.btnAdhoc.setImage(UIImage(named: ""), for: .normal)
            self.btnAdhoc.backgroundColor = UIColor.viewLightGrayColor
        }
        let status = ProcessUtils.shared.eventStatusArr[self.summaryData?.msnfp_engagementopportunitystatus ?? 0]
        self.btnSelectStatus.setTitle(status, for: .normal)
    }

    func setupReportedShiftData(){
        
        self.lblCancelShiftCount.text = "\(self.reportedShifts?.filter({$0.msnfp_schedulestatus == 335940003}).count ?? 00)"
        self.lblPendingShiftCount.text = "\(self.reportedShifts?.filter({$0.msnfp_schedulestatus == 335940000}).count  ?? 00 )"
    }
    
    func setupParticipantsData(){
        
        let approved = self.participantCount?.filter({$0.msnfp_status == 844060002}).first?.Participation
        let cancelled = self.participantCount?.filter({$0.msnfp_status == 844060004}).first?.Participation
        let pending = self.participantCount?.filter({$0.msnfp_status == 844060000}).first?.Participation
        self.lblApprovedParticipantsCount.text = "\(approved ?? 00)"
        self.lblCancelParticipantsCount.text = "\(cancelled ?? 00)"
        self.lblPendingParticipantsCount.text = "\(pending ?? 00)"
    }
    
    func showGroupsPicker(){
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.eventStatus, dataObj: ProcessUtils.shared.eventStatusArr) { params, controller in
            self.selectedStatus  = params as? String
            var status = ProcessUtils.shared.eventStatusArr.filter({$0.value == params as? String}).first?.key
            self.updateEventStatus(statusValue : status ?? NSNotFound)
        }
    }
    
    
    // =========================== API ===========================
    
    
    fileprivate func getSummaryData(){
        guard let eventId = self.eventData?.msnfp_engagementopportunityid else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "_sjavms_group_value,sjavms_onsiteparking,sjavms_tableschairsseating,msnfp_engagementopportunityid,sjavms_designatedvolunteerarea,sjavms_cleandrinkingwater,sjavms_othertreatments,sjavms_designatedspaceforvolunteers,sjavms_electricalpowersupply,msnfp_stateprovince,msnfp_shortdescription,_sjavms_program_value,sjavms_foodforvolunteers,msnfp_filledshifts,statuscode,msnfp_location,sjavms_age1860,msnfp_description,msnfp_maximum,_sjavms_branch_value,msnfp_endingdate,sjavms_onsitefoodforvolunteers,sjavms_age13under,msnfp_appliedparticipants,sjavms_age60,sjavms_eventscheduleinformation,msnfp_engagementopportunitystatus,sjavms_bathrooms,_sjavms_contact_value,msnfp_engagementopportunitytitle,msnfp_completed,sjavms_onsitecleandrinkingwater,_sjavms_council_value,msnfp_street1,msnfp_street2,sjavms_age1417,msnfp_shifts,sjavms_donationreceived,_msnfp_primarycontactid_value,sjavms_willotherhealthcareagenciesbeonsite,msnfp_number,sjavms_numberofparticipants,msnfp_cancelledshifts,sjavms_multidayevent,sjavms_firstaidroomtent,sjavms_emergencyservicescalled,sjavms_sitemapifapplicable,sjavms_onsitedesignatedvolunteerarea,_sjavms_eventcoordinator_value,sjavms_totalapproved,sjavms_onsitecellphonereception,sjavms_telephone,sjavms_onsitebathrooms,sjavms_onsiteother,sjavms_cellphonereception,_sjavms_account_value,msnfp_locationtype,sjavms_patientstreated,sjavms_onsitefirstaidroomtent,_sjavms_posteventsurvey_value,msnfp_minimum,sjavms_onsitetelephone,msnfp_city,sjavms_parking,sjavms_eventorganizerprovidedadequatesupport,msnfp_multipledays,msnfp_startingdate,sjavms_donationintended,msnfp_street3,sjavms_othercomments,sjavms_eventrequirements,sjavms_surveycomments,statecode,sjavms_adhocevent,sjavms_shadedareaifoutside,msnfp_zippostalcode,sjavms_locationcontactname,sjavms_maxparticipants",
            ParameterKeys.filter : "(msnfp_engagementopportunityid eq \(eventId))",

        ]

        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getEventSummary(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let summaryData = response.value {
                    if summaryData.count > 0 {
                        self.summaryData = summaryData[0]
                        DispatchQueue.main.async {
                            self.setupData()
                        }
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
    
    
    
      fileprivate func getReportedShifts(){
        guard let eventId = self.eventData?.msnfp_engagementopportunityid else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_schedulestatus,sjavms_start,sjavms_hours,_sjavms_volunteerevent_value,_sjavms_volunteer_value,msnfp_participationscheduleid,sjavms_checkedin,sjavms_end",
            ParameterKeys.filter : "(_sjavms_volunteerevent_value eq \(eventId))",
            ParameterKeys.expand : "sjavms_Volunteer($select=fullname)",
            ParameterKeys.orderby : "_sjavms_volunteer_value asc,_sjavms_volunteerevent_value asc"
            
        ]

        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getReportedShifts(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let shiftData = response.value {
                    self.reportedShifts = shiftData
                    if (self.reportedShifts?.count == 0 || self.reportedShifts?.count == nil){
                        self.showEmptyView(tableVw: self.tableView)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.tableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                        
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.setupReportedShiftData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.tableView)
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


    fileprivate func getParticipantsCount(){
        guard let eventId = self.eventData?.msnfp_engagementopportunityid else {return}
        let params : [String:Any] = [
   
            ParameterKeys.apply : "filter((_msnfp_engagementopportunityid_value eq \(eventId)))/groupby((msnfp_status),aggregate($count as Participation))"

        ]

        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getParticipantCount(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let shiftData = response.value {
                    self.participantCount = shiftData
                    DispatchQueue.main.async {
                        self.setupParticipantsData()
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
    
    private func getAllProgramesfile(){
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
                    
                    let program = self.getProgramName(self.summaryData?._sjavms_program_value ?? "")
                    
                    
                    DispatchQueue.main.async {
                        
                        self.btnSelectProgram.setTitle(program?.sjavms_name ?? "Not Found", for: .normal)
//                        self.lblProgramType.text = self.eventProgramData?.sjavms_name ?? ""
                        //contact info
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
    
    
    func updateEventStatus(statusValue:Int){
        
            DispatchQueue.main.async {
                LoadingView.show()
            }
            var params:[String:Any] = [:]
            
            
                params["msnfp_engagementopportunitystatus"] = statusValue as Int
                
        ENTALDLibraryAPI.shared.updateEventStatus(eventid: self.eventData?.msnfp_engagementopportunityid ?? "", params: params){ result in
                DispatchQueue.main.async {
                    LoadingView.hide()
                }
                switch result{
                case .success(value: _):
                    break
                case .error(let error, let errorResponse):
                    if error == .patchSuccess {
                        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Event Status Update Successfully", message: "", actionTitle: .KOK, completion: { status in })
                        self.btnSelectStatus.setTitle(self.selectedStatus, for: .normal)
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
    
    
    
    fileprivate func updatedata(){

        let params = [
            "msnfp_engagementopportunitytitle": self.txtEventName.text as? String,
            "msnfp_shortdescription": self.txtEventDesc.text as? String,
            "sjavms_adhocevent": self.adhocSelected as? Bool
            
        ] as [String : Any]
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        let eventId = self.eventData?.msnfp_engagementopportunityid ?? ""
        
        ENTALDLibraryAPI.shared.updateSummaryData(eventId: eventId, params: params) { result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: _):
                DispatchQueue.main.async {
                    LoadingView.hide()
                }
                
            case .error(let error, let errorResponse):
                if error == .patchSuccess {
                    debugPrint("Successfully Updated")
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
    
    
    
    
    
    
    
    
    
    
    
    
    func getProgramName(_ programId:String)->ProgramModel?{
        let programModel = self.programsData?.filter({$0.sjavms_programid == programId}).first
        return programModel
    }
    
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
}


extension EventSummaryScreenVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reportedShifts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventSummaryScreenTVC", for: indexPath) as! EventSummaryScreenTVC
        
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
            cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
        }else{
            cell.backgroundColor = UIColor.viewLightColor
            cell.seperaterView.backgroundColor = UIColor.gray
        }
        
        
        let rowModel = self.reportedShifts?[indexPath.row]
        cell.setContent(rowModel : rowModel , eventName : self.eventData?.msnfp_engagementopportunitytitle)
        
        
        return cell
    }
    
    
    
    
    
    
}
