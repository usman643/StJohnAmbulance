//
//  CreateAdhocHourVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 08/04/2023.
//

import UIKit

class CreateAdhocHourVC: ENTALDBaseViewController {

    var isTherapyDogSelected = false
    let conId = UserDefaults.standard.contactIdToken ?? ""
    var selectedEventOppertunityID : String? = ""
    var selectedNonEventOppertunityID : String? = ""
    var numberOfHours : Float?
    var date : String?
    var therapyDogIdSelected : String?
    var therapyDogFacilitySelected : String?
    var therapyDogIDSelectedModel : TherapyDogIdModel?
    var therapyDogFacilitySelectedModed : TherapyDogFacilityModel?
    var adhocHourEventSelectedModel : AdhocHourVolunteerEventModel?
    var nonAdhocHourEventSelectedModel : NonAdhocHourVolunteerEventModel?
    var datePicker = UIDatePicker()
    
    var therapyDogID : [TherapyDogIdModel]?
    var therapyDogFacility : [TherapyDogFacilityModel]?
    var adhocHourEvent : [AdhocHourVolunteerEventModel]?
    var nonAdhocHourEvent : [NonAdhocHourVolunteerEventModel]?
    
    

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var allLabelTitles: [UILabel]!
    
    @IBOutlet weak var txtHourNumbers: UITextField!
    @IBOutlet weak var txtDateWorked: UITextField!
    @IBOutlet weak var txtNotes: UITextView!
    
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var btnTherapyDogFamily: UIButton!
    @IBOutlet weak var btnTherapyDog: UIButton!
    @IBOutlet weak var btnEvent: UIButton!
    
    @IBOutlet weak var btnTherapyDogShow: UIButton!
    
    @IBOutlet weak var therapyDogView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        decorateUI()
        getTherapyDogID()
        getTherapyDogFacility()
        getAdhocHourEvent()
        getnonAdhocHourEvent()
        
        if #available(iOS 13.4, *) {
            datePicker.datePickerMode = .dateAndTime
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
    }

    func decorateUI(){
        
        lblTitle.textColor = UIColor.themePrimaryWhite
        lblTitle.font = UIFont.BoldFont(22)
        
        for label in allLabelTitles{
            label.font = UIFont.BoldFont(14)
            label.textColor = UIColor.themePrimaryWhite
        }
        
        txtHourNumbers.font = UIFont.BoldFont(13)
        txtDateWorked.font = UIFont.BoldFont(13)
        txtNotes.font = UIFont.BoldFont(13)
        txtHourNumbers.textColor = UIColor.themePrimaryWhite
        txtDateWorked.textColor = UIColor.themePrimaryWhite
        txtNotes.textColor = UIColor.themePrimaryWhite
        
        txtHourNumbers.layer.borderWidth = 1
        txtDateWorked.layer.borderWidth = 1
        txtNotes.layer.borderWidth = 1
        txtHourNumbers.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtDateWorked.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtNotes.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        
        
        btnCreate.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnTherapyDogFamily.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnTherapyDog.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnEvent.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnCreate.titleLabel?.font = UIFont.BoldFont(14)
        btnTherapyDogFamily.titleLabel?.font = UIFont.BoldFont(13)
        btnTherapyDog.titleLabel?.font = UIFont.BoldFont(13)
        btnEvent.titleLabel?.font = UIFont.BoldFont(13)
        therapyDogView.isHidden = true
        
        txtHourNumbers.keyboardType = .decimalPad
        self.txtDateWorked.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(onChangeDate(_:)), for: .valueChanged)
        
    }
    
    @objc func onChangeDate(_ sender: UIDatePicker){
        
        let date = datePicker.date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy/MM/dd"


        if (self.txtDateWorked.isFirstResponder ){
            //start date
            
            if #available(iOS 15.0, *) {
                self.txtDateWorked.text = dateFormater.string(from: date)
                self.date = date.ISO8601Format()
            } else {
                // Fallback on earlier versions
            }
        }
    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func CreateTapped(_ sender: Any) {
        
        if isTherapyDogSelected == true {
            
            if (self.numberOfHours == nil){
                
                ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: "Number of Hours is a required field", actionTitle: .KOK, completion: {status in })
                return
            }else if (date == nil || date == "" ){
                
                ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: "Date Worked is a required field", actionTitle: .KOK, completion: {status in })
                return
                
            }
            self.postVolunteerNonAdhocHour()
        }else{
            
            if (self.txtHourNumbers.text == nil || self.txtHourNumbers.text == ""){
                
                ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: "Number of Hours is a required field.", actionTitle: .KOK, completion: {status in })
                return
            }
            self.postVolunteerAdhocHour()
        }
    }
    
    @IBAction func eventTapped(_ sender: Any) {
        if (isTherapyDogSelected == false){
            
            ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.adhocHourEvent, dataObj: self.adhocHourEvent) { params, controller in
                
                let model = params as? AdhocHourVolunteerEventModel
                self.adhocHourEventSelectedModel = model
                self.selectedEventOppertunityID = model?.msnfp_engagementopportunitytitle ?? ""
                self.btnEvent.setTitle(self.selectedEventOppertunityID, for: .normal)
            }
            
        }else{
            ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.nonAdhocHourEvent, dataObj: self.nonAdhocHourEvent) { params, controller in
                
               let model = params as? NonAdhocHourVolunteerEventModel
                self.nonAdhocHourEventSelectedModel = model
                self.selectedNonEventOppertunityID = model?.msnfp_engagementopportunitytitle ?? ""
                self.btnEvent.setTitle(self.selectedNonEventOppertunityID, for: .normal)
            }
        }
        
    }
    
    
    @IBAction func selectTherapyDogTapped(_ sender: Any) {
    
        if isTherapyDogSelected == true {
            isTherapyDogSelected = false
            self.btnTherapyDogShow.setImage(UIImage(named: ""), for: .normal)
            self.btnTherapyDogShow.backgroundColor = UIColor.viewLightGrayColor
            therapyDogView.isHidden = true
            
        }else{
            isTherapyDogSelected = true
            self.btnTherapyDogShow.setImage(UIImage(named: "ic_check"), for: .normal)
            self.btnTherapyDogShow.backgroundColor = UIColor.clear
            therapyDogView.isHidden = false
        }
        self.resetData()
    }
    
    @IBAction func therapyDogTapped(_ sender: Any) {
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.therapyDogID, dataObj: self.therapyDogID) { params, controller in
            
            let model = params as? TherapyDogIdModel
            self.therapyDogIDSelectedModel = model
            self.therapyDogIdSelected = model?.sjavms_vmstherapydogid ?? ""
            self.btnTherapyDog.setTitle(model?.sjavms_name ?? "", for: .normal)
        }
    
        
    }
    
    @IBAction func therapyDogFamilyTapped(_ sender: Any) {
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.therapyDogFacility, dataObj: self.therapyDogFacility) { params, controller in
            
            let model = params as? TherapyDogFacilityModel
            self.therapyDogFacilitySelectedModed = model
            self.therapyDogFacilitySelected = model?.accountid ?? ""
            self.btnTherapyDog.setTitle(model?.name ?? "", for: .normal)

        }
    }
    
    func resetData(){
        self.btnTherapyDogFamily.setTitle("", for: .normal)
        self.btnTherapyDog.setTitle("", for: .normal)
        self.btnEvent.setTitle("", for: .normal)
        
        self.selectedEventOppertunityID = ""
        self.selectedNonEventOppertunityID = ""
        self.numberOfHours = Float(NSNotFound)
        self.date = ""
        self.therapyDogIdSelected = ""
        self.therapyDogFacilitySelected = ""
        
        txtNotes.text = ""
        txtDateWorked.text = ""
        txtHourNumbers.text = ""
        
    }
    
    fileprivate func getTherapyDogID(){
        let params : [String:Any] = [
            ParameterKeys.select : "sjavms_veterinaryexpiry,sjavms_dogsbreed,sjavms_childevaluation,sjavms_adultevaluation,sjavms_name,sjavms_immunizationexpires,sjavms_vmstherapydogid",
            ParameterKeys.filter : "(statecode eq 0 and _sjavms_ownervolunteer_value eq \(conId))",
            ParameterKeys.orderby : "sjavms_name asc"
            
        ]
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getTherapyDogID(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let apiData = response.value {
                    self.therapyDogID = apiData
                   
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
    
    fileprivate func getTherapyDogFacility(){
        let params : [String:Any] = [
            ParameterKeys.select : "name,statecode,createdon,sjavms_typeoffacility,accountid",
            ParameterKeys.filter : "(msnfp_accounttype eq 802280000 and statecode eq 0) and (sjavms_account_contact_therapydogfacilities/any(o1:(o1/contactid eq \(self.conId))))",
            ParameterKeys.orderby : "name asc"
            
        ]
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getTherapyDogFacility(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let apiData = response.value {
                    self.therapyDogFacility = apiData
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
    
    fileprivate func getAdhocHourEvent(){
        let params : [String:Any] = [
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_engagementopportunityid",
            ParameterKeys.filter : "(Microsoft.Dynamics.CRM.In(PropertyName='statuscode',PropertyValues=['1','802280000']) and sjavms_adhocevent eq true and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002'])) and (msnfp_msnfp_engagementopportunity_msnfp_participation_engagementOpportunityId/any(o1:(o1/_msnfp_contactid_value eq \(self.conId) and o1/msnfp_status eq 844060002)))",
            
        ]
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getAdhocHourVolunteerEevnt(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let apiData = response.value {
                    self.adhocHourEvent = apiData
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
    
    fileprivate func getnonAdhocHourEvent(){
        
        
        
        let groupList =   ProcessUtils.shared.groupListValue ?? ""
        let params : [String:Any] = [
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_engagementopportunitystatus,msnfp_needsreviewedparticipants,msnfp_minimum,msnfp_maximum,_sjavms_group_value,msnfp_endingdate,msnfp_cancelledparticipants,msnfp_appliedparticipants,msnfp_startingdate,msnfp_engagementopportunityid",
            ParameterKeys.filter : "(Microsoft.Dynamics.CRM.In(PropertyName='statuscode',PropertyValues=['802280000','1']) and sjavms_adhocevent eq true and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002'])) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(groupList)]))))",
            ParameterKeys.orderby : "msnfp_engagementopportunitytitle asc"
            
        ]
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getNonAdhocHourVolunteerEevnt(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let apiData = response.value {
                    self.nonAdhocHourEvent = apiData
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
    
    
    func postVolunteerAdhocHour() {
        
        let params : PostAdhocHourEvent = PostAdhocHourEvent(
            sjavms_VolunteerId: "/contacts\(self.conId))",
            sjavms_hoursreported: Float(self.txtHourNumbers.text ?? ""),
            sjavms_therapydoghours: self.isTherapyDogSelected,
            sjavms_therapydog_volunteeringevent: "/msnfp_engagementopportunities(\(self.adhocHourEventSelectedModel?.msnfp_engagementopportunityid ?? ""))" ,
            sjavms_VMSTherapyDogId : "/sjavms_vmstherapydogs(\(self.therapyDogIDSelectedModel?.sjavms_vmstherapydogid ?? "")",
            sjavms_TherapyDogFacilityId : "/accounts(\(self.therapyDogFacilitySelectedModed?.accountid ?? ""))",
            sjavms_therapydogdateworked : self.date)
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        ENTALDLibraryAPI.shared.createAdhocHour(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success:
                self.callbackToController?(1, self)
                self.navigationController?.popViewController(animated: true)
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
    
    
    func postVolunteerNonAdhocHour() {
        
        let params : PostNonAdhocHourEvent = PostNonAdhocHourEvent(
            sjavms_VolunteerIdData: "/contacts\(self.conId))",
            sjavms_VolunteeringEventIdData: "/msnfp_engagementopportunities(\(self.nonAdhocHourEventSelectedModel?.msnfp_engagementopportunityid ?? ""))",
            sjavms_hoursreported: Float(self.txtHourNumbers.text ?? ""),
            sjavms_therapydoghours: self.isTherapyDogSelected)
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        ENTALDLibraryAPI.shared.createNonAdhocHour(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success:
                self.callbackToController?(1, self)
                self.navigationController?.popViewController(animated: true)
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
    
    
    
    
    
    
    
    
    
    
    
    
    
}
