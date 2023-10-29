//
//  EventDetailVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 07/02/2023.
//

import UIKit

class EventDetailVC: ENTALDBaseViewController , UITableViewDelegate, UITableViewDataSource,updateVolunteerCheckInDelegate{
    
    let conId = UserDefaults.standard.contactIdToken ?? ""
    var relativeurlData : [ContactDocumentModel]?
    var access_token : String = ""
    var userRetrivalURL : String = ""
    var documents : [ContactDocumentResults]?
    var filterDocuments : [ContactDocumentResults]?
    var contactInfo : [ContactDataModel]?
    var shiftsData : [VolunteerReportedShiftResponse]?
    var eventId = ""
    var eventOpprtunityId = ""
    var isCancelEvent = false
    var paramName = ""
    var isReadingLess = true
    
    var isNameFilterApplied = false
    var isModifiedOnFilterApplied = false
    
    
    var volunteerData : [VolunteerOfEventDataModel]?
    var dataVol : [String:Any] = [:]
        var volentierResultData : [String:Any] = [:]
        var filteredData : [String:Any] = [:]
        var programsData : [ProgramModel]?
        var eventProgramData : ProgramModel?
//        var contactInfo : [ContactDataModel]?
    
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var contactBtnImg: UIImageView!
    @IBOutlet weak var btnContact: UIButton!
//    @IBOutlet weak var btnCheckIn: UIButton!
//    @IBOutlet weak var checkInBtnImg: UIImageView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblShift: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
//    @IBOutlet weak var lblLocationDesc: UILabel!
//    
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblDetailDesc: UILabel!
//    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnReadmore: UIButton!
    
    @IBOutlet weak var lblPrograme: UILabel!
    @IBOutlet weak var detailDescStack: UIStackView!
    
    //    @IBOutlet weak var btnCancel: UIButton!
//    @IBOutlet weak var checkInbtnView: UIView!
//
//    @IBOutlet weak var tableHeaderView: UIView!
//    @IBOutlet weak var lblName: UILabel!
//    @IBOutlet weak var lblModifiedOn: UILabel!
//    @IBOutlet weak var lblAction: UILabel!
//    
//    @IBOutlet weak var contactbtnView: UIView!
    var availableEvent: CurrentEventsModel?
    var scheduleEvent: ScheduleModelThree?
    var pastEvent: CurrentEventsModel?
    var latestEvent : LatestEventDataModel?
    var dashbaordEvent : AvailableEventModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
//        getDocumentToken()
        decorateUI()
        registerCell()
        LocationManager.defualt.startLocationUpdates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
//        getReportedShifts()
        
    }
    
    func registerCell(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
//        self.tableView.register(UINib(nibName: "ContactDocumentsTVC", bundle: nil), forCellReuseIdentifier: "ContactDocumentsTVC")
        self.tableView.register(UINib(nibName: "EventDetailTVC", bundle: nil), forCellReuseIdentifier: "EventDetailTVC")
//        self.tableView.register(UINib(nibName: "EventManagerTVC", bundle: nil), forCellReuseIdentifier: "EventManagerTVC")
        tableView.register(UINib(nibName: "EventDetailHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "EventDetailHeaderView")
    }
    
    func decorateUI(){
        lblEventName.font = UIFont.HeaderBoldFont(16)
        lblLocation.font = UIFont.BoldFont(12)
        lblDetail.font = UIFont.BoldFont(12)
        
        lblEventName.textColor = UIColor.headerGreen
        lblLocation.textColor = UIColor.themeBlackText
        lblDetail.textColor = UIColor.headerGreen
        lblPrograme.textColor = UIColor.themeBlackText
        lblDetailDesc.textColor = UIColor.themeBlackText
        
        lblDetailDesc.font = UIFont.BoldFont(12)
        lblDate.font = UIFont.BoldFont(11)
        lblShift.font = UIFont.BoldFont(11)
        lblPrograme.font = UIFont.BoldFont(12)
//        lblStatus.font = UIFont.BoldFont(14)
//        lblLocationDesc.font = UIFont.BoldFont(14)
        
        lblDate.textColor = UIColor.themeBlackText
        lblShift.textColor = UIColor.themeBlackText
//        lblStatus.textColor = UIColor.textGrayColor
//        lblLocationDesc.textColor = UIColor.textGrayColor
        
        btnContact.titleLabel?.font = UIFont.BoldFont(12)
        btnContact.setTitleColor(UIColor.themeColorSecondry, for: .normal)
        btnContact.layer.cornerRadius = 2
//        btnContact.backgroundColor = UIColor.themeSecondry
        
        detailView.layer.cornerRadius = 8
        detailView.layer.borderWidth = 0.5
        detailView.layer.borderColor = UIColor.systemGray3.cgColor
        detailView.layer.shadowColor = UIColor.systemGray4.cgColor
        detailView.layer.shadowOpacity = 0.5
        detailView.layer.shadowOffset = .zero
        detailView.layer.shadowRadius = 6
        
        infoView.layer.cornerRadius = 8
        infoView.layer.borderWidth = 0.5
        infoView.layer.borderColor = UIColor.systemGray3.cgColor
        infoView.layer.shadowColor = UIColor.systemGray4.cgColor
        infoView.layer.shadowOpacity = 0.5
        infoView.layer.shadowOffset = .zero
        infoView.layer.shadowRadius = 6

    }
    
    func setupData(){
        self.lblDetailDesc.text = "Short Description text will appear Here"
        if ((availableEvent) != nil){
            
            let date = DateFormatManager.shared.formatDateStrToStr(date: availableEvent?.msnfp_startingdate ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: availableEvent?.msnfp_startingdate ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: availableEvent?.msnfp_endingdate ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblEventName.text = availableEvent?.msnfp_engagementopportunitytitle?.uppercased() ?? "Not Found"
            lblDate.text = "\(date)"
            lblShift.text = "\(startTime) - \(endTime)"
            lblLocation.text = availableEvent?.msnfp_location ?? "..."
//            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: availableEvent?.msnfp_engagementopportunitystatus ?? 0) ?? "Not Found")"
            self.eventId = availableEvent?.msnfp_engagementopportunityid ?? ""
            self.eventOpprtunityId = availableEvent?.msnfp_engagementopportunityid ?? ""
            self.lblPrograme.text = availableEvent?.sjavms_program_value ?? ""

//                self.checkInbtnView.isHidden = true
            
            
            self.paramName = "sjavms_checkedin"
            
            if ( self.availableEvent?.sjavms_checkedin == true ){
//                btnCheckIn.isEnabled = false
//                btnCheckIn.setTitle("Checked In", for: .normal)
//                checkInBtnImg.tintColor = UIColor.white
//                checkInBtnImg.isHidden = false
//                
            }else if (self.availableEvent?.sjavms_checkedin == false ){
//                btnCheckIn.isEnabled = true
//                btnCheckIn.setTitle("Check In", for: .normal)
//                checkInBtnImg.isHidden = true
//            }else{
//                contactbtnView.isHidden = true
            }
            
            if(!DateFormatManager.shared.isDatePassed(date: self.availableEvent?.msnfp_startingdate ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")) {
//                self.isCancelEvent = true
//                self.btnCancel.isHidden = false
//                self.btnCancel.setTitle("Cancel", for: .normal)
            }else{
//                self.isCancelEvent = false
//                self.btnCancel.isHidden = true
//                self.btnCancel.setTitle("Close", for: .normal)

            }
            self.lblDetail.text = self.availableEvent?.msnfp_description ?? ""
            self.lblDetailDesc.text = self.availableEvent?.msnfp_shortdescription ?? ""
            
        }else if ((scheduleEvent) != nil){
            
            let date = DateFormatManager.shared.formatDateStrToStr(date: scheduleEvent?.sjavms_start ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: scheduleEvent?.sjavms_start ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: scheduleEvent?.sjavms_end ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblEventName.text = scheduleEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle?.uppercased() ?? "Not Found"
            lblDate.text = "\(date)"
            lblShift.text = "\(startTime) - \(endTime)"
            lblLocation.text = scheduleEvent?.sjavms_VolunteerEvent?.msnfp_location ?? "Not Found"
//            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: scheduleEvent?.msnfp_schedulestatus ?? 0) ?? "Not Found")"
            self.eventId = scheduleEvent?.msnfp_participationscheduleid ?? ""
            self.eventOpprtunityId = scheduleEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunityid ?? ""
            self.lblPrograme.text = scheduleEvent?.sjavms_volunteerevent_value ?? ""
            if (scheduleEvent?.msnfp_participationscheduleid == nil || scheduleEvent?.msnfp_participationscheduleid == ""){
//                self.checkInbtnView.isHidden = true
            }
            self.paramName = "sjavms_checkedin"
            
            if ( self.scheduleEvent?.sjavms_checkedin == true ){
//                btnCheckIn.isEnabled = false
//                btnCheckIn.setTitle("Checked In", for: .normal)
//                checkInBtnImg.tintColor = UIColor.white
//                checkInBtnImg.isHidden = false
//                
            }else if ( self.scheduleEvent?.sjavms_checkedin == false ){
//                btnCheckIn.isEnabled = true
//                btnCheckIn.setTitle("Check In", for: .normal)
//                checkInBtnImg.isHidden = true
            }else{
//                contactbtnView.isHidden = true
            }
            
            if(!DateFormatManager.shared.isDatePassed(date: self.scheduleEvent?.sjavms_start ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")) {
                self.isCancelEvent = true
//                self.btnCancel.isHidden = false
//                self.btnCancel.setTitle("Cancel", for: .normal)
            }else{
                self.isCancelEvent = false
//                self.btnCancel.isHidden = true
//                self.btnCancel.setTitle("Close", for: .normal)

            }
            self.lblDetail.text = self.scheduleEvent?.msnfp_description ?? "Detail"
            self.lblDetailDesc.text = self.scheduleEvent?.msnfp_shortdescription ?? "..."
            
            
            
        }else if ((pastEvent) != nil){
//            self.checkInbtnView.isHidden = true
//            self.contactbtnView.isHidden = true
            let date = DateFormatManager.shared.formatDateStrToStr(date: pastEvent?.msnfp_startingdate ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: pastEvent?.msnfp_startingdate ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: pastEvent?.msnfp_endingdate ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblEventName.text = pastEvent?.msnfp_engagementopportunitytitle?.uppercased() ?? "Not Found"
            lblDate.text = "Date: \(date)"
            lblShift.text = "Shift: \(startTime) - \(endTime)"
            lblLocation.text = pastEvent?.msnfp_location ?? "Not Found"
//            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: pastEvent?.msnfp_schedulestatus ?? 0) ?? "Not Found")"
            self.eventId =  ""
            self.eventOpprtunityId =  pastEvent?.msnfp_engagementopportunityid ?? ""
            
            self.lblPrograme.text =  ""
            if (pastEvent?.msnfp_engagementopportunityid == nil || pastEvent?.msnfp_engagementopportunityid == ""){
//                self.checkInbtnView.isHidden = true
            }
            
            self.paramName = "sjavms_checkedin"
            
            if ( self.pastEvent?.sjavms_checkedin == true ){
//                btnCheckIn.isEnabled = false
//                btnCheckIn.setTitle("Checked In", for: .normal)
//                checkInBtnImg.tintColor = UIColor.white
//                checkInBtnImg.isHidden = false
                
            }else if (self.pastEvent?.sjavms_checkedin == false ){
//                btnCheckIn.isEnabled = true
//                btnCheckIn.setTitle("Check In", for: .normal)
//                checkInBtnImg.isHidden = true
            }else{
//                contactbtnView.isHidden = true
            }
            
            if(!DateFormatManager.shared.isDatePassed(date: self.pastEvent?.msnfp_startingdate ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")) {
                self.isCancelEvent = true
//                self.btnCancel.isHidden = false
//                self.btnCancel.setTitle("Cancel", for: .normal)
            }else{
                self.isCancelEvent = false
//                self.btnCancel.isHidden = true
//                self.btnCancel.setTitle("Close", for: .normal)

            }
            self.lblDetail.text = self.pastEvent?.msnfp_description ?? "Detail"
            self.lblDetailDesc.text = self.pastEvent?.msnfp_shortdescription ?? "..."
            
        }else if((latestEvent) != nil){
            
            let date = DateFormatManager.shared.formatDateStrToStr(date: latestEvent?.sjavms_start ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: latestEvent?.sjavms_start ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: latestEvent?.sjavms_end ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblEventName.text = latestEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle?.uppercased() ??  "Not Found"
            lblDate.text = "Date: \(date)"
            lblShift.text = "Shift: \(startTime) - \(endTime)"
            lblLocation.text = latestEvent?.sjavms_VolunteerEvent?.msnfp_location ?? "Not Found"
//            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: latestEvent?.msnfp_schedulestatus ?? 0) ?? "Not Found")"
            self.eventId = latestEvent?.msnfp_participationscheduleid ?? ""
            self.eventOpprtunityId = latestEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunityid ?? ""
            
            
//            self.checkInbtnView.isHidden = false
            self.paramName = "sjavms_checkedin"
            self.lblPrograme.text = ""
            if ( self.latestEvent?.sjavms_checkedin == true ){
//                btnCheckIn.isEnabled = false
//                btnCheckIn.setTitle("Checked In", for: .normal)
//                checkInBtnImg.tintColor = UIColor.white
//                checkInBtnImg.isHidden = false
                
//            }else if (self.latestEvent?.sjavms_checkedin == false ){
//                btnCheckIn.isEnabled = true
//                btnCheckIn.setTitle("Check In", for: .normal)
//                checkInBtnImg.isHidden = true
//            }else{
//                contactbtnView.isHidden = true
            }
            
            if(!DateFormatManager.shared.isDatePassed(date: self.latestEvent?.sjavms_start ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")) {
                self.isCancelEvent = true
//                self.btnCancel.isHidden = false
//                self.btnCancel.setTitle("Cancel", for: .normal)
            }else{
                self.isCancelEvent = false
//                self.btnCancel.isHidden = true
//                self.btnCancel.setTitle("Close", for: .normal)

            }
            self.lblDetail.text = self.latestEvent?.msnfp_description ?? "Detail"
            self.lblDetailDesc.text = self.latestEvent?.msnfp_shortdescription ?? "..."
            
        }else if((dashbaordEvent) != nil){
            
            let date = DateFormatManager.shared.formatDateStrToStr(date: dashbaordEvent?.msnfp_startingdate ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: dashbaordEvent?.msnfp_endingdate ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: dashbaordEvent?.msnfp_endingdate ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblEventName.text = dashbaordEvent?.msnfp_engagementopportunitytitle?.uppercased() ??  "Not Found"
            lblDate.text = "Date: \(date)"
            lblShift.text = "Shift: \(startTime) - \(endTime)"
            lblLocation.text = dashbaordEvent?.msnfp_location ?? "Not Found"
            //            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: latestEvent?.msnfp_schedulestatus ?? 0) ?? "Not Found")"
            self.eventId = dashbaordEvent?.msnfp_engagementopportunityid ?? ""
            self.eventOpprtunityId = dashbaordEvent?.msnfp_engagementopportunityid ?? ""
            
            
            //            self.checkInbtnView.isHidden = false
            self.paramName = "sjavms_checkedin"
            self.lblPrograme.text = ""
            if ( self.dashbaordEvent?.sjavms_checkin == true ){
                //                btnCheckIn.isEnabled = false
                //                btnCheckIn.setTitle("Checked In", for: .normal)
                //                checkInBtnImg.tintColor = UIColor.white
                //                checkInBtnImg.isHidden = false
                
                //            }else if (self.latestEvent?.sjavms_checkedin == false ){
                //                btnCheckIn.isEnabled = true
                //                btnCheckIn.setTitle("Check In", for: .normal)
                //                checkInBtnImg.isHidden = true
                //            }else{
                //                contactbtnView.isHidden = true
            }
            
            if(!DateFormatManager.shared.isDatePassed(date: self.dashbaordEvent?.msnfp_startingdate ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")) {
                self.isCancelEvent = true
                //                self.btnCancel.isHidden = false
                //                self.btnCancel.setTitle("Cancel", for: .normal)
            }else{
                self.isCancelEvent = false
                //                self.btnCancel.isHidden = true
                //                self.btnCancel.setTitle("Close", for: .normal)
            }
            
            self.lblDetail.text = self.dashbaordEvent?.msnfp_description ?? "Detail"
            self.lblDetailDesc.text = self.dashbaordEvent?.msnfp_shortdescription ?? "..."
        }
        if (self.eventId == ""){
//            self.checkInbtnView.isHidden = true
        }
        self.lblDetailDesc.numberOfLines = 3

//            if (self.dashbaordEvent?.msnfp_shortdescription?.count ?? 0 >= 110)
            if (self.lblDetailDesc.maxNumberOfLines <= 3)
            {
                self.btnReadmore.isHidden = true
                
            }else{
                
                self.btnReadmore.isHidden = false
            }
            
        
        
        getVolunteers()
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        LocationManager.defualt.stopLocationUpdates()
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
        //        self.navigationController?.popViewController(animated: true)
        //        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func checkInTapped(_ sender: Any) {
//        if (self.latestEvent?.sjavms_checkedin == false){
//
//        }
//        if btnCheckIn.isEnabled{
//            updateCheckInData()
//        }
        //            ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alter", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
        
        
        
    }
    
    @IBAction func nameFilterTapped(_ sender: Any) {
        
        if !isNameFilterApplied{
            self.filterDocuments = self.filterDocuments?.sorted {
                $0.Name ?? "" < $1.Name ?? ""
            }
            isNameFilterApplied = true
        }else{
            self.filterDocuments = self.filterDocuments?.sorted {
                $0.Name ?? "" > $1.Name ?? ""
            }
            isNameFilterApplied = false
        }
        
        isModifiedOnFilterApplied = false

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    @IBAction func readmoreTapped(_ sender: Any) {
        
        if (isReadingLess){
            self.lblDetailDesc.numberOfLines = 0
            self.btnReadmore.setTitle("Read Less", for: .normal)
            isReadingLess = false
        }else{
            self.btnReadmore.setTitle("Read More", for: .normal)
            self.lblDetailDesc.numberOfLines = 3
            isReadingLess = true
        }
        
        
        
    }
    
    @IBAction func modifiedDateFilterTapped(_ sender: Any) {
        
        if !isModifiedOnFilterApplied{
            self.filterDocuments = self.filterDocuments?.sorted {
                $0.TimeLastModified ?? "" < $1.TimeLastModified ?? ""
            }
            isModifiedOnFilterApplied = true
        }else{
            self.filterDocuments = self.filterDocuments?.sorted {
                $0.TimeLastModified ?? "" > $1.TimeLastModified ?? ""
            }
            isModifiedOnFilterApplied = false
        }
        
        isNameFilterApplied = false

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    
    @IBAction func messageTapped(_ sender: Any) {
        
        ENTALDControllers.shared.showGroupMessageVC(type: .ENTALDPUSH, from: self, callBack: nil)
    }
    
    
    @IBAction func cancelTapped(_ sender: Any) {
        
//        if (isCancelEvent == true){
            self.cancelEvent()
//        }else{
//            self.navigationController?.popViewController(animated: true)
//        }
        
    }
    
    @IBAction func contactTapped(_ sender: Any) {
        self.getContact()
    }
    
    @objc func updateCheckInData(_ sender: Any){
        let params = [
            "\(self.paramName)": true,
            "sjavms_checkedinlatitudevalue": LocationManager.defualt.getRecentLocation().lat,
            "sjavms_checkedinlongitudevalue" : LocationManager.defualt.getRecentLocation().lng
        ] as [String : Any]
        DispatchQueue.main.async {
            LoadingView.show()
        }
        guard let index = (sender as AnyObject).tag else { return  }
        let participationId = self.shiftsData?[index]._sjavms_volunteer_value ?? ""
        ENTALDLibraryAPI.shared.updateVolunteerCheckIn(particitionId: participationId , params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                if response.value != nil {
//                    self.btnCheckIn.setTitle("Checked In", for: .normal)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                //                self.showEmptyView(tableVw: self.tableView)
                DispatchQueue.main.async {
                                        ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in
                                            
//                                            self.btnCheckIn.setTitle("Checked In", for: .normal)
                                        })
                }
            }
        }
    }
    
    func getContact(){
        
        
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle",
            ParameterKeys.expand : "sjavms_Contact($select=emailaddress1,address1_country,address1_line1,address1_line3,address1_city,lastname,firstname,fullname,address1_postalcode,telephone1,address1_stateorprovince,address1_line2)",
            ParameterKeys.filter : "(msnfp_engagementopportunityid eq \(self.eventId)) and (sjavms_Contact/contactid ne null)"
        ]
        
        self.getContactData(params: params)
        
    }
    
    fileprivate func getContactData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestContactInfo(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let contactData = response.value {
                    self.contactInfo = contactData
                    var messageStr = ""
                    if let str = self.contactInfo?[0].sjavms_Contact?.fullname{
                        messageStr += "Name: \(str)\n"
                    }
                    if let str = self.contactInfo?[0].sjavms_Contact?.telephone1{
                        messageStr += "Phone: \(str)\n"
                    }
                    if let str = self.contactInfo?[0].sjavms_Contact?.emailaddress1{
                        messageStr += "Email: \(str)\n"
                    }
                    
                    DispatchQueue.main.async {
                        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Organizer Contact Infomation", message: messageStr, actionTitle: .KOK, completion: {status in })
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
    
    
    fileprivate func getDocumentToken(){
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        let params : DynamicAuthRequest = DynamicAuthRequest(grant_type: "client_credentials", client_id: "69168eb4-986f-4198-92f5-7b3c796044ad@4eb3d202-86fa-4a81-b4de-47e3389ef4d0", resource: "00000003-0000-0ff1-ce00-000000000000/sjaasj.sharepoint.com@4eb3d202-86fa-4a81-b4de-47e3389ef4d0", client_secret: "/pbmvpnf9I2QefYYTbpBqPY7l8P1TleNGyUc7Tc8/g0=")
        
        ENTALDLibraryAPI.shared.getDocumentToken(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(let response):
                if let sessionToken = response.access_token {
                    self.access_token = sessionToken
                    self.getDocument()
                }
                break
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
    
    
    

    
    
    fileprivate func getDocument(){
        let params : [String:Any] = [
            ParameterKeys.select : "relativeurl",
            ParameterKeys.filter : "(_regardingobjectid_value eq \(self.eventId))"
        ]
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getContactDocument(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let apiData = response.value {
                    self.relativeurlData = apiData
                    if ((self.relativeurlData?.count ?? 0 ) > 0){
                        
                        self.relativeurlData = apiData
                        let contactId = self.conId.replacingOccurrences(of: "-", with: "")
                        
                        self.userRetrivalURL = self.relativeurlData?.filter({
                            
                            let apiContactId = $0.relativeurl?.components(separatedBy: "_")
                            if (contactId.lowercased() == apiContactId?[1].lowercased()){
                                
                                return true
                            } else{
                                return false
                            }
                            
                        }).first?.relativeurl ?? ""
                        
                        self.getDocumentTwo()
                    }else{
                        self.showEmptyView(tableVw: self.tableView)
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
    
    
    
    
    fileprivate func getDocumentTwo(){

        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getContactDocumentstwoEvent(participationId: self.userRetrivalURL, externalToken: self.access_token){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let apiData = response.d {
                    self.documents = apiData.results
                    self.filterDocuments = apiData.results
                    if (self.documents?.count == 0 || self.documents?.count == nil){
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
    
    
    func cancelEvent(){
    
        ENTALDAlertView.shared.showActionAlertWithTitle(title: "Alert", message: "Are you sure you want to Cancel Event", actionTitle: .KOK, completion: { status in
            
            if status == true{
                let params = [
                    "msnfp_schedulestatus": 844060003 as Int
                ]
                
                self.closeVolunteersData(params: params)
            }else{
                
            }
            
        })
    }
    
    fileprivate func closeVolunteersData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
 
        ENTALDLibraryAPI.shared.requestCloseEvent(eventId:self.eventId, params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                if let pastEvent = response.error {
                    DispatchQueue.main.async {
                        
                        ENTALDAlertView.shared.showContactAlertWithTitle(title: "", message: pastEvent.message, actionTitle: .KOK, completion: {status in
                            
                            self.callbackToController?("", self)
                            self.navigationController?.popViewController(animated: true)
                        })
                    }
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
//                self.showEmptyView(tableVw: self.tableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
    
    
    ///////////////////============================
    ///
    ///
    func getVolunteers(){
        
        let eventId = eventOpprtunityId
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_schedulestatus,sjavms_start,sjavms_hours,_sjavms_volunteerevent_value,_sjavms_volunteer_value,msnfp_participationscheduleid,sjavms_start,sjavms_end,sjavms_checkedin,sjavms_checkedinlatitude,sjavms_checkedinlongitude",
            
            ParameterKeys.expand : "sjavms_Volunteer($select=fullname,entityimage,fullname,lastname,telephone1,emailaddress1,address1_stateorprovince,address1_postalcode,address1_country,address1_city,address1_country,address1_line1,address1_line3,address1_line2,sjavms_gender,sjavms_preferredpronouns)",
            ParameterKeys.filter : "(_sjavms_volunteerevent_value eq \(eventId))",
            ParameterKeys.orderby : "_sjavms_volunteer_value asc,_sjavms_volunteerevent_value asc"
            
        ]
        
        self.getVolunteersData(params: params)
        
    }
    
    
    fileprivate func getVolunteersData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteersOfEvent(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let pastEvent = response.value {
                    self.volunteerData = pastEvent
                    self.volunteerData =  self.volunteerData?.filter({ $0.sjavms_Volunteer?.contactid  == UserDefaults.standard.userInfo?.contactid})
                        
                        
                    self.volunteerData = self.volunteerData?.sorted(by: { ($0.sjavms_start ?? "") < ($1.sjavms_start ?? "") })
                    
                    
                    
                    if (self.volunteerData?.count == 0 || self.volunteerData?.count == nil){
                        self.showEmptyView(tableVw: self.tableView)
                    }else{
                        self.volunteerData = self.volunteerData?.sorted {
                            $0.sjavms_start ?? "" > $1.sjavms_start ?? ""
                        }
                        
                        self.dataVol = self.getEntryTypesByGroup(volunteers: self.volunteerData) ?? [:]
                        self.volentierResultData = self.getEntryTypesByGroup(volunteers:self.volunteerData) ?? [:]
                        
                        
                        DispatchQueue.main.async {
                            for subview in self.tableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
//                        self.setMapData()
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

//}

//extension EventDetailVC : UITableViewDelegate, UITableViewDataSource,updateVolunteerCheckInDelegate{
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return self.filterDocuments?.count ?? 0
//        return shiftsData?.count ?? 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "EventDetailTVC", for: indexPath) as! EventDetailTVC
//
//        let rowModel = self.shiftsData?[indexPath.row]
//        let startTime = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
//        let endTime = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
//        cell.lblTime.text = "\(startTime) - \(endTime)"
//        
//        if ((rowModel?.sjavms_checkedin ?? 0) == 1){
//            cell.switchChange.isOn = true
//        }else{
//            cell.switchChange.isOn = false
//        }
//        cell.lblShift.text = "shift"
//        cell.switchChange.tag = indexPath.row
//        cell.switchChange.addTarget(self, action: #selector (updateCheckInData), for: .valueChanged)
////        cell.switchChange.addTarget(self, action:  #selector(updateCheckInData(eventValue: self.shiftsData?[indexPath.row]._sjavms_volunteer_value)), for:.valueChanged )
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let rowModel = self.filterDocuments?[indexPath.row]
//        if let serverUrl = rowModel?.ServerRelativeUrl {
//            let urlStr = "https://sjaasj.sharepoint.com/sites/VMSSandbox/_api/Web/GetFileByServerRelativePath(decodedurl='\(serverUrl)')/$value"
//            if let url = URL(string: urlStr.replacingOccurrences(of: " ", with: "%20")) {
//                
//                ENTALDHttpClient.shared.downloadFile(using: url, access_token : self.access_token, file_Name:rowModel?.Name) { data, error in
//                    if error == nil {
//                        ENTALDAlertView.shared.showContactAlertWithTitle(title: "File Downloaded", message: "Go to Files app in your phone, press on browse tab and select On My iPhone. You will get SJA Impact folder with downloaded files.", actionTitle: .KOK, completion: { status in })
//                    }
//                }
//            }
//        }
        
        
        
        
//        _sjavms_volunteer_value
//    }
    
    func updateVolunteerCheckIn(participationId:String , param : [String:Bool]){
        
        self.updateCheckInData(participationId: participationId, params: param)
        
    }
    
    fileprivate func updateCheckInData(participationId: String, params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        
        
        ENTALDLibraryAPI.shared.updateVolunteerCheckIn(particitionId: participationId, params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                if let pastEvent = response.value {

                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
//                self.showEmptyView(tableVw: self.tableView)
                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    
    func getReportedShifts(){
        
        
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "sjavms_checkedin,createdon,_msnfp_engagementopportunityscheduleid_value,msnfp_name,_msnfp_participationid_value,msnfp_participationscheduleid,msnfp_schedulestatus,sja_additionalnotes,_sjavms_adhochoursid_value,sjavms_end,_sjavms_group_value,sjavms_hours,sjavms_start,_sjavms_volunteer_value,_sjavms_volunteerevent_value,statecode",
            ParameterKeys.filter : "(_sjavms_volunteerevent_value eq \(self.eventOpprtunityId) and statecode eq 0)"
//            ParameterKeys.filter : "(_sjavms_volunteerevent_value eq \(self.eventOpprtunityId) and statecode eq 0)"
            
        ]
        
        self.getReportedShiftsData(params: params)
        
    }
    
    fileprivate func getReportedShiftsData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getReportedShiftsData(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let shiftsData = response.value {
                    self.shiftsData = shiftsData
                    if (self.shiftsData?.count == 0 || self.shiftsData?.count == nil){
                        DispatchQueue.main.async {
                            self.tableView.isHidden = true
                        }
                    }else{
                      
                        DispatchQueue.main.async {
                            self.tableView.isHidden = false
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

                }else{
                    DispatchQueue.main.async {
                        self.tableView.isHidden = false
                    }
                }
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                
                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
//    }
    
    
    
    
    
    //=======================================================================================
    
    
    
    
   
    
    func getEntryTypesByGroup(volunteers:[VolunteerOfEventDataModel]?)->[String:Any]?{
        if let entryTypes = volunteers {
            let dictionary = Dictionary(grouping: entryTypes, by:  { DateFormatManager.shared.formatDateStrToStr(date: $0.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy") })
            return dictionary
        }
        return nil
    }
    
    
    func getProgramName(_ programId:String)->ProgramModel?{
        let programModel = self.programsData?.filter({$0.sjavms_programid == programId}).first
        return programModel
    }
    
}

func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "EventDetailHeaderView") as! EventDetailHeaderView
    
    let key = Array(self.dataVol.keys)[section]
    if let rowModel : [VolunteerOfEventDataModel] = self.dataVol[key] as? [VolunteerOfEventDataModel]{
        
        let startTime = DateFormatManager.shared.formatDateStrToStr(date: rowModel.first?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
        
        let endTime = DateFormatManager.shared.formatDateStrToStr(date: rowModel.first?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
        
        headerView.lblTime.text = "\(startTime) - \(endTime)"
    }
    headerView.lblShift.text = "\(section + 1) Shift"
//    headerView.lblDate.text = key
    
    return headerView
}

func numberOfSections(in tableView: UITableView) -> Int {
    return self.numberOfSection()
}


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.numberOfRows(section: section)
    
}


func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EventDetailTVC", for: indexPath) as! EventDetailTVC
    
    
    
    let key = Array(self.dataVol.keys)[indexPath.section]
    if let rowModel : [VolunteerOfEventDataModel] = self.dataVol[key] as? [VolunteerOfEventDataModel]{
//        cell.volunteerImg.image = ProcessUtils.shared.convertBase64StringToImage(imageBase64String: rowModel[indexPath.row].sjavms_Volunteer?.entityimage ?? "") ?? UIImage(named: "ic_profile")
        cell.cellModel = rowModel[indexPath.row]
//        cell.lblTitle.text = rowModel[indexPath.row].sjavms_Volunteer?.fullname ?? ""
        if ( rowModel[indexPath.row].sjavms_checkedin == true){
            cell.btnCheckIn.isOn = true
            cell.lblTitle.text = "Checked In"
        }else{
            cell.btnCheckIn.isOn = false
            cell.lblTitle.text = "Checked In"
        }
       
        
        let eventDate = DateFormatManager.shared.getDateFromString(date: rowModel[indexPath.row].sjavms_start) ?? Date()
        let currentDate = DateFormatManager.shared.getCurrentDate()
        let calendar = Calendar.current

        let components = calendar.dateComponents([.minute, .second], from: currentDate, to: eventDate)
        if ((components.minute ?? 31) <= 30 && (components.minute ?? 31) >= -30){
//                    cell.btnCheckIn.isEnabled = true
            cell.btnCheckIn.isUserInteractionEnabled = true
        }else{
//                    cell.btnCheckIn.isEnabled = false
            cell.btnCheckIn.isUserInteractionEnabled = false
        }
        cell.delegate = self
    }
    return cell
}

func numberOfSection() -> Int {
    return self.dataVol.count
}

func numberOfRows(section : Int) -> Int {
    let key = Array(self.dataVol.keys)[section]
    if let rowModel : [VolunteerOfEventDataModel] = self.dataVol[key] as? [VolunteerOfEventDataModel]{
        return rowModel.count
    }
    return 0
}

func getSearchData(keyword:String)->[String:Any]{
    
    let result = self.volunteerData?.filter({
        if let name = $0.sjavms_Volunteer?.fullname?.lowercased(), name.contains(keyword.lowercased()) {return true}
        return false
    })
    
    return self.getEntryTypesByGroup(volunteers: result) ?? [:]
}
    
    
    func getEntryTypesByGroup(volunteers:[VolunteerOfEventDataModel]?)->[String:Any]?{
        if let entryTypes = volunteers {
            let dictionary = Dictionary(grouping: entryTypes, by:  { DateFormatManager.shared.formatDateStrToStr(date: $0.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy") })
            return dictionary
        }
        return nil
    }
    
    
    func getProgramName(_ programId:String)->ProgramModel?{
        let programModel = self.programsData?.filter({$0.sjavms_programid == programId}).first
        return programModel
    }
    

    
    
}
    


