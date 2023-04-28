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
    
    var isNameFilterApplied = false
    var isModifiedOnFilterApplied = false
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var contactBtnImg: UIImageView!
    @IBOutlet weak var btnContact: UIButton!
    @IBOutlet weak var btnCheckIn: UIButton!
    @IBOutlet weak var checkInBtnImg: UIImageView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblShift: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblLocationDesc: UILabel!
    
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblDetailDesc: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var checkInbtnView: UIView!
    
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblModifiedOn: UILabel!
    @IBOutlet weak var lblAction: UILabel!
    
    @IBOutlet weak var contactbtnView: UIView!
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
    }
    
    func registerCell(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ContactDocumentsTVC", bundle: nil), forCellReuseIdentifier: "ContactDocumentsTVC")
        
    }
    
    func decorateUI(){
        lblEventName.font = UIFont.BoldFont(16)
        lblLocation.font = UIFont.BoldFont(16)
        lblDetail.font = UIFont.BoldFont(16)
        
        lblEventName.textColor = UIColor.themePrimaryWhite
        lblLocation.textColor = UIColor.themePrimaryWhite
        lblDetail.textColor = UIColor.themePrimaryWhite
        
        lblDate.font = UIFont.RegularFont(14)
        lblShift.font = UIFont.RegularFont(14)
        lblStatus.font = UIFont.RegularFont(14)
        lblLocationDesc.font = UIFont.RegularFont(14)
        
        lblDate.textColor = UIColor.textGrayColor
        lblShift.textColor = UIColor.textGrayColor
        lblStatus.textColor = UIColor.textGrayColor
        lblLocationDesc.textColor = UIColor.textGrayColor
        
        btnContact.titleLabel?.font = UIFont.BoldFont(14)
        btnContact.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnContact.layer.cornerRadius = 2
        btnContact.backgroundColor = UIColor.themeSecondry
        
        btnCheckIn.titleLabel?.font = UIFont.BoldFont(14)
        btnCheckIn.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnCheckIn.layer.cornerRadius = 2
        btnCheckIn.backgroundColor = UIColor.themeSecondry
        
        btnCancel.titleLabel?.font = UIFont.BoldFont(14)
        btnCancel.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnCancel.layer.cornerRadius = 2
        btnCancel.backgroundColor = UIColor.themeSecondry
        
        checkInBtnImg.image = checkInBtnImg.image?.withRenderingMode(.alwaysTemplate)
        checkInBtnImg.tintColor = UIColor.white
        if ( self.latestEvent?.sjavms_checkedin == true ){
            btnCheckIn.isEnabled = false
            btnCheckIn.setTitle("Checked In", for: .normal)
            checkInBtnImg.isHidden = true
            checkInBtnImg.isHidden = false
        }else{
            btnCheckIn.isEnabled = true
            btnCheckIn.setTitle("Check In", for: .normal)
            checkInBtnImg.isHidden = true
            checkInBtnImg.isHidden = false
            checkInBtnImg.tintColor = UIColor.white
        }
        tableHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        tableHeaderView.layer.borderWidth = 1.5
        
        lblName.font = UIFont.BoldFont(13)
        lblModifiedOn.font = UIFont.BoldFont(13)
        lblAction.font = UIFont.BoldFont(13)
        
        lblName.textColor = UIColor.themePrimaryWhite
        lblModifiedOn.textColor = UIColor.themePrimaryWhite
        lblAction.textColor = UIColor.themePrimaryWhite
        
    }
    
    func setupData(){
        if ((availableEvent) != nil){
            
            let date = DateFormatManager.shared.formatDateStrToStr(date: availableEvent?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: availableEvent?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: availableEvent?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblEventName.text = availableEvent?.msnfp_engagementopportunitytitle
            lblDate.text = "Date: \(date)"
            lblShift.text = "Shift: \(startTime) - \(endTime)"
            lblLocationDesc.text = availableEvent?.msnfp_location
            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: availableEvent?.msnfp_engagementopportunitystatus ?? 0) ?? "")"
            self.eventId = availableEvent?.msnfp_engagementopportunityid ?? ""
            
        }else if ((scheduleEvent) != nil){
            
            let date = DateFormatManager.shared.formatDateStrToStr(date: scheduleEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: scheduleEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: scheduleEvent?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblEventName.text = scheduleEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle
            lblDate.text = "Date: \(date)"
            lblShift.text = "Shift: \(startTime) - \(endTime)"
            lblLocationDesc.text = scheduleEvent?.sjavms_VolunteerEvent?.msnfp_location
            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: scheduleEvent?.msnfp_schedulestatus ?? 0) ?? "")"
            self.eventId = scheduleEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunityid ?? ""
            
            
            
            
            
            
        }else if ((pastEvent) != nil){
            self.checkInbtnView.isHidden = true
            self.contactbtnView.isHidden = true
            let date = DateFormatManager.shared.formatDateStrToStr(date: pastEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: pastEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: pastEvent?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblEventName.text = pastEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle
            lblDate.text = "Date: \(date)"
            lblShift.text = "Shift: \(startTime) - \(endTime)"
            lblLocationDesc.text = pastEvent?.sjavms_VolunteerEvent?.msnfp_location
            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: pastEvent?.msnfp_schedulestatus ?? 0) ?? "")"
            self.eventId = pastEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunityid ?? ""
        }else if((latestEvent) != nil){
            
            let date = DateFormatManager.shared.formatDateStrToStr(date: latestEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: latestEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: latestEvent?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblEventName.text = latestEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle
            lblDate.text = "Date: \(date)"
            lblShift.text = "Shift: \(startTime) - \(endTime)"
            lblLocationDesc.text = latestEvent?.sjavms_VolunteerEvent?.msnfp_location
            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: latestEvent?.msnfp_schedulestatus ?? 0) ?? "")"
            self.eventId = latestEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunityid ?? ""
        }
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
        //        self.navigationController?.popViewController(animated: true)
        //        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func checkInTapped(_ sender: Any) {
        if (self.latestEvent?.sjavms_checkedin == false){
            updateCheckInData()
        }
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
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func contactTapped(_ sender: Any) {
        self.getContact()
        //        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alter", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
    }
    
    fileprivate func updateCheckInData(){
        let params = [
            "sjavms_checkedin": true
        ]
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        
        
        ENTALDLibraryAPI.shared.updateVolunteerCheckIn(particitionId: self.latestEvent?.msnfp_participationscheduleid ?? "", params: params){ result in
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
                        var contactId = self.conId.replacingOccurrences(of: "-", with: "")
                        
                        self.userRetrivalURL = self.relativeurlData?.filter({
                            
                            var apiContactId = $0.relativeurl?.components(separatedBy: "_")
                            if (contactId.lowercased() == apiContactId?[1].lowercased()){
                                
                                return true
                            } else{
                                return false
                            }
                            
                        }).first?.relativeurl ?? ""
                        
                        self.getDocumentTwo()
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
        return self.filterDocuments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactDocumentsTVC", for: indexPath) as! ContactDocumentsTVC
        let rowModel = self.filterDocuments?[indexPath.row]
        cell.setContent(cellModel: rowModel)
        if indexPath.row % 2 == 0{
            cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
            cell.seperatorView.backgroundColor = UIColor.themePrimary
        }else{
            cell.mainView.backgroundColor = UIColor.viewLightColor
            cell.seperatorView.backgroundColor = UIColor.gray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowModel = self.filterDocuments?[indexPath.row]
        if let serverUrl = rowModel?.ServerRelativeUrl {
            let urlStr = "https://sjaasj.sharepoint.com/sites/VMSSandbox/_api/Web/GetFileByServerRelativePath(decodedurl='\(serverUrl)')/$value"
            if let url = URL(string: urlStr.replacingOccurrences(of: " ", with: "%20")) {
                
                ENTALDHttpClient.shared.downloadFile(using: url, access_token : self.access_token, file_Name:rowModel?.Name) { data, error in
                    if error == nil {
                        ENTALDAlertView.shared.showContactAlertWithTitle(title: "File Downloaded", message: "Go to Files app in your phone, press on browse tab and select On My iPhone. You will get SJA Impact folder with downloaded files.", actionTitle: .KOK, completion: { status in })
                    }
                }
            }
        }
    }
    
}
    

