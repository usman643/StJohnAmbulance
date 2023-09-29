//
//  EventDetailVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 07/02/2023.
//

import UIKit

class EventDetailVC: ENTALDBaseViewController {
    
    let conId = UserDefaults.standard.contactIdToken ?? ""
    var relativeurlData : [ContactDocumentModel]?
    var access_token : String = ""
    var userRetrivalURL : String = ""
    var documents : [ContactDocumentResults]?
    var filterDocuments : [ContactDocumentResults]?
    var contactInfo : [ContactDataModel]?
    var eventId = ""
    var isCancelEvent = false
    var paramName = ""
    
    var isNameFilterApplied = false
    var isModifiedOnFilterApplied = false
    
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
    //    @IBOutlet weak var btnCancel: UIButton!
//    @IBOutlet weak var checkInbtnView: UIView!
//
//    @IBOutlet weak var tableHeaderView: UIView!
//    @IBOutlet weak var lblName: UILabel!
//    @IBOutlet weak var lblModifiedOn: UILabel!
//    @IBOutlet weak var lblAction: UILabel!
//    
//    @IBOutlet weak var contactbtnView: UIView!
    var availableEvent: AvailableEventModel?
    var scheduleEvent: ScheduleModelThree?
    var pastEvent: VolunteerEventsModel?
    var latestEvent : LatestEventDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        getDocumentToken()
        decorateUI()
        registerCell()
        
        LocationManager.defualt.startLocationUpdates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func registerCell(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ContactDocumentsTVC", bundle: nil), forCellReuseIdentifier: "ContactDocumentsTVC")
        self.tableView.register(UINib(nibName: "EventDetailTVC", bundle: nil), forCellReuseIdentifier: "EventDetailTVC")
        
        
    }
    
    func decorateUI(){
        lblEventName.font = UIFont.BoldFont(14)
        lblLocation.font = UIFont.BoldFont(12)
        lblDetail.font = UIFont.BoldFont(12)
        
        lblEventName.textColor = UIColor.themePrimaryWhite
        lblLocation.textColor = UIColor.themePrimaryWhite
        lblDetail.textColor = UIColor.themePrimaryWhite
        lblPrograme.textColor = UIColor.themePrimaryWhite
        lblDetailDesc.textColor = UIColor.textBlackColor
        
        lblDetailDesc.font = UIFont.RegularFont(12)
        lblDate.font = UIFont.RegularFont(11)
        lblShift.font = UIFont.RegularFont(11)
        lblPrograme.font = UIFont.RegularFont(11)
//        lblStatus.font = UIFont.RegularFont(14)
//        lblLocationDesc.font = UIFont.RegularFont(14)
        
        lblDate.textColor = UIColor.textBlackColor
        lblShift.textColor = UIColor.textBlackColor
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
        
//        btnCheckIn.titleLabel?.font = UIFont.BoldFont(14)
//        btnCheckIn.setTitleColor(UIColor.textWhiteColor, for: .normal)
//        btnCheckIn.layer.cornerRadius = 2
//        btnCheckIn.backgroundColor = UIColor.themeSecondry
        
//        btnCancel.titleLabel?.font = UIFont.BoldFont(14)
//        btnCancel.setTitleColor(UIColor.textWhiteColor, for: .normal)
//        btnCancel.layer.cornerRadius = 2
//        btnCancel.backgroundColor = UIColor.themeSecondry
//        
//        checkInBtnImg.image = checkInBtnImg.image?.withRenderingMode(.alwaysTemplate)
//        checkInBtnImg.tintColor = UIColor.white
//        
//        tableHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
//        tableHeaderView.layer.borderWidth = 1.5
//        
//        lblName.font = UIFont.BoldFont(13)
//        lblModifiedOn.font = UIFont.BoldFont(13)
//        lblAction.font = UIFont.BoldFont(13)
//        
//        lblName.textColor = UIColor.themePrimaryWhite
//        lblModifiedOn.textColor = UIColor.themePrimaryWhite
//        lblAction.textColor = UIColor.themePrimaryWhite
        
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
//            lblLocationDesc.text = availableEvent?.msnfp_location ?? "Not Found"
//            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: availableEvent?.msnfp_engagementopportunitystatus ?? 0) ?? "Not Found")"
            self.eventId = availableEvent?.msnfp_engagementopportunityid ?? ""
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
            
        }else if ((scheduleEvent) != nil){
            
            let date = DateFormatManager.shared.formatDateStrToStr(date: scheduleEvent?.sjavms_start ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: scheduleEvent?.sjavms_start ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: scheduleEvent?.sjavms_end ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblEventName.text = scheduleEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle?.uppercased() ?? "Not Found"
            lblDate.text = "\(date)"
            lblShift.text = "\(startTime) - \(endTime)"
//            lblLocationDesc.text = scheduleEvent?.sjavms_VolunteerEvent?.msnfp_location ?? "Not Found"
//            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: scheduleEvent?.msnfp_schedulestatus ?? 0) ?? "Not Found")"
            self.eventId = scheduleEvent?.msnfp_participationscheduleid ?? ""
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
            
            
            
            
        }else if ((pastEvent) != nil){
//            self.checkInbtnView.isHidden = true
//            self.contactbtnView.isHidden = true
            let date = DateFormatManager.shared.formatDateStrToStr(date: pastEvent?.sjavms_start ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: pastEvent?.sjavms_start ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: pastEvent?.sjavms_end ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblEventName.text = pastEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle?.uppercased() ?? "Not Found"
            lblDate.text = "Date: \(date)"
            lblShift.text = "Shift: \(startTime) - \(endTime)"
//            lblLocationDesc.text = pastEvent?.sjavms_VolunteerEvent?.msnfp_location ?? "Not Found"
//            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: pastEvent?.msnfp_schedulestatus ?? 0) ?? "Not Found")"
            self.eventId =  ""
            
            self.lblPrograme.text =  ""
            if (pastEvent?.msnfp_participationscheduleid == nil || pastEvent?.msnfp_participationscheduleid == ""){
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
            
            if(!DateFormatManager.shared.isDatePassed(date: self.pastEvent?.sjavms_start ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")) {
                self.isCancelEvent = true
//                self.btnCancel.isHidden = false
//                self.btnCancel.setTitle("Cancel", for: .normal)
            }else{
                self.isCancelEvent = false
//                self.btnCancel.isHidden = true
//                self.btnCancel.setTitle("Close", for: .normal)

            }
            
        }else if((latestEvent) != nil){
            
            let date = DateFormatManager.shared.formatDateStrToStr(date: latestEvent?.sjavms_start ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: latestEvent?.sjavms_start ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: latestEvent?.sjavms_end ?? "Not Found", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblEventName.text = latestEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle?.uppercased() ??  "Not Found"
            lblDate.text = "Date: \(date)"
            lblShift.text = "Shift: \(startTime) - \(endTime)"
//            lblLocationDesc.text = latestEvent?.sjavms_VolunteerEvent?.msnfp_location ?? "Not Found"
//            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: latestEvent?.msnfp_schedulestatus ?? 0) ?? "Not Found")"
            self.eventId = latestEvent?.msnfp_participationscheduleid ?? ""
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
        }
        
        if (self.eventId == ""){
//            self.checkInbtnView.isHidden = true
        }
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
            updateCheckInData()
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
    
    fileprivate func updateCheckInData(){
        let params = [
            "\(self.paramName)": true,
            "sjavms_checkedinlatitudevalue": LocationManager.defualt.getRecentLocation().lat,
            "sjavms_checkedinlongitudevalue" : LocationManager.defualt.getRecentLocation().lng
        ] as [String : Any]
        DispatchQueue.main.async {
            LoadingView.show()
        }

        ENTALDLibraryAPI.shared.updateVolunteerCheckIn(particitionId: self.eventId , params: params){ result in
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
    

}

extension EventDetailVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.filterDocuments?.count ?? 0
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactDocumentsTVC", for: indexPath) as! ContactDocumentsTVC
//        let rowModel = self.filterDocuments?[indexPath.row]
//        cell.setContent(cellModel: rowModel)
//        if indexPath.row % 2 == 0{
//            cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
//            cell.seperatorView.backgroundColor = UIColor.themePrimary
//        }else{
//            cell.mainView.backgroundColor = UIColor.viewLightColor
//            cell.seperatorView.backgroundColor = UIColor.gray
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventDetailTVC", for: indexPath) as! EventDetailTVC
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    }
    
}
    

