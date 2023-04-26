//
//  NewGeneralFormVC.swift
//  StJhonsAmbulance
//
//  Created by Ali on 06/03/2023.
//

import UIKit

class GeneralInfoFormVC: ENTALDBaseViewController {
    
    @IBOutlet weak var generalInfoFormHeaderLbl: UILabel!
    @IBOutlet weak var appInfoSecTitleLbl: UIView!
    @IBOutlet weak var provinceLbl: UILabel!
    @IBOutlet weak var branchLbl: UILabel!
    @IBOutlet weak var typeOfServiceLbl: UILabel!
    @IBOutlet weak var eventOrganizerSecTitleLbl: UILabel!
    @IBOutlet weak var contactFirstNameLbl: UILabel!
    @IBOutlet weak var contactLastNameLbl: UILabel!
    @IBOutlet weak var eventNameLbl: UILabel!
    @IBOutlet weak var organizerNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var primaryPhoneLbl: UILabel!
    @IBOutlet weak var eventLocationAddressSecTitleLbl: UILabel!
    @IBOutlet weak var eventLocationNameLbl: UILabel!
    @IBOutlet weak var street1Lbl: UILabel!
    @IBOutlet weak var street2Lbl: UILabel!
    @IBOutlet weak var street3Lbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var provinceTextLbl: UILabel!
    @IBOutlet weak var postalCodeLbl: UILabel!

    @IBOutlet weak var contactFirstNameTF: UITextField!
    @IBOutlet weak var contactLastNameTF: UITextField!
    @IBOutlet weak var eventNameTF: UITextField!
    @IBOutlet weak var organizerNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var primaryPhoneTF: UITextField!
    @IBOutlet weak var eventLocationNameTF: UITextField!
    @IBOutlet weak var street1TF: UITextField!
    @IBOutlet weak var street2TF: UITextField!
    @IBOutlet weak var street3TF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var provinceTF: UITextField!
    @IBOutlet weak var postalCodeTF: UITextField!

    @IBOutlet weak var provinceBtn: UIButton!
    @IBOutlet weak var branchBtn: UIButton!
    @IBOutlet weak var typeOfServiceBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var delegate : CreateEventSegmentDelegate?
    
    var programData : [EventProgramDataModel]?
    var branchData : [EventBranchModel]?
    var councilData : [EventCouncilModel]?
    
    
    var selectedProgramData : EventProgramDataModel?
    var selectedBranchData : EventBranchModel?
    var selectedCouncilData : EventCouncilModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getEventProgram()
        self.getEventBranch()
        self.getEventCouncil()
    }
    
    
    // ========================== API =========================
    
    fileprivate func getEventProgram(){
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupId() else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "sjavms_Program",
            ParameterKeys.expand : "sjavms_Program($select=sjavms_name)",
            ParameterKeys.filter : "(msnfp_groupid eq \(groupId)) and (sjavms_Program/sjavms_programid ne null) and (sjavms_Branch/sjavms_branchid ne null)",
//            ParameterKeys.orderby : "msnfp_engagementopportunityschedule asc"
        ]

        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestEventPrograme(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let programData = response.value {
                    self.programData = programData
    
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
    
    
    
    fileprivate func getEventBranch(){

        let params : [String:Any] = [
            
            ParameterKeys.select : "sjavms_name,_sjavms_council_value",
            
        ]

        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestEventBranch(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let branchData = response.value {
                    self.branchData = branchData
    
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
    
    fileprivate func getEventCouncil(){

        let params : [String:Any] = [
            
            ParameterKeys.select : "sjavms_name",
            
        ]

        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestEventCouncil(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let councilData = response.value {
                    self.councilData = councilData
    
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
    
    

    @IBAction func provinceBtnPRessed(_ sender: UIButton) {
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.eventProvince, dataObj: self.programData) { params, controller in
            
            if let data = params as? EventProgramDataModel {
                self.provinceBtn.setTitle("\(data.sjavms_Program?.sjavms_name ?? "")", for: .normal)
                self.selectedProgramData = data
            }
        }
    }
    @IBAction func branchBtnPressed(_ sender: UIButton) {
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.eventBranch, dataObj: self.branchData) { params, controller in
            
            if let data = params as? EventBranchModel {
                self.branchBtn.setTitle("\(data.sjavms_name ?? "")", for: .normal)
                self.selectedBranchData = data
            }
        }
    }
    @IBAction func typeOfServiceBtnPressed(_ sender: UIButton) {
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.eventCouncil, dataObj: self.councilData) { params, controller in
            
            if let data = params as? EventCouncilModel {
                self.typeOfServiceBtn.setTitle("\(data.sjavms_name ?? "")", for: .normal)
                self.selectedCouncilData = data
            }
        }
    }
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        self.delegate?.onPressNext(params: self.getGeneralFieldsParam(), controller: self)
    }
    
    func getGeneralFieldsParam() -> [String:Any]{
        var params : [String:Any] = [:]
        if let program = self.selectedProgramData, let id = program.sjavms_Program?.sjavms_programid {
            params["[sjavms_program@odata.bind]"] = "/sjavms_program(\(id))"
        }
        
        if let branch = self.selectedBranchData, let id = branch.sjavms_branchid {
            params["[sjavms_branch@odata.bind]"] = "/sjavms_branchs(\(id))"
        }
        
        if let council = self.selectedCouncilData, let id = council.sjavms_branchid {
            params["[sjavms_council@odata.bind]"] = "/sjavms_councils(\(id))"
        }
        
        if let group = ProcessUtils.shared.selectedUserGroup, let id = group.sjavms_groupid?.msnfp_groupid {
            params["[sjavms_group@odata.bind]"] = "/sjavms_group(\(id))"
        }
        
        params["sjavms_firstname"] = self.contactFirstNameTF.text ?? ""
        params["sjavms_lastname"] = self.contactLastNameTF.text ?? ""
        params["sjavms_name"] = self.eventNameTF.text ?? ""
        params["sjavms_organization"] = self.organizerNameTF.text ?? ""
        params["sjavms_email"] = self.emailTF.text ?? ""
        params["sjavms_phone"] = self.primaryPhoneTF.text ?? ""
        
        params["sjavms_address1name"] = self.eventLocationNameTF.text ?? ""
        params["sjavms_address1line1"] = self.street1TF.text ?? ""
        params["sjavms_address1line2"] = self.street2TF.text ?? ""
        params["sjavms_address1line3"] = self.street3TF.text ?? ""
        params["sjavms_address1city"] = self.cityTF.text ?? ""
        params["sjavms_address1stateprovince"] = self.provinceTF.text ?? ""
        params["sjavms_address1zippostalcode"] = self.postalCodeTF.text ?? ""
        
        return params
    }
}
