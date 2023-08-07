//
//  ScheduleVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 07/02/2023.
//

import UIKit
import FSCalendar

class ScheduleVC: ENTALDBaseViewController,FSCalendarDelegate ,FSCalendarDataSource{
    
    var scheduleGroupData : [ScheduleGroupsModel]?
    var scheduleEngagementData : [ScheduleModelTwo]?
    var scheduleData : [ScheduleModelThree]?
    //    var scheduleData : [ScheduleEventDataModel]?
    var calendar : FSCalendar!
    var formatter = DateFormatter()
    let contactId = UserDefaults.standard.contactIdToken ?? ""
    
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnCalender: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblCalender: UILabel!
    @IBOutlet weak var lblSignup: UILabel!
    @IBOutlet weak var lblEvents: UILabel!
    
    
    @IBOutlet weak var calenderView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        decorateUI()
        getScheduleInfo()
        
        calendar = FSCalendar(frame: CGRect(x:0.0,y:0.0,width: self.calenderView.frame.size.width, height: self.calenderView.frame.size.height))
        calendar.scrollDirection = .vertical
        self.calenderView.addSubview(calendar)
        calendar.delegate = self
        calendar.dataSource = self
        
    }
    
    func registerCell(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ScheduleCell", bundle: nil), forCellReuseIdentifier: "ScheduleCell")
    }
    
    func decorateUI(){
//        mainContentView.backgroundColor = UIColor.clear
        mainContentView.layer.cornerRadius = 30
        mainContentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        lblTitle.textColor = UIColor.themePrimaryWhite
        lblTitle.font = UIFont.BoldFont(24)
        
        btnSignUp.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSignUp.titleLabel?.font = UIFont.BoldFont(14)
        btnSignUp.layer.cornerRadius = 2
        
        lblCalender.font = UIFont.BoldFont(16)
        lblSignup.font = UIFont.BoldFont(16)
        lblCalender.textColor = UIColor.themeLight
        lblSignup.textColor = UIColor.themeLight
//        let image = UIImage(named: "ic_add")?.withRenderingMode(.alwaysTemplate)
//        addImg.image = image
//        addImg.tintColor = .white
        
//        lblTabTitle.textColor = UIColor.themePrimaryColor
//        lblTabTitle.font = UIFont.BoldFont(16)
//
//        selectedTabImg.image = selectedTabImg.image?.withRenderingMode(.alwaysTemplate)
//        selectedTabImg.tintColor = UIColor.themePrimaryColor
        calenderView.isHidden = true
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        ENTALDControllers.shared.ShowUserEngagementsVC(type: .ENTALDPUSH, from: self, callBack: nil)
        
//        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func showCalenderTapped(_ sender: Any) {
        
        calenderView.isHidden = false
        
        
        
        
//        if (calenderView.isHidden){
//            calenderView.isHidden = false
//        }else{
//            calenderView.isHidden = true
//        }
    }
    
    @IBAction func showEventsTapped(_ sender: Any) {
        calenderView.isHidden = true
    }
    
    
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        present(menu!, animated: true)
        
    }
    // Bottom bar Action
    
    
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
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        formatter.dateFormat = "yyyy-MM-dd"
        var startDate = formatter.date(from: "2000-01-01") ?? Date()
        return startDate
        
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        formatter.dateFormat = "yyyy-MM-dd"
        var endDate = formatter.date(from: "2060-01-01") ?? Date().addingTimeInterval((24*60*60)*40)
        return endDate
    }
    
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//
//        for i in (0..<(scheduleData?.count ?? 0)) {
//            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
//            if let event = formatter.date(from: scheduleData?[i].sjavms_start ?? ""){
//
//                let newFormatter = DateFormatter()
//                newFormatter.dateFormat = "yyyy-MM-dd"
//
//                var eventDate = newFormatter.string(from: event)
//                var calenderDate = newFormatter.string(from: date)
//
//
//                if eventDate == calenderDate {
//                    return 1
//                }
//            }
//
//        }
//        return 0
//    }
    
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return true
    }
    
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        var eventCount = 0;
        for i in (0..<(scheduleData?.count ?? 0)) {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            if let event = formatter.date(from: scheduleData?[i].sjavms_start ?? ""){
                
                let newFormatter = DateFormatter()
                newFormatter.dateFormat = "yyyy-MM-dd"
                
                var eventDate = newFormatter.string(from: event)
                var calenderDate = newFormatter.string(from: date)
                
                
                if eventDate == calenderDate {
                    eventCount += 1
                    
                }
            }
            

        }
        
        if  (eventCount > 0){
            return "\(eventCount) event(s)"
        }
        
        return ""
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        ENTALDControllers.shared.showCalenderHourVC(type: .ENTALDPUSH, from: self, selectedDate: date, dataObj: self.scheduleData, callBack: nil)
        
//        ENTALDControllers.shared.showAchivementScreen(type: .ENTALDPRESENT_POPOVER, from: self, dataObj: selectedEvent, engagementType: .Calender, callBack: {params,controller in
//            controller?.dismiss(animated: false)
//
//            if let model = params as? ScheduleModelThree {
//                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
//                    ENTALDControllers.shared.showVolunteerEventDetailScreen(type: .ENTALDPUSH, from: self, dataObj: model, eventType: "calender", callBack: nil)
//
//
//                })
//            }
//
//
//
//        })
    }
    
    
    // ============================ API ==========================//
    
    
    
//    
//    func getdata(){
//        
//        let params : [String:Any] = [
//            "id" : self.contactId
//        ]
//        
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
//        
//        ENTALDLibraryAPI.shared.requestScheduleData(params: params){ result in
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }
//            
//            switch result{
//            case .success(value: let response):
//                
//                if let scheduleGroup = response.engagements {
//                    self.scheduleData = scheduleGroup
//                    if (self.scheduleData?.count == 0 || self.scheduleData?.count == nil){
//                        self.showEmptyView(tableVw: self.tableView)
//                        
//                    }else{
//                        
//                        DispatchQueue.main.async {
//                            
//                            self.tableView.reloadData()
//                            self.calendar.reloadData()
//                            for subview in self.tableView.subviews {
//                                subview.removeFromSuperview()
//                            }
//                        }
//                    }
//                }else{
//                    self.showEmptyView(tableVw: self.tableView)
//                }
//                
//            case .error(let error, let errorResponse):
//                var message = error.message
//                if let err = errorResponse {
//                    message = err.error
//                }
//                self.showEmptyView(tableVw: self.tableView)
//                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
//                }
//            }
//        }
//    }
//    
    
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
                        self.showEmptyView(tableVw: self.tableView)
                    }else{
                        self.getScheduleInfoThree()
                        DispatchQueue.main.async {
                            for subview in self.tableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                }else{
                    self.showEmptyView(tableVw: self.tableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.tableView)
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
                    self.timefilter()
                    self.scheduleData = self.scheduleData?.sorted {
                        $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
                    }

                    if (self.scheduleData?.count == 0 || self.scheduleData?.count == nil){
                        self.showEmptyView(tableVw: self.tableView)
                        
                    }else{
                        
                        DispatchQueue.main.async {
                            
                            self.tableView.reloadData()
                            self.calendar.reloadData()
                            for subview in self.tableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                }else{
                    self.showEmptyView(tableVw: self.tableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.tableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    func timefilter(){
        var minusTime : [ScheduleModelThree]  = []
        var plusTime : [ScheduleModelThree] = []

        
        for i in (0 ..< (self.scheduleData?.count ?? 0) - 1){
            
            let eventDate = DateFormatManager.shared.getDateFromString(date: self.scheduleData?[i].sjavms_start) ?? Date()
            let currentDate = DateFormatManager.shared.getCurrentDate()
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.minute, .second], from: currentDate, to: eventDate)
            self.scheduleData?[i].time_difference = components.minute
            
            if ((self.scheduleData?[i].time_difference ?? 0) >= 0){

                if let data = self.scheduleData?[i] {
                    plusTime.append(data)
                }
               
            }else{
                    
                if let data = self.scheduleData?[i] {
                    minusTime.append(data)
                }
            }
        }
        
//        for i in (0 ..< (self.scheduleData?.count ?? 0)){
//
//            if ((self.scheduleData?[i].time_difference ?? 0) >= 0){
//
//                if let data = self.scheduleData?[i] {
//                    plusTime.append(data)
//                }
//
//            }else{
//
//                if let data = self.scheduleData?[i] {
//                    minusTime.append(data)
//                }
//
//            }
            
            
            plusTime = plusTime.sorted(by: { ($0.time_difference ?? 0) < ($1.time_difference ?? 0) })
//            minusTime = minusTime.sorted(by: { $0.time_difference ?? 0 < $1.time_difference ?? 0 })
            self.scheduleData = []
            self.scheduleData?.append(contentsOf: plusTime)
//            self.latestEventData?.append(contentsOf: minusTime)

        }
    }



// ============================  Tableview Delegates ===================================

extension ScheduleVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as! ScheduleCell
        let rowModel = scheduleData?[indexPath.row]
        cell.setContent(cellModel : rowModel)
        
        cell.btnView.tag = indexPath.row
        cell.btnView.addTarget(self, action: #selector(self.viewDetail(_:)), for: .touchUpInside)
        
        
        
//        if indexPath.row % 2 == 0{
//            cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
//        }else{
//            cell.backgroundColor = UIColor.viewLightColor
////            cell.seperatorView.backgroundColor = UIColor.gray
//        }
        
        return cell
    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let rowModel = scheduleData?[indexPath.row]
//
//        ENTALDControllers.shared.showVolunteerEventDetailScreen(type: .ENTALDPUSH, from: self, dataObj: rowModel, eventType : "schedule" )  { params, controller in
//            self.getScheduleInfo()
//        }
//    }
    
    @objc func viewDetail(_ sender:UIButton){
        let tag = sender.tag
        let rowModel = scheduleData?[tag]
        
        ENTALDControllers.shared.showVolunteerEventDetailScreen(type: .ENTALDPUSH, from: self, dataObj: rowModel, eventType : "schedule" )  { params, controller in
            self.getScheduleInfo()
        }
    }
    
    
    
    
}


