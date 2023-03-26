//
//  EventDescriptionVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 24/03/2023.
//

import UIKit

class EventDescriptionVC: ENTALDBaseViewController {
    
    var summaryData : EventSummaryModel?
    var eventData : CurrentEventsModel?
    var orgnizerContactData : [OrgnizerEventModel]?
    var programsData : [ProgramModel]?
    var selectedStatus : String?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var lblSectionHeading: [UILabel]!
    @IBOutlet var lblHeadings: [UILabel]!
    @IBOutlet weak var btnAdhocEvent: UIButton!
    @IBOutlet weak var lblAdhoc: UILabel!
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
        getSummaryData()
        decorateUI()
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
        btnSubmit.titleLabel?.font = UIFont.BoldFont(13)
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
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
        txtDonation.layer.borderWidth = 1
        txtDonation.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtEventName.font = UIFont.RegularFont(13)
        txtEmail.font = UIFont.RegularFont(13)
        txtPrimaryPhone.font = UIFont.RegularFont(13)
        txtOrgnizerName.font = UIFont.RegularFont(13)
        DetailDescriptionTextView.font = UIFont.RegularFont(13)
        txtDonation.font = UIFont.RegularFont(13)
        
        txtEventName.isUserInteractionEnabled = false
        txtEmail.isUserInteractionEnabled = false
        txtPrimaryPhone.isUserInteractionEnabled = false
        txtOrgnizerName.isUserInteractionEnabled = false
        DetailDescriptionTextView.isUserInteractionEnabled = false
        txtDonation.isUserInteractionEnabled = false
        
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
    }
    
    func setupData(){
        
        let locationType = ProcessUtils.shared.getLocationType(code: self.summaryData?.msnfp_locationtype ?? 00)
        btnSelectProgrm.setTitle(locationType, for: .normal)
        
        self.setBtn(btn: btnAdhocEvent, value: self.summaryData?.sjavms_adhocevent ?? false)
        self.setBtn(btn: btnFirstAidRoom, value: self.summaryData?.sjavms_onsitefirstaidroomtent ?? false)
        self.setBtn(btn: btnBathroom, value: self.summaryData?.sjavms_bathrooms ?? false)
        self.setBtn(btn: btnCleanWater, value: self.summaryData?.sjavms_onsitecleandrinkingwater ?? false)
        
        self.setBtn(btn: btnShadedArea, value: self.summaryData?.sjavms_shadedareaifoutside ?? false)
        self.setBtn(btn: btnParking, value: self.summaryData?.sjavms_parking ?? false)
        self.setBtn(btn: btnOtherHealthAgency, value: self.summaryData?.sjavms_willotherhealthcareagenciesbeonsite ?? false)
        self.setBtn(btn: btnVolunteerArea, value: self.summaryData?.sjavms_onsitedesignatedvolunteerarea ?? false)
        self.setBtn(btn: btnPhone, value: self.summaryData?.sjavms_telephone ?? false)
        self.setBtn(btn: btnTableChair, value: self.summaryData?.sjavms_tableschairsseating ?? false)
        self.setBtn(btn: btnFood, value: self.summaryData?.sjavms_foodforvolunteers ?? false)
        self.setBtn(btn: btnSiteMap, value: self.summaryData?.sjavms_sitemapifapplicable ?? false)
        self.setBtn(btn: btnRecptionPhone, value: self.summaryData?.sjavms_cellphonereception ?? false)
        self.setBtn(btn: btnPowerSupply, value: self.summaryData?.sjavms_electricalpowersupply ?? false)
        
        self.txtDonation.text = self.summaryData?.sjavms_donationintended?.getFormattedNumber()
        self.txtEventName.text = self.summaryData?.msnfp_engagementopportunitytitle ?? ""
        self.DetailDescriptionTextView.text = self.summaryData?.msnfp_description ?? ""
        
        let status = ProcessUtils.shared.eventStatusArr[self.summaryData?.msnfp_engagementopportunitystatus ?? 0]
        self.btnSelectStatus.setTitle(status, for: .normal)
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
    
    fileprivate func getOrgnizerContactData(){
        guard let eventId = self.eventData?.msnfp_engagementopportunityid else {return}
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
                    DispatchQueue.main.async {
                        self.setupOrgnizerData()
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
    
    
    func getProgramName(_ programId:String)->ProgramModel?{
        let programModel = self.programsData?.filter({$0.sjavms_programid == programId}).first
        return programModel
    }
    
    
    
}
