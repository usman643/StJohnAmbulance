//
//  EventNotesVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/03/2023.
//

import UIKit

class EventNotesVC: ENTALDBaseViewController {

    var eventData : CurrentEventsModel?
    var summaryData : EventSummaryModel?
    var selectedStatus : String?
    var isDesignatedSpaceforVolunteer : Bool?
    var isOrgnizerAdequateSupport : Bool?

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var lblSectionTitle: [UILabel]!
    @IBOutlet var lblTextFieldHeadings: [UILabel]!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var btnStatusView: UIView!
    @IBOutlet weak var txtParticipantNum: UITextField!
    @IBOutlet weak var txtDonationReceived: UITextField!
    @IBOutlet weak var txtSurveyComment: UITextView!
    @IBOutlet weak var txtOtherComment: UITextView!
    @IBOutlet var lblAvailables: [UILabel]!
    @IBOutlet var btnAvailables: [UIButton]!
    
    @IBOutlet weak var btnSubmit: UIButton!

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
    @IBOutlet weak var btnDesignatedSpaceforVolunteer: UIButton!
    @IBOutlet weak var OrgnizerAdequateSupport: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSummaryData()
        decorateUI()
    }

    func decorateUI(){
        lblTitle.font = UIFont.BoldFont(22)
        btnStatusView.layer.cornerRadius = 5
        btnStatus.titleLabel?.font = UIFont.RegularFont(14)
        btnSubmit.titleLabel?.font = UIFont.BoldFont(14)
        btnStatus.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSubmit.setTitleColor(UIColor.textWhiteColor, for: .normal)
        
        txtParticipantNum.font = UIFont.RegularFont(13)
        txtParticipantNum.textColor = UIColor.themeBlackText
        txtDonationReceived.font = UIFont.RegularFont(13)
        txtDonationReceived.textColor = UIColor.themeBlackText
        txtSurveyComment.font = UIFont.RegularFont(13)
        txtSurveyComment.textColor = UIColor.themeBlackText
        txtOtherComment.font = UIFont.RegularFont(13)
        txtOtherComment.textColor = UIColor.themeBlackText
        
        txtParticipantNum.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtParticipantNum.layer.borderWidth = 1
        txtDonationReceived.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtDonationReceived.layer.borderWidth = 1
        txtSurveyComment.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtSurveyComment.layer.borderWidth = 1
        txtOtherComment.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtOtherComment.layer.borderWidth = 1
        
//        txtParticipantNum.isUserInteractionEnabled = false
//        txtDonationReceived.isUserInteractionEnabled = false
//        txtSurveyComment.isUserInteractionEnabled = false
//        txtOtherComment.isUserInteractionEnabled = false
        
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        self.txtParticipantNum.keyboardType = .numberPad
        self.txtDonationReceived.keyboardType = .decimalPad
        
        for label in lblSectionTitle{
            label.font = UIFont.BoldFont(14)
            label.textColor = UIColor.themePrimaryWhite
        }

        for label in lblTextFieldHeadings{
            label.font = UIFont.BoldFont(13)
            label.textColor = UIColor.themePrimaryWhite
        }
        
        for label in lblAvailables{
            label.font = UIFont.RegularFont(13)
            label.textColor = UIColor.themePrimaryWhite
        }
        
        for btn in btnAvailables{
            btn.layer.cornerRadius = 2
            
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
    
    
    @IBAction func submitTapped(_ sender: Any) {
        self.updatedata()
    }
    
    func setupData(){

        self.setBtn(btn: OrgnizerAdequateSupport, value: self.summaryData?.sjavms_eventorganizerprovidedadequatesupport ?? false)
        self.setBtn(btn: btnDesignatedSpaceforVolunteer, value: self.summaryData?.sjavms_designatedspaceforvolunteers ?? false)
        
        self.setBtn(btn: btnAvailables[0], value: self.summaryData?.sjavms_onsitefirstaidroomtent ?? false)
        self.setBtn(btn: btnAvailables[1], value: self.summaryData?.sjavms_bathrooms ?? false)
        self.setBtn(btn: btnAvailables[2], value: self.summaryData?.sjavms_onsitecleandrinkingwater ?? false)
        self.setBtn(btn: btnAvailables[3], value: self.summaryData?.sjavms_shadedareaifoutside ?? false)
        self.setBtn(btn: btnAvailables[4], value: self.summaryData?.sjavms_parking ?? false)
        self.setBtn(btn: btnAvailables[5], value: self.summaryData?.sjavms_willotherhealthcareagenciesbeonsite ?? false)
        self.setBtn(btn: btnAvailables[6], value: self.summaryData?.sjavms_onsitedesignatedvolunteerarea ?? false)
        self.setBtn(btn: btnAvailables[7], value: self.summaryData?.sjavms_telephone ?? false)
        self.setBtn(btn: btnAvailables[8], value: self.summaryData?.sjavms_tableschairsseating ?? false)
        self.setBtn(btn: btnAvailables[9], value: self.summaryData?.sjavms_foodforvolunteers ?? false)
        self.setBtn(btn: btnAvailables[10], value: self.summaryData?.sjavms_sitemapifapplicable ?? false)
        self.setBtn(btn: btnAvailables[11], value: self.summaryData?.sjavms_cellphonereception ?? false)
        self.setBtn(btn: btnAvailables[12], value: self.summaryData?.sjavms_electricalpowersupply ?? false)
        
        self.txtParticipantNum.text = "\(self.summaryData?.sjavms_numberofparticipants ?? NSNotFound)"
        self.txtDonationReceived.text = self.summaryData?.sjavms_donationreceived?.getFormattedNumber()
        self.txtSurveyComment.text = self.summaryData?.sjavms_surveycomments ?? ""
        self.txtOtherComment.text = self.summaryData?.sjavms_othercomments ?? ""
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
    
    @IBAction func designatedSpaceTapped(_ sender: Any) {
        if (self.isDesignatedSpaceforVolunteer == true){
            self.isDesignatedSpaceforVolunteer = false
            self.btnDesignatedSpaceforVolunteer.setImage(UIImage(named: ""), for: .normal)
            self.btnDesignatedSpaceforVolunteer.backgroundColor = UIColor.viewLightGrayColor
        }else{
            self.isDesignatedSpaceforVolunteer = true
            self.btnDesignatedSpaceforVolunteer.setImage(UIImage(named: "ic_check"), for: .normal)
            self.btnDesignatedSpaceforVolunteer.backgroundColor = UIColor.clear
        }
        
    }
    
    @IBAction func AdequateSupportTapped(_ sender: Any) {
        if (self.isOrgnizerAdequateSupport == true){
            self.isOrgnizerAdequateSupport = false
            self.OrgnizerAdequateSupport.setImage(UIImage(named: ""), for: .normal)
            self.OrgnizerAdequateSupport.backgroundColor = UIColor.viewLightGrayColor
        }else{
            self.isOrgnizerAdequateSupport = true
            self.OrgnizerAdequateSupport.setImage(UIImage(named: "ic_check"), for: .normal)
            self.OrgnizerAdequateSupport.backgroundColor = UIColor.clear
        }
        
    }
    
    @IBAction func eventStatusUpdate(_ sender: Any) {
        
        self.showGroupsPicker()
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
    
    fileprivate func updatedata(){

        let params = [
            
            "sjavms_numberofparticipants" : Int(self.txtParticipantNum.text ?? "") ?? 0 as Int,
            "sjavms_donationreceived" : Float(self.txtDonationReceived.text ?? "") ?? 0 as Float,
            "sjavms_surveycomments": self.txtSurveyComment.text as String,
            "sjavms_othercomments" : self.txtOtherComment.text as String,
            
            "sjavms_eventorganizerprovidedadequatesupport" : isOrgnizerAdequateSupport ?? self.summaryData?.sjavms_eventorganizerprovidedadequatesupport ?? false as Bool,
            "sjavms_designatedspaceforvolunteers" : isDesignatedSpaceforVolunteer ?? self.summaryData?.sjavms_designatedspaceforvolunteers ?? false as Bool,
            "sjavms_onsitefirstaidroomtent" : btnAvailables[0].isSelected ? true : false as? Bool,
            "sjavms_bathrooms" : btnAvailables[1].isSelected ? true : false as? Bool,
            "sjavms_onsitecleandrinkingwater" : btnAvailables[2].isSelected ? true : false as? Bool,
            "sjavms_shadedareaifoutside" : btnAvailables[3].isSelected ? true : false as? Bool,
            "sjavms_parking" : btnAvailables[4].isSelected ? true : false as? Bool,
            "sjavms_willotherhealthcareagenciesbeonsite" : btnAvailables[5].isSelected ? true : false as? Bool,
            "sjavms_onsitedesignatedvolunteerarea" : btnAvailables[6].isSelected ? true : false as? Bool,
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
    
    
    
}
