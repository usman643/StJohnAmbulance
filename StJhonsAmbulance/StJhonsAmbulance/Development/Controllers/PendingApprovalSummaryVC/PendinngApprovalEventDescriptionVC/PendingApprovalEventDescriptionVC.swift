//
//  PendingApprovalEventDescriptionVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 12/11/2023.
//

import UIKit

class PendingApprovalEventDescriptionVC: ENTALDBaseViewController {
    
    var summaryData : pendingApprovalSummaryModel?
    var eventData : PendingApprovalEventsModel?
    var orgnizerContactData : [OrgnizerEventModel]?
    var programsData : [ProgramModel]?
    var selectedStatus : String?
    var adhocSelected : Bool?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var lblSectionHeading: [UILabel]!
    @IBOutlet var lblHeadings: [UILabel]!
    @IBOutlet var btnViews: [UIView]!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnSelectContact: UIButton!
    @IBOutlet weak var btnSelectProgrm: UIButton!
    @IBOutlet weak var btnSelectStatus: UIButton!
    
    @IBOutlet weak var txtEventName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPrimaryPhone: UITextField!
    @IBOutlet weak var txtOrgnizerName: UITextField!
    @IBOutlet weak var DetailDescriptionTextView: UITextView!
    @IBOutlet weak var txtDonation: UITextField!
    
    @IBOutlet var btnAvailables: [UIButton]!

    @IBOutlet weak var btnFirstAidRoom: UIButton!
    @IBOutlet weak var btnBathroom: UIButton!
    @IBOutlet weak var btnCleanWater: UIButton!
    @IBOutlet weak var btnShadedArea: UIButton!
    @IBOutlet weak var btnParking: UIButton!
    @IBOutlet weak var btnOtherHealthAgency: UIButton!
    @IBOutlet weak var btnVolunteerArea: UIButton!
    @IBOutlet weak var btnPhone: UIButton!
    @IBOutlet weak var btnTableChair: UIButton!
    @IBOutlet weak var btnFood: UIButton!
    @IBOutlet weak var btnSiteMap: UIButton!
    @IBOutlet weak var btnRecptionPhone: UIButton!
    @IBOutlet weak var btnPowerSupply: UIButton!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
        getSummaryData()
        getOrgnizerContactData()
        getAllProgramesfile()
        
    }


    func decorateUI(){
        lblTitle.font = UIFont.BoldFont(22)
        btnSelectContact.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSelectContact.titleLabel?.font = UIFont.BoldFont(14)
        btnSelectProgrm.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSelectProgrm.titleLabel?.font = UIFont.BoldFont(14)
        btnSelectStatus.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSelectStatus.titleLabel?.font = UIFont.BoldFont(14)
        btnSubmit.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSubmit.titleLabel?.font = UIFont.BoldFont(16)
        btnSubmit.layer.cornerRadius = 6
        txtEventName.layer.borderWidth = 1
        txtEventName.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtDonation.layer.borderWidth = 1
        txtDonation.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtEmail.layer.borderWidth = 1
        txtEmail.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        txtPrimaryPhone.layer.borderWidth = 1
        txtPrimaryPhone.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        txtOrgnizerName.layer.borderWidth = 1
        txtOrgnizerName.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        DetailDescriptionTextView.layer.borderWidth = 1
        DetailDescriptionTextView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtDonation.layer.borderWidth = 1
        txtDonation.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtEventName.font = UIFont.BoldFont(13)
        txtEmail.font = UIFont.BoldFont(13)
        txtPrimaryPhone.font = UIFont.BoldFont(13)
        txtOrgnizerName.font = UIFont.BoldFont(13)
        DetailDescriptionTextView.font = UIFont.BoldFont(13)
        txtDonation.font = UIFont.BoldFont(13)
//        btnAdhocEvent.layer.cornerRadius = 3
        txtDonation.keyboardType = .decimalPad
        
//        txtEventName.isUserInteractionEnabled = false
        txtEmail.isUserInteractionEnabled = false
        txtPrimaryPhone.isUserInteractionEnabled = false
        txtOrgnizerName.isUserInteractionEnabled = false
//        DetailDescriptionTextView.isUserInteractionEnabled = false
//        txtDonation.isUserInteractionEnabled = false
        
        for label in lblSectionHeading{
            label.textColor = UIColor.themePrimaryColor
            label.font = UIFont.BoldFont(14)
        }
        for label in lblHeadings{
            label.textColor = UIColor.themePrimaryColor
            label.font = UIFont.BoldFont(13)
        }
        
        for vw in btnViews{
            vw.layer.cornerRadius = 5
        }
        
        for btn in btnAvailables{
            
            btn.layer.cornerRadius = 3
            btn.backgroundColor = UIColor.viewLightGrayColor
        }
//        txtEventName.setLeftPaddingPoints(10)
//        txtEventName.setRightPaddingPoints(10)
//        txtEmail.setLeftPaddingPoints(10)
//        txtEmail.setRightPaddingPoints(10)
//        txtPrimaryPhone.setLeftPaddingPoints(10)
//        txtPrimaryPhone.setRightPaddingPoints(10)
//        txtOrgnizerName.setLeftPaddingPoints(10)
//        txtOrgnizerName.setRightPaddingPoints(10)
//        txtDonation.setLeftPaddingPoints(10)
//        txtDonation.setRightPaddingPoints(10)
        
        txtEventName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: txtEventName.frame.height))
        txtEventName.leftViewMode = .always
        txtEventName.rightViewMode = .always
        txtEventName.layer.cornerRadius = 4
        txtEmail.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: txtEmail.frame.height))
        txtEmail.leftViewMode = .always
        txtEmail.rightViewMode = .always
        txtEmail.layer.cornerRadius = 4
        txtPrimaryPhone.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: txtPrimaryPhone.frame.height))
        txtPrimaryPhone.leftViewMode = .always
        txtPrimaryPhone.rightViewMode = .always
        txtPrimaryPhone.layer.cornerRadius = 4
        txtOrgnizerName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: txtOrgnizerName.frame.height))
        txtOrgnizerName.leftViewMode = .always
        txtOrgnizerName.rightViewMode = .always
        txtOrgnizerName.layer.cornerRadius = 4
        txtDonation.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: txtDonation.frame.height))
        txtDonation.leftViewMode = .always
        txtDonation.rightViewMode = .always
        txtDonation.layer.cornerRadius = 4
    }
    
    func setupData(){
        
//        let locationType = ProcessUtils.shared.getLocationType(code: self.summaryData?.msnfp_locationtype ?? 00)
//        btnSelectProgrm.setTitle(locationType, for: .normal)
        
//        self.setBtn(btn: btnAdhocEvent, value: self.summaryData?.sjavms_adhocevent ?? false)
//        self.adhocSelected = self.summaryData?.sjavms_adhocevent ?? false
        self.setBtn(btn: btnAvailables[0], value: self.summaryData?.sjavms_firstaidroomtent ?? false)
        self.setBtn(btn: btnAvailables[1], value: self.summaryData?.sjavms_bathrooms ?? false)
        self.setBtn(btn: btnAvailables[2], value: self.summaryData?.sjavms_cleandrinkingwater ?? false)
        self.setBtn(btn: btnAvailables[3], value: self.summaryData?.sjavms_shadedareaifoutside ?? false)
        self.setBtn(btn: btnAvailables[4], value: self.summaryData?.sjavms_parking ?? false)
        self.setBtn(btn: btnAvailables[5], value: self.summaryData?.sjavms_willotherhealthcareagenciesbeonsite ?? false)
        self.setBtn(btn: btnAvailables[6], value: self.summaryData?.sjavms_designatedvolunteerarea ?? false)
        self.setBtn(btn: btnAvailables[7], value: self.summaryData?.sjavms_telephone ?? false)
        self.setBtn(btn: btnAvailables[8], value: self.summaryData?.sjavms_tableschairsseating ?? false)
        self.setBtn(btn: btnAvailables[9], value: self.summaryData?.sjavms_foodforvolunteers ?? false)
        self.setBtn(btn: btnAvailables[10], value: self.summaryData?.sjavms_sitemapifapplicable ?? false)
        self.setBtn(btn: btnAvailables[11], value: self.summaryData?.sjavms_cellphonereception ?? false)
        self.setBtn(btn: btnAvailables[12], value: self.summaryData?.sjavms_electricalpowersupply ?? false)
        
        self.txtDonation.text = self.summaryData?.sjavms_donationintended?.getFormattedNumber()
        self.txtEventName.text = self.summaryData?.sjavms_name ?? ""
        self.DetailDescriptionTextView.text = self.summaryData?.sjavms_eventdescription ?? ""
        
        let status = ProcessUtils.shared.eventStatusArr[self.summaryData?.sjavms_volunteerrequeststatus ?? 0]
        self.btnSelectStatus.setTitle(status, for: .normal)

    }
    
    func setBtn(btn: UIButton , value : Bool){
        
        if (value == true) {
            btn.setImage(UIImage(named: "ic_check"), for: .normal)
            btn.backgroundColor = UIColor.clear
            btn.isSelected = true
        }else{
            btn.setImage(UIImage(named: ""), for: .normal)
            btn.backgroundColor = UIColor.viewLightGrayColor
            btn.isSelected = false
        }
        
    }
    
    @IBAction func availableBtnTapped(_ sender: UIButton) {
        
        if self.btnAvailables[sender.tag].isSelected == false  {
            self.btnAvailables[sender.tag].setImage(UIImage(named: "ic_check"), for: .normal)
            self.btnAvailables[sender.tag].backgroundColor = UIColor.clear
        }else{
            self.btnAvailables[sender.tag].setImage(UIImage(named: ""), for: .normal)
            self.btnAvailables[sender.tag].backgroundColor = UIColor.viewLightGrayColor
            
        }
        
        self.btnAvailables[sender.tag].isSelected = !sender.isSelected
    }
    
    
    
    @IBAction func eventStatusUpdate(_ sender: Any) {
        self.showGroupsPicker()
    }
    
    func setupOrgnizerData(){
        
//        self.btnSelectContact = self.orgnizerContactData.
        
 
        txtEmail.text = self.orgnizerContactData?[0].sjavms_Contact?.emailaddress1 ?? ""
        txtPrimaryPhone.text = self.orgnizerContactData?[0].sjavms_Contact?.telephone1 ?? ""
        txtOrgnizerName.text = "\(self.orgnizerContactData?[0].sjavms_Contact?.firstname ?? "") \(self.orgnizerContactData?[0].sjavms_Contact?.lastname ?? "")"

    }
    
    
    
    
    
    @IBAction func submitTapped(_ sender: Any) {
        self.updatedata()
    }
    
    @IBAction func adhocTapped(_ sender: Any) {
        
//        if (self.adhocSelected == true){
//            self.adhocSelected = false
//            self.btnAdhocEvent.setImage(UIImage(named: ""), for: .normal)
//            self.btnAdhocEvent.backgroundColor = UIColor.viewLightGrayColor
//        }else{
//            self.adhocSelected = true
//            self.btnAdhocEvent.setImage(UIImage(named: "ic_check"), for: .normal)
//            self.btnAdhocEvent.backgroundColor = UIColor.clear
//        }
        
    }
    
    
    fileprivate func getSummaryData(){
        guard let eventId = self.eventData?.sjavms_eventrequestid else {return}
        
            let params : [String:Any] = [
                
                ParameterKeys.select : "sjavms_name,sjavms_address1name,sjavms_maxvolunteers,sjavms_eventstartdate,statecode,_sjavms_program_value,sjavms_eventrequestid,sjavms_willotherhealthcareagenciesbeonsite,sjavms_volunteerrequeststatus,sjavms_telephone,sjavms_tableschairsseating,statuscode,sjavms_sitemapifapplicable,sjavms_shadedareaifoutside,sja_securityonsite,sjavms_phone,sjavms_parking,sjavms_othercomments,sjavms_organization,sjavms_multidayevent,sjavms_maxparticipants,sjavms_lastname,sja_iceonsite,sjavms_foodforvolunteers,sjavms_firstname,sjavms_firstaidroomtent,sjavms_eventenddate,sjavms_eventdescription,sjavms_eventaudience,sjavms_email,sjavms_electricalpowersupply,sjavms_donationintended,sjavms_designatedvolunteerarea,sjavms_declinereason,sjavms_declinedetails,_sjavms_council_value,sjavms_coordinatorphone,sjavms_coordinatorlastname,sjavms_coordinatorfirstname,sjavms_coordinatoremail,sjavms_cleandrinkingwater,sjavms_cellphonereception,_sjavms_branch_value,sjavms_bathrooms,sjavms_address1stateprovince,sjavms_address1zippostalcode,sjavms_address1line3,sjavms_address1line2,sjavms_address1line1,sjavms_address1city,_sjavms_account_value,sjavms_13under,sjavms_1417,sjavms_1860,sjavms_60plus",
                ParameterKeys.filter : "(sjavms_eventrequestid eq \(eventId))",
                ]
                self.getSummary(params:params)
    }
    
    fileprivate func getSummary(params: [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getPendingApprovalEventSummary(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let summaryData = response.value {
                    if summaryData[0] != nil{
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
    
    fileprivate func getOrgnizerContactData(){
        guard let eventId = self.eventData?.sjavms_eventrequestid else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle",
            ParameterKeys.expand : "sjavms_Contact($select=emailaddress1,address1_country,address1_line1,address1_line3,address1_city,lastname,firstname,address1_postalcode,telephone1,address1_stateorprovince,address1_line2,adx_organizationname)",
            
            ParameterKeys.filter : "(msnfp_engagementopportunityid eq \(eventId)) and (sjavms_Contact/contactid ne null)"

        ]

        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getOrgnizerContact(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let orgnizerData = response.value {
                    self.orgnizerContactData = orgnizerData
                    if ((self.orgnizerContactData?.count ?? 0) > 0){
                        DispatchQueue.main.async {
                            self.setupOrgnizerData()
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
                        
                        self.btnSelectProgrm.setTitle(program?.sjavms_name ?? "", for: .normal)
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
                
        ENTALDLibraryAPI.shared.updateEventStatus(eventid: self.eventData?.sjavms_eventrequestid ?? "", params: params){ result in
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
            "sjavms_name": self.txtEventName.text as? String,
            "sjavms_eventdescription": self.DetailDescriptionTextView.text as? String,
            "sjavms_donationintended": self.txtDonation.text as? Float,
//            "sjavms_adhocevent": self.adhocSelected as? Bool,

            "sjavms_firstaidroomtent" : btnAvailables[0].isSelected ? true : false as? Bool,
            "sjavms_bathrooms" : btnAvailables[1].isSelected ? true : false as? Bool,
            "sjavms_cleandrinkingwater" : btnAvailables[2].isSelected ? true : false as? Bool,
            "sjavms_shadedareaifoutside" : btnAvailables[3].isSelected ? true : false as? Bool,
            "sjavms_parking" : btnAvailables[4].isSelected ? true : false as? Bool,
            "sjavms_willotherhealthcareagenciesbeonsite" : btnAvailables[5].isSelected ? true : false as? Bool,
            "sjavms_designatedvolunteerarea" : btnAvailables[6].isSelected ? true : false as? Bool,
            "sjavms_telephone" : btnAvailables[6].isSelected ? true : false as? Bool,
            "sjavms_tableschairsseating" : btnAvailables[7].isSelected ? true : false as? Bool,
            "sjavms_foodforvolunteers" : btnAvailables[8].isSelected ? true : false as? Bool,
            "sjavms_sitemapifapplicable" : btnAvailables[9].isSelected ? true : false as? Bool,
            "sjavms_cellphonereception" : btnAvailables[10].isSelected ? true : false as? Bool,
            "sjavms_electricalpowersupply" : btnAvailables[11].isSelected ? true : false as? Bool
               
        ] as [String : Any]
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        let eventId = self.eventData?.sjavms_eventrequestid ?? ""
        
        ENTALDLibraryAPI.shared.updatePendingApprovalSummaryData(eventId: eventId, params: params) { result in
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
    
    
    
}