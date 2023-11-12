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
    var isLoadMoreShow : Bool = true
    
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnSidemenu: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnList: UIButton!
    @IBOutlet weak var btnCalender: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var listBottomView: UIView!
    @IBOutlet weak var calendarBottomView: UIView!
    @IBOutlet weak var lblSignup: UILabel!

    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var btnLoadMore: UIButton!
    @IBOutlet weak var loadMoreView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        decorateUI()
        getScheduleInfo()
        
        calendar = FSCalendar(frame: CGRect(x:0.0,y:0.0,width: UIScreen.main.bounds.size.width, height: self.calenderView.frame.size.height))
        calendar.scrollDirection = .vertical
        self.calenderView.addSubview(calendar)
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.appearance.headerTitleFont = UIFont.BoldFont(18)
        calendar.appearance.headerTitleColor = UIColor.themePrimaryWhite
        calendar.appearance.weekdayTextColor = UIColor.themePrimaryWhite
        calendar.appearance.weekdayTextColor = UIColor.themePrimaryWhite
        calendar.appearance.titleDefaultColor = UIColor.themePrimaryWhite
        calendar.appearance.weekdayTextColor = UIColor.themePrimaryWhite
        calendar.appearance.weekdayFont = UIFont.BoldFont(14)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false // or true
        
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
        
        lblTitle.textColor = UIColor.headerGreen
        lblTitle.font = UIFont.HeaderBoldFont(18)
        
        btnSignUp.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSignUp.titleLabel?.font = UIFont.BoldFont(14)
        btnSignUp.layer.cornerRadius = 2
        
//        lblCalender.font = UIFont.BoldFont(16)
        lblSignup.font = UIFont.BoldFont(13)
//        lblCalender.textColor = UIColor.themeLight
        lblSignup.textColor = UIColor.themeLight
        calenderView.isHidden = true
        listBottomView.isHidden = false
        calendarBottomView.isHidden = true
        headerView.addBottomShadow()
        
        btnLoadMore.layer.borderColor = UIColor.headerGreenWhite.cgColor
        btnLoadMore.layer.borderWidth = 1.0
        btnLoadMore.setTitle("Load More".localized, for: .normal)
        btnLoadMore.setTitleColor(UIColor.headerGreenWhite, for: .normal)
        btnLoadMore.titleLabel?.font = UIFont.MediumFont(16)
        loadMoreView.isHidden = true
        let originalImage = UIImage(named: "messages-bubble-square-text")!
        let tintedImage = ProcessUtils.shared.tintImage(originalImage)
        btnMessage.setImage(tintedImage, for: .normal)
        let  sideMenuImage = UIImage(named: "sideMenu")!
        btnSidemenu.setImage(ProcessUtils.shared.tintImage(sideMenuImage), for: .normal)
        
        btnList.setTitleColor(UIColor.textDarkGreenWhite, for: .normal)
        btnList.titleLabel?.font = UIFont.BoldFont(16)
        btnCalender.setTitleColor(UIColor.textDarkGreenWhite, for: .normal)
        btnCalender.titleLabel?.font = UIFont.BoldFont(16)
        
        
        
    }
    
    @IBAction func messageTapped(_ sender: Any) {
        ENTALDControllers.shared.showGroupMessageVC(type: .ENTALDPUSH, from: self, callBack: nil)
    }
    @IBAction func signUpTapped(_ sender: Any) {
        ENTALDControllers.shared.ShowUserEngagementsVC(type: .ENTALDPUSH, from: self, callBack: nil)
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        present(menu!, animated: true)
    }
    
    @IBAction func showCalenderTapped(_ sender: Any) {
        
        calenderView.isHidden = false
        listBottomView.isHidden = true
        calendarBottomView.isHidden = false
        
        self.loadMoreView.isHidden = true
        
        
        btnList.setTitleColor(UIColor.viewLightGrayColor, for: .normal)
        btnCalender.setTitleColor(UIColor.textDarkGreenWhite, for: .normal)
    }
    
    @IBAction func showEventsTapped(_ sender: Any) {
        calenderView.isHidden = true
        listBottomView.isHidden = false
        calendarBottomView.isHidden = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        btnList.setTitleColor(UIColor.textDarkGreenWhite, for: .normal)
        btnCalender.setTitleColor(UIColor.viewLightGrayColor, for: .normal)
    }
    
    @IBAction func loadMoreTapped(_ sender: Any) {
        isLoadMoreShow = false
        DispatchQueue.main.async {
            self.loadMoreView.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
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
        
    }
    
    
    // ============================ API ==========================//
    
    
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
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }
//
            switch result{
            case .success(value: let response):
                
                if let scheduleGroup = response.value {
                    self.scheduleEngagementData = scheduleGroup
                    if (self.scheduleEngagementData?.count == 0 || self.scheduleEngagementData?.count == nil){
                        self.showEmptyView(tableVw: self.tableView)
                        DispatchQueue.main.async {
                            LoadingView.hide()
                        }
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
                    LoadingView.hide()
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
                str = "sjavms_VolunteerEvent/msnfp_engagementopportunityid eq \(self.scheduleEngagementData?[i].msnfp_engagementopportunityid ?? "")"
            }else{
                str = "sjavms_VolunteerEvent/msnfp_engagementopportunityid eq \(self.scheduleEngagementData?[i].msnfp_engagementopportunityid ?? "") or "
            }
            
            propertyValues += str
            
        }
        
        guard let contactId = UserDefaults.standard.contactIdToken  else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "_sjavms_volunteerevent_value,msnfp_schedulestatus,sjavms_start,msnfp_participationscheduleid,sjavms_end,sjavms_checkedin",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=msnfp_engagementopportunitytitle,msnfp_location,_sjavms_program_value)",
            ParameterKeys.filter : "(_sjavms_volunteer_value eq \(contactId) and msnfp_schedulestatus eq 335940000 and (\(propertyValues))) ",
            ParameterKeys.orderby : "msnfp_name asc"
        ]
        
        self.getScheduleInfoThreeData(params: params)
        
    }
    
    fileprivate func getScheduleInfoThreeData(params : [String:Any]){
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
//
        ENTALDLibraryAPI.shared.requestScheduleThree(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let scheduleGroup = response.value {
                    self.scheduleData = scheduleGroup
//                    self.timefilter() // furture time filter
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
//        var minusTime : [ScheduleModelThree]  = []
        var plusTime : [ScheduleModelThree] = []
        
        if ((self.scheduleData?.count ?? 0) > 0){
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
                    
//                }else{
//                    
//                    if let data = self.scheduleData?[i] {
//                        minusTime.append(data)
//                    }
                }
            }
            
            if (plusTime.count > 0){
                plusTime = plusTime.sorted(by: { ($0.time_difference ?? 0) < ($1.time_difference ?? 0) })
                //            minusTime = minusTime.sorted(by: { $0.time_difference ?? 0 < $1.time_difference ?? 0 })
                self.scheduleData = []
                self.scheduleData?.append(contentsOf: plusTime)
            }else{
                self.scheduleData = []
            }
            //            self.latestEventData?.append(contentsOf: minusTime)
            
        }
        
    }
        
    }



// ============================  Tableview Delegates ===================================

extension ScheduleVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ((scheduleData?.count ?? 0) > 3 && isLoadMoreShow){
            loadMoreView.isHidden = false
            return 3
        }
            return scheduleData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as! ScheduleCell
        let rowModel = scheduleData?[indexPath.row]
        cell.setContent(cellModel : rowModel)
        
        cell.btnView.tag = indexPath.row
        cell.btnView.addTarget(self, action: #selector(self.viewDetail(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func viewDetail(_ sender:UIButton){
        let tag = sender.tag
        let rowModel = scheduleData?[tag]
        
        ENTALDControllers.shared.showVolunteerEventDetailScreen(type: .ENTALDPUSH, from: self, dataObj: rowModel, eventType : "schedule" )  { params, controller in
            self.getScheduleInfo()
        }
    }
    
    
    
    
}


