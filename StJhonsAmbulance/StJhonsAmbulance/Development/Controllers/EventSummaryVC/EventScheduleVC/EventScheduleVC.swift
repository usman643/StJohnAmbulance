//
//  EventScheduleVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/03/2023.
//

import UIKit

class EventScheduleVC: ENTALDBaseViewController {

    var eventData : CurrentEventsModel?
    var scheduleEvent : [VolunteerEventClickOptionModel]?
    var summaryData : EventSummaryModel?
    var selectedStatus : String?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var lblSectionTitle: [UILabel]!
    @IBOutlet var lblTextFieldTitles: [UILabel]!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var btnStatusView: UIView!
    @IBOutlet var allTxtField: [UITextField]!
    @IBOutlet var lblTableHeadings: [UILabel]!
    @IBOutlet var lblAge: [UILabel]!
    @IBOutlet weak var lblMultidayEvent: UILabel!
    @IBOutlet weak var btnMultiday: UIButton!
    @IBOutlet weak var btnAgeOne: UIButton!
    @IBOutlet weak var btnAgeTwo: UIButton!
    @IBOutlet weak var btnAgeThree: UIButton!
    @IBOutlet weak var btnAgeFour: UIButton!
    
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtStartTime: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var txtEndTime: UITextField!
    @IBOutlet weak var minVolunteer: UITextField!
    @IBOutlet weak var maxDailyAttendance: UITextField!
    @IBOutlet weak var maxVolunteer: UITextField!
    
    
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getEventOptions()
        getSummaryData()
        decorateUI()
      
    }
    
    func registerCell(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "EventScheduleTVC", bundle: nil), forCellReuseIdentifier: "EventScheduleTVC")
    }
    
    func decorateUI(){
        lblTitle.font = UIFont.BoldFont(22)
        btnStatusView.layer.cornerRadius = 5
        btnStatus.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnStatus.titleLabel?.font = UIFont.BoldFont(14)
        btnMultiday.layer.cornerRadius = 3
        lblMultidayEvent.font = UIFont.RegularFont(12)
        lblMultidayEvent.textColor = UIColor.themePrimaryWhite
        for label in lblAge{
            label.font = UIFont.RegularFont(14)
            label.textColor = UIColor.themePrimaryWhite
        }
        
        for label in lblSectionTitle{
            label.font = UIFont.BoldFont(14)
            label.textColor = UIColor.themePrimaryWhite
        }
        for label in lblTableHeadings{
            label.font = UIFont.BoldFont(10)
            label.textColor = UIColor.themePrimaryWhite
        }
        for label in lblTextFieldTitles{
            label.font = UIFont.BoldFont(13)
            label.textColor = UIColor.themePrimaryWhite
        }

        for txtField in allTxtField{
            txtField.font = UIFont.RegularFont(13)
            txtField.textColor = UIColor.themePrimaryWhite
            txtField.layer.borderWidth = 1
            txtField.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        }
        
    }
    
    func setupData(){
        
        if let date = self.summaryData?.msnfp_startingdate {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
            txtStartDate.text = start
        }else{
            txtStartDate.text = ""
        }
        
        if let date = self.summaryData?.msnfp_startingdate {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            txtStartTime.text = start
        }else{
            txtStartTime.text = ""
        }
        
        if let date = self.summaryData?.msnfp_endingdate{
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
            txtEndDate.text = start
        }else{
            txtEndDate.text = ""
        }
        
        if let date = self.summaryData?.msnfp_endingdate {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            txtEndTime.text = start
        }else{
            txtEndTime.text = ""
        }
        minVolunteer.text = "\(self.summaryData?.msnfp_minimum ?? NSNotFound)"
        maxDailyAttendance.text = ""
        maxVolunteer.text = "\(self.summaryData?.msnfp_maximum ?? NSNotFound)"
        self.setBtn(btn: btnMultiday, value: self.summaryData?.msnfp_multipledays ?? false)
        
        self.setBtn(btn: btnAgeOne, value: self.summaryData?.sjavms_age13under ?? false)
        self.setBtn(btn: btnAgeTwo, value: self.summaryData?.sjavms_age1417 ?? false)
        self.setBtn(btn: btnAgeThree, value: self.summaryData?.sjavms_age1860 ?? false)
        self.setBtn(btn: btnAgeFour, value: self.summaryData?.sjavms_age60 ?? false)
        
        let status = ProcessUtils.shared.eventStatusArr[self.summaryData?.msnfp_engagementopportunitystatus ?? 0]
        self.btnStatus.setTitle(status, for: .normal)
        
    }
    @IBAction func eventStatusUpdate(_ sender: Any) {
        self.showGroupsPicker()
    }
    
    func setBtn(btn: UIButton , value : Bool){
        
        if (value == true) {
            btn.setImage(UIImage(named: "ic_check"), for: .normal)
            btn.backgroundColor = UIColor.clear
        }else{
            btn.setImage(UIImage(named: ""), for: .normal)
            btn.backgroundColor = UIColor.viewLightGrayColor
        }
        
    }
    
    
    
    
    @IBAction func age1Tapped(_ sender: Any) {
    }

    @IBAction func age2Tapped(_ sender: Any) {
    }
    
    @IBAction func age3Tapped(_ sender: Any) {
    }
    
    @IBAction func age4Tapped(_ sender: Any) {
    }
    
    
    @IBAction func submitTapped(_ sender: Any) {
    }
    
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
    
    func getEventOptions() {
        
        let params : [String:Any] = [
            ParameterKeys.select : "statecode,msnfp_effectivefrom,msnfp_effectiveto,msnfp_engagementopportunityscheduleid,msnfp_hours,msnfp_maximum,msnfp_minimum,msnfp_number,msnfp_engagementopportunityschedule",
            ParameterKeys.filter : "(_msnfp_engagementopportunity_value eq \(self.eventData?.msnfp_engagementopportunityid ?? ""))"
        ]
        
        self.getEventOptionData(params: params)
        
    }
    
    
    fileprivate func getEventOptionData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerEventClickOption(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let option = response.value {
                    self.scheduleEvent = option
                    if (self.scheduleEvent?.count == 0 || self.scheduleEvent?.count == nil){
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
                    self.summaryData = summaryData[0]
                    DispatchQueue.main.async {
                        self.setupData()
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
    
    func showGroupsPicker(){
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.eventStatus, dataObj: ProcessUtils.shared.eventStatusArr) { params, controller in
            self.selectedStatus  = params as? String
            var status = ProcessUtils.shared.eventStatusArr.filter({$0.value == params as? String}).first?.key
            self.updateEventStatus(statusValue : status ?? NSNotFound)
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
                        self.btnStatus.setTitle(self.selectedStatus, for: .normal)
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
    

    
    
}

extension EventScheduleVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scheduleEvent?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventScheduleTVC", for: indexPath) as! EventScheduleTVC
        if indexPath.row % 2 == 0{
            
            cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
            cell.seperaterView.backgroundColor = UIColor.themePrimary
        }else{
            cell.mainView.backgroundColor = UIColor.viewLightColor
            cell.seperaterView.backgroundColor = UIColor.gray
        }
        
        cell.setContent(cellModel: self.scheduleEvent?[indexPath.row])
        
        return cell
    }
}