//
//  EventLocationVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 24/03/2023.
//

import UIKit

class EventLocationVC: ENTALDBaseViewController {
    
    var eventData : CurrentEventsModel?
    var summaryData : EventSummaryModel?
    var selectedStatus : String?
    var selectedLocationType : String?
    var selectedLocationTypeValue : Int?
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var lblSectionHeading: [UILabel]!
    @IBOutlet var lblTxtTitle: [UILabel]!
    @IBOutlet var allTxtFields: [UITextField]!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnStatusView: UIView!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var btnLocationType: UIButton!
    @IBOutlet weak var btnLocationTypeView: UIView!
    
    @IBOutlet weak var txtStreet1: UITextField!
    @IBOutlet weak var txtStreet2: UITextField!
    @IBOutlet weak var txtStreet3: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtProvince: UITextField!
    @IBOutlet weak var txtPostalCode: UITextField!
    @IBOutlet weak var txtLocationContactName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSummaryData()
        decorateUI()
        
    }

    func decorateUI(){
        
        lblTitle.font = UIFont.BoldFont(22)
        btnStatusView.layer.cornerRadius = 5
        btnLocationTypeView.layer.cornerRadius = 5
        btnStatus.titleLabel?.font = UIFont.BoldFont(14)
        btnStatus.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnLocationType.titleLabel?.font = UIFont.BoldFont(14)
        btnLocationType.setTitleColor(UIColor.textWhiteColor, for: .normal)
        
        for label in lblSectionHeading {
            
            label.font = UIFont.BoldFont(14)
            label.textColor = UIColor.themePrimaryWhite
        }
        
        for label in lblTxtTitle {
            
            label.font = UIFont.BoldFont(13 )
            label.textColor = UIColor.themePrimaryWhite
        }

        for txtfield in allTxtFields {
            
            txtfield.font = UIFont.BoldFont(12)
            txtfield.textColor = UIColor.themePrimaryWhite
        }
        
        for txtfield in allTxtFields {
            
            txtfield.font = UIFont.BoldFont(12)
            txtfield.textColor = UIColor.themePrimaryWhite
            txtfield.layer.borderWidth = 1
            txtfield.layer.borderColor = UIColor.themePrimaryWhite.cgColor
//            txtfield.isUserInteractionEnabled = false
        }
        
        
        
    }
    
    func setupData(){
        
        let locationType = ProcessUtils.shared.getLocationType(code: self.summaryData?.msnfp_locationtype ?? 00)
        btnLocationType.setTitle(locationType, for: .normal)
        txtStreet1.text = self.summaryData?.msnfp_street1 ?? ""
        txtStreet2.text = self.summaryData?.msnfp_street2 ?? ""
        txtStreet3.text = self.summaryData?.msnfp_street3 ?? ""
        txtCity.text = self.summaryData?.msnfp_city ?? ""
        txtProvince.text = self.summaryData?.msnfp_stateprovince ?? ""
        txtPostalCode.text = self.summaryData?.msnfp_zippostalcode ?? ""
        txtLocationContactName.text =  self.summaryData?.sjavms_locationcontactname ?? ""
        
        let status = ProcessUtils.shared.eventStatusArr[self.summaryData?.msnfp_engagementopportunitystatus ?? 0]
        self.btnStatus.setTitle(status, for: .normal)
        
    }

    @IBAction func submitTapped(_ sender: Any) {
        self.updatedata()
    }
    @IBAction func locationTypeTapped(_ sender: Any) {
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.locationType, dataObj: ProcessUtils.shared.locationTypes) { params, controller in
            
            self.selectedLocationTypeValue = params as? Int
            self.selectedLocationType = ProcessUtils.shared.getLocationType(code : self.selectedLocationTypeValue ?? NSNotFound )
            self.btnLocationType.setTitle(self.selectedLocationType, for: .normal)
            
        }
        
        
    }
    
    @IBAction func statusTypeTapped(_ sender: Any) {
        self.showGroupsPicker()
    }
    
    
    
    
    
    //================== API ====================
    fileprivate func getSummaryData(){
        guard let eventId = self.eventData?.msnfp_engagementopportunityid else {return}
        
        if (self.eventData?._sjavms_contact_value == "pendingApproval"){
            let params : [String:Any] = [
                
                ParameterKeys.select : "sjavms_address1name,sjavms_maxvolunteers,sjavms_eventstartdate,statecode,_sjavms_program_value,sjavms_eventrequestid,sjavms_willotherhealthcareagenciesbeonsite,sjavms_volunteerrequeststatus,sjavms_telephone,sjavms_tableschairsseating,statuscode,sjavms_sitemapifapplicable,sjavms_shadedareaifoutside,sja_securityonsite,sjavms_phone,sjavms_parking,sjavms_othercomments,sjavms_organization,sjavms_multidayevent,sjavms_maxparticipants,sjavms_lastname,sja_iceonsite,sjavms_foodforvolunteers,sjavms_firstname,sjavms_firstaidroomtent,sjavms_eventenddate,sjavms_eventdescription,sjavms_eventaudience,sjavms_email,sjavms_electricalpowersupply,sjavms_donationintended,sjavms_designatedvolunteerarea,sjavms_declinereason,sjavms_declinedetails,_sjavms_council_value,sjavms_coordinatorphone,sjavms_coordinatorlastname,sjavms_coordinatorfirstname,sjavms_coordinatoremail,sjavms_cleandrinkingwater,sjavms_cellphonereception,_sjavms_branch_value,sjavms_bathrooms,sjavms_address1stateprovince,sjavms_address1zippostalcode,sjavms_address1line3,sjavms_address1line2,sjavms_address1line1,sjavms_address1city,_sjavms_account_value",
                ParameterKeys.filter : "(sjavms_eventrequestid eq \(eventId))",
                ]
                self.getSummary(params:params)
        }else{
           
            let params : [String:Any] = [
                
                ParameterKeys.select : "_sjavms_group_value,sjavms_onsiteparking,sjavms_tableschairsseating,msnfp_engagementopportunityid,sjavms_designatedvolunteerarea,sjavms_cleandrinkingwater,sjavms_othertreatments,sjavms_designatedspaceforvolunteers,sjavms_electricalpowersupply,msnfp_stateprovince,msnfp_shortdescription,_sjavms_program_value,sjavms_foodforvolunteers,msnfp_filledshifts,statuscode,msnfp_location,sjavms_age1860,msnfp_description,msnfp_maximum,_sjavms_branch_value,msnfp_endingdate,sjavms_onsitefoodforvolunteers,sjavms_age13under,msnfp_appliedparticipants,sjavms_age60,sjavms_eventscheduleinformation,msnfp_engagementopportunitystatus,sjavms_bathrooms,_sjavms_contact_value,msnfp_engagementopportunitytitle,msnfp_completed,sjavms_onsitecleandrinkingwater,_sjavms_council_value,msnfp_street1,msnfp_street2,sjavms_age1417,msnfp_shifts,sjavms_donationreceived,_msnfp_primarycontactid_value,sjavms_willotherhealthcareagenciesbeonsite,msnfp_number,sjavms_numberofparticipants,msnfp_cancelledshifts,sjavms_multidayevent,sjavms_firstaidroomtent,sjavms_emergencyservicescalled,sjavms_sitemapifapplicable,sjavms_onsitedesignatedvolunteerarea,_sjavms_eventcoordinator_value,sjavms_totalapproved,sjavms_onsitecellphonereception,sjavms_telephone,sjavms_onsitebathrooms,sjavms_onsiteother,sjavms_cellphonereception,_sjavms_account_value,msnfp_locationtype,sjavms_patientstreated,sjavms_onsitefirstaidroomtent,_sjavms_posteventsurvey_value,msnfp_minimum,sjavms_onsitetelephone,msnfp_city,sjavms_parking,sjavms_eventorganizerprovidedadequatesupport,msnfp_multipledays,msnfp_startingdate,sjavms_donationintended,msnfp_street3,sjavms_othercomments,sjavms_eventrequirements,sjavms_surveycomments,statecode,sjavms_adhocevent,sjavms_shadedareaifoutside,msnfp_zippostalcode,sjavms_locationcontactname,sjavms_maxparticipants",
                ParameterKeys.filter : "(msnfp_engagementopportunityid eq \(eventId))",
                
            ]
            self.getSummary(params:params)
        }
    }
    
    fileprivate func getSummary(params: [String:Any]){
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
                    if summaryData.count > 0 {
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

       var params = [
            
            "msnfp_street1" : txtStreet1.text ?? "" as String,
            "msnfp_street2" : txtStreet2.text ?? "" as String,
            "msnfp_street3" : txtStreet3.text ?? "" as String,
            "msnfp_city" : txtCity.text ?? "" as String,
            "msnfp_stateprovince" : txtProvince.text ?? "" as String,
            "msnfp_zippostalcode" : txtPostalCode.text ?? "" as String,
            "sjavms_locationcontactname" : txtLocationContactName.text ?? "" as String
        ] as [String : Any]
        
        if self.selectedLocationTypeValue != nil {
            params["msnfp_locationtype"] = (selectedLocationTypeValue ?? NSNotFound) as Int
        }
        
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
