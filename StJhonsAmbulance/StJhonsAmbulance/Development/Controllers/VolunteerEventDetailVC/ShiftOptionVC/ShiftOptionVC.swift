//
//  ShiftOptionVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 19/03/2023.
//

import UIKit

protocol updateShiftOptionDelegate {
    
    func bookShift(eventId:String , participationId: String)
    func cancelShift(eventId:String, participationId: String)
}

class ShiftOptionVC: ENTALDBaseViewController {
    
    var userParticipantData : VolunteerEventParticipationCheckModel?
    var participationData : [VolunteerEventParticipationCheckModel]?
    let contactId = UserDefaults.standard.contactIdToken ?? ""
    var eventOptions : [VolunteerEventClickOptionModel]?
    var eventOptionsMapped : [VolunteerEventClickOptionModel]?
    var eventOptionsData : [VolunteerEventClickOptionModel]?
    var eventStatus : [VolunteerStatusShift]?
    
    var eventId : String?
    var isBottombtnEnable : Bool?
    var isShiftFilterApplied = false
    var isStartFilterApplied = false
    var isEndFilterApplied = false
    var isHourFilterApplied = false
    var isNeedFilterApplied = false
    
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet var headingAllLabel: [UILabel]!
    @IBOutlet weak var tableHeadingView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnBook: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.decorateUI()
        registerCell()
//        getEventParitionCheck()
        self.getEventOptions()
    }
    
    func registerCell(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ShiftOptionTVC", bundle: nil), forCellReuseIdentifier: "ShiftOptionTVC")
        
    }
    
    func decorateUI(){
        lblTitle.font = UIFont.BoldFont(22)
        lblTitle.textColor = UIColor.themePrimaryColor
        for label in headingAllLabel{
            label.font = UIFont.RegularFont(11)
            label.textColor = UIColor.themePrimaryWhite
        }
        tableHeadingView.layer.borderWidth = 1.5
        tableHeadingView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        btnCancel.layer.cornerRadius = btnCancel.frame.size.height/2
        btnCancel.backgroundColor = UIColor.themePrimaryColor
        btnCancel.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnCancel.titleLabel?.textColor = UIColor.textWhiteColor
        btnCancel.titleLabel?.font = UIFont.BoldFont(16)
        btnBook.layer.cornerRadius = btnBook.frame.size.height/2
        btnBook.backgroundColor = UIColor.themePrimaryColor
        btnBook.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnBook.titleLabel?.textColor = UIColor.textWhiteColor
        btnBook.titleLabel?.font = UIFont.BoldFont(16)
        if (isBottombtnEnable == false) {
            btnCancel.isEnabled = false
            btnCancel.backgroundColor = UIColor.lightGray
            btnBook.backgroundColor = UIColor.lightGray
            btnBook.isEnabled = false
        }
    }
    
    
    
    func bookShift(){
        
        var selectedEvents:[[String: Any]] = []
        
        
        for i in (0..<(self.eventOptionsData?.count ?? 0)){
            
            for j in (0..<(self.eventOptionsData?[i].filterdata()?.count ?? 0)){
                
                if(self.eventOptionsData?[i].filterdata()?[j].participation_selected == true){
                    
                    
                    let startDate = self.eventOptionsData?[i].msnfp_effectivefrom ?? ""
                    let endDate = self.eventOptionsData?[i].msnfp_effectiveto ?? ""
                    let participationId = self.eventOptionsData?[i].filterdata()?[j]._msnfp_participationid_value ?? ""
                    let engagementopportunityscheduleid = self.eventOptionsData?[i].msnfp_engagementopportunityscheduleid ?? ""
                    let hour = self.eventOptionsData?[i].msnfp_hours ?? Float(NSNotFound)
                    let eventid = self.eventId ?? ""
                    
                    let params = [
                        
                        "sjavms_start" : startDate as String,
                        "sjavms_end" : endDate as String,
                        "msnfp_participationId@odata.bind" : "/msnfp_participations(\(participationId))" as String,
                        "sjavms_Volunteer@odata.bind" :  "/contacts(\(self.contactId))" as String,
                        "msnfp_engagementOpportunityScheduleId@odata.bind" : "/msnfp_engagementopportunityschedules(\(engagementopportunityscheduleid))" as String,
                        "sjavms_VolunteerEvent@odata.bind" : "/msnfp_engagementopportunities(\(eventid))" as String,
                        "sjavms_hours" : hour as Float
                    ] as [String : Any]
                    
                    selectedEvents.append(params)
                    
//                    selectedEvents.append(self.eventOptionsData?[i].filterdata()?[j]._msnfp_participationid_value ?? "")
                }
            }
        }
        
        
        
        
        
        
        
        
        
//        let selectedEvents = self.eventOptionsData?.filter( {$0.event_selected == true})
//
//        for i in (0..<(selectedEvents?.count ?? 0 )){
//
//            if let data = selectedEvents?[i] as? VolunteerEventClickOptionModel {
//
//                let startDate = data.msnfp_effectivefrom ?? ""
//                let endDate = data.msnfp_effectiveto ?? ""
//                let participationId = self.userParticipantData?.msnfp_participationid ?? ""
//                let engagementopportunityscheduleid = data.msnfp_engagementopportunityscheduleid ?? ""
//                let hour = data.msnfp_hours ?? Float(NSNotFound)
//                let eventid = self.eventId ?? ""
//
//                let params = [
//
//                    "sjavms_start" : startDate as String,
//                    "sjavms_end" : endDate as String,
//                    "msnfp_participationId@odata.bind" : "/msnfp_participations(\(participationId))" as String,
//                    "sjavms_Volunteer@odata.bind" :  "/contacts(\(self.contactId))" as String,
//                    "msnfp_engagementOpportunityScheduleId@odata.bind" : "/msnfp_engagementopportunityschedules(\(engagementopportunityscheduleid))" as String,
//                    "sjavms_VolunteerEvent@odata.bind" : "/msnfp_engagementopportunities(\(eventid))" as String,
//                    "sjavms_hours" : hour as Float
//                ] as [String : Any]
        
        for i in (0..<(selectedEvents.count )){
            
                self.bookEvents(params: selectedEvents[i])
            }
//        }
    }
    
    func bookEvents(params: [String : Any]) {
        DispatchQueue.main.async {
            LoadingView.show()
        }
        ENTALDLibraryAPI.shared.bookShift(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success:
                break
            case .error(let error, let errorResponse):
                
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in
                        
                    })
                }
            }
        }
    }
    
    
    
    
    
    
    func cancelShift(){
        
        var selectedEvents:[String] = []
        
        
        for i in (0..<(self.eventOptionsData?.count ?? 0)){
            
            for j in (0..<(self.eventOptionsData?[i].filterdata()?.count ?? 0)){
                
                if(self.eventOptionsData?[i].filterdata()?[j].participation_selected == true){
                    
                    selectedEvents.append(self.eventOptionsData?[i].filterdata()?[j]._msnfp_participationid_value ?? "")
                }
            }
        }
        
        for i in (0..<(selectedEvents.count )){
                let params = [
                    
                    "msnfp_engagementopportunitystatus": 335940003 as Int
                ] as [String : Any]
                
                self.closeVolunteersData(params: params, eventid: selectedEvents[i] )
            
        }
    }
    
    fileprivate func closeVolunteersData(params : [String:Any], eventid: String){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        //        let eventId = self.eventData?.msnfp_engagementopportunityid ?? ""
        ENTALDLibraryAPI.shared.cancelVolunteerShift(eventId:eventid , params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                if let pastEvent = response.value {

                }else{
//                    self.showEmptyView(tableVw: self.tableView)
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
    
    
    
    fileprivate func closeVolunteersShift(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        let params = [
            
            "msnfp_schedulestatus": 335940003 as Int
        ] as [String : Any]
        
                let eventId = self.eventId ?? ""
        ENTALDLibraryAPI.shared.cancelVolunteerShift(eventId:eventId , params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: _):
                break
            case .error(let error, let errorResponse):
                if error == .patchSuccess {
//                    ENTALDAlertView.shared.showContactAlertWithTitle(title: "Event Status Update Successfully", message: "", actionTitle: .KOK, completion: { status in })
                    
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
    
    
    func getEventParitionCheck() {
        
        let params : [String:Any] = [
            ParameterKeys.filter : "(_msnfp_engagementopportunityid_value eq \(self.eventId ?? "" ) and statecode eq 0)"
        ]
        
        self.getEventParitionCheckData(params: params)
        
    }
    
    fileprivate func getEventParitionCheckData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getEventParticipationCheck(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let option = response.value {
                    self.participationData = option
                    let modelData = self.participationData?.filter({$0._msnfp_contactid_value == self.contactId}).first
                    self.userParticipantData = modelData
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
    
    
    
    
    
    
    
    // ================== Filters =================
    
    @IBAction func filterTapped(_ sender: Any) {
        
        if !isShiftFilterApplied{
            self.eventOptionsData = self.eventOptionsData?.sorted {
                $0.msnfp_engagementopportunityschedule ?? "" < $1.msnfp_engagementopportunityschedule ?? ""
            }
            isShiftFilterApplied = true
        }else{
            self.eventOptionsData = self.eventOptionsData?.sorted {
                $0.msnfp_engagementopportunityschedule ?? "" > $1.msnfp_engagementopportunityschedule ?? ""
            }
            isShiftFilterApplied = false
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        isShiftFilterApplied = false
        isStartFilterApplied = false
        isEndFilterApplied = false
        isHourFilterApplied = false
        isNeedFilterApplied = false
    }
    @IBAction func shiftFilterTapped(_ sender: Any) {
        if !isShiftFilterApplied{
            self.eventOptionsData = self.eventOptionsData?.sorted {
                $0.msnfp_engagementopportunityschedule ?? "" < $1.msnfp_engagementopportunityschedule ?? ""
            }
            isShiftFilterApplied = true
        }else{
            self.eventOptionsData = self.eventOptionsData?.sorted {
                $0.msnfp_engagementopportunityschedule ?? "" > $1.msnfp_engagementopportunityschedule ?? ""
            }
            isShiftFilterApplied = false
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        isStartFilterApplied = false
        isEndFilterApplied = false
        isHourFilterApplied = false
        isNeedFilterApplied = false
        
    }
    @IBAction func startFilterTapped(_ sender: Any) {
        if !isStartFilterApplied{
            self.eventOptionsData = self.eventOptionsData?.sorted {
                $0.msnfp_effectivefrom ?? "" < $1.msnfp_effectivefrom ?? ""
            }
            isStartFilterApplied = true
        }else{
            self.eventOptionsData = self.eventOptionsData?.sorted {
                $0.msnfp_effectivefrom ?? "" > $1.msnfp_effectivefrom ?? ""
            }
            isStartFilterApplied = false
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        isShiftFilterApplied = false
        isEndFilterApplied = false
        isHourFilterApplied = false
        isNeedFilterApplied = false
        
    }
    @IBAction func endFilterTapped(_ sender: Any) {
        if !isEndFilterApplied{
            self.eventOptionsData = self.eventOptionsData?.sorted {
                $0.msnfp_effectiveto ?? "" < $1.msnfp_effectiveto ?? ""
            }
            isEndFilterApplied = true
        }else{
            self.eventOptionsData = self.eventOptionsData?.sorted {
                $0.msnfp_effectiveto ?? "" > $1.msnfp_effectiveto ?? ""
            }
            isEndFilterApplied = false
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        isShiftFilterApplied = false
        isStartFilterApplied = false
        isHourFilterApplied = false
        isNeedFilterApplied = false
        
    }
    @IBAction func hoursFilterTapped(_ sender: Any) {
        if !isHourFilterApplied{
            self.eventOptionsData = self.eventOptionsData?.sorted {
                $0.msnfp_hours ?? Float() < $1.msnfp_hours ?? Float()
            }
            isHourFilterApplied = true
        }else{
            self.eventOptionsData = self.eventOptionsData?.sorted {
                $0.msnfp_hours ?? Float() > $1.msnfp_hours ?? Float()
            }
            isHourFilterApplied = false
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        isShiftFilterApplied = false
        isStartFilterApplied = false
        isEndFilterApplied = false
        isNeedFilterApplied = false
        isHourFilterApplied = false
        
    }
    
    @IBAction func neededFilterTapped(_ sender: Any) {
        if !isNeedFilterApplied{
            self.eventOptionsData = self.eventOptionsData?.sorted {
                $0.msnfp_maximum ?? NSNotFound < $1.msnfp_maximum ?? NSNotFound
            }
            isNeedFilterApplied = true
        }else{
            self.eventOptionsData = self.eventOptionsData?.sorted {
                $0.msnfp_maximum ?? NSNotFound > $1.msnfp_maximum ?? NSNotFound
            }
            isNeedFilterApplied = false
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        isShiftFilterApplied = false
        isStartFilterApplied = false
        isEndFilterApplied = false
        
        
    }
    
    @IBAction func bokkEventTapped(_ sender: Any) {
        self.bookShift()
        //        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
    }
    
    @IBAction func closeEventTapped(_ sender: Any) {
        self.cancelShift()
        //        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
        
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
            ParameterKeys.select : "msnfp_engagementopportunityschedule,createdon,msnfp_totalhours,msnfp_startperiod,msnfp_hoursperday,_msnfp_engagementopportunity_value,msnfp_endperiod,msnfp_effectiveto,msnfp_effectivefrom,msnfp_workingdays,msnfp_engagementopportunityscheduleid,msnfp_hours,msnfp_maximum,msnfp_number,msnfp_minimum",
            ParameterKeys.expand : "msnfp_ParticipationSchedule_engagementOpp($select=msnfp_participationscheduleid,_msnfp_participationid_value,_sjavms_volunteer_value,msnfp_name,msnfp_schedulestatus;$filter=(_sjavms_volunteer_value eq \(self.contactId)))",
            ParameterKeys.filter : "(statecode eq 0 and _msnfp_engagementopportunity_value eq \(self.eventId ?? ""))",
            ParameterKeys.orderby : "msnfp_engagementopportunityschedule asc"
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
                    self.eventOptions = option
                    self.eventOptionsData = option
                    
                    if (self.eventOptions?.count == 0 || self.eventOptions?.count == nil){
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
    
    
}



extension ShiftOptionVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.eventOptionsData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventOptionsData?[section].filterdata()?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShiftOptionTVC", for: indexPath) as! ShiftOptionTVC
        
        
         let rowModel = self.eventOptionsData?[indexPath.section].filterdata()?[indexPath.row]
            if indexPath.row % 2 == 0{
                cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
                cell.seperatorView.backgroundColor = UIColor.themePrimary
            }else{
                cell.mainView.backgroundColor = UIColor.viewLightColor
                cell.seperatorView.backgroundColor = UIColor.gray
            }
            
            cell.setContent(cellModel: self.eventOptionsData?[indexPath.section] , rowModel : rowModel)
  
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isBottombtnEnable == true{
            var obj = self.eventOptionsData?[indexPath.section].filterdata()?[indexPath.row]
            
            if (self.eventOptionsData?[indexPath.section].filterdata()?[indexPath.row].participation_selected ?? false){
                
                obj?.participation_selected = false
//                self.eventOptionsData?[indexPath.section].filterdata()?[indexPath.row].participation_selected = false
            }else{
                obj?.participation_selected = true
                
//                self.eventOptionsData?[indexPath.section].filterdata()?[indexPath.row].participation_selected = true
                
            }
//            tableView.reloadData()
            tableView.reloadRows(at: [indexPath], with: .none)
            
        }
    }
}
