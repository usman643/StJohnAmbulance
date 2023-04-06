//
//  SkillsVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 16/02/2023.
//

import UIKit

class SkillsVC: ENTALDBaseViewController {
    
    var isWorkingVolunteerPeople = false
    var isPatientCare = false
    var isPalliativeCare = false
    var isCRPFirstAId = false
    var isRecreationalProgramming = false
    var isEducationalProgramming = false
    var isCustomerServices = false
    var isComputer = false
    var isVoulnteerLeadership = false
    var isOtherSkils = false
    var otherSkillsExplain = ""
    var edited = false
    let userInfo = UserDefaults.standard.userInfo
    let contactId = UserDefaults.standard.contactIdToken ?? ""
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    
    @IBOutlet weak var lblworkingVolunteerPe0ple: UILabel!
    @IBOutlet weak var lblPatientCare: UILabel!
    @IBOutlet weak var lblPalliativeCare: UILabel!
    @IBOutlet weak var lblCRPFirstAId: UILabel!
    @IBOutlet weak var lblRecreationalProgramming: UILabel!
    @IBOutlet weak var lblEducationalProgramming: UILabel!
    @IBOutlet weak var lblCustomerServices: UILabel!
    @IBOutlet weak var lblComputer: UILabel!
    @IBOutlet weak var lblVoulnteerLeadership: UILabel!
    @IBOutlet weak var lblOtherSkils: UILabel!
    @IBOutlet weak var lblExplainOtherSkill: UILabel!
    
    
    @IBOutlet weak var btnWorkingVolunteerPeople: UIButton!
    @IBOutlet weak var btnPatientCare: UIButton!
    @IBOutlet weak var btnPalliativeCare: UIButton!
    @IBOutlet weak var btnCRPFirstAId: UIButton!
    @IBOutlet weak var btnRecreationalProgramming: UIButton!
    @IBOutlet weak var btnEducationalProgramming: UIButton!
    @IBOutlet weak var btnCustomerServices: UIButton!
    @IBOutlet weak var btnComputer: UIButton!
    @IBOutlet weak var btnVoulnteerLeadership: UIButton!
    @IBOutlet weak var btnOtherSkils: UIButton!
    
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
       setupData()
    }


    func decorateUI(){
        lblworkingVolunteerPe0ple.textColor = UIColor.themeBlackText
        lblPatientCare.textColor = UIColor.themeBlackText
        lblPalliativeCare.textColor = UIColor.themeBlackText
        lblCRPFirstAId.textColor = UIColor.themeBlackText
        lblRecreationalProgramming.textColor = UIColor.themeBlackText
        lblEducationalProgramming.textColor = UIColor.themeBlackText
        lblCustomerServices.textColor = UIColor.themeBlackText
        lblComputer.textColor = UIColor.themeBlackText
        lblVoulnteerLeadership.textColor = UIColor.themeBlackText
        lblOtherSkils.textColor = UIColor.themeBlackText
        lblExplainOtherSkill.textColor = UIColor.themeBlackText
        
        lblworkingVolunteerPe0ple.font = UIFont.BoldFont(14)
        lblPatientCare.font = UIFont.BoldFont(14)
        lblPalliativeCare.font = UIFont.BoldFont(14)
        lblCRPFirstAId.font = UIFont.BoldFont(14)
        lblRecreationalProgramming.font = UIFont.BoldFont(14)
        lblEducationalProgramming.font = UIFont.BoldFont(14)
        lblCustomerServices.font = UIFont.BoldFont(14)
        lblComputer.font = UIFont.BoldFont(14)
        lblVoulnteerLeadership.font = UIFont.BoldFont(14)
        lblOtherSkils.font = UIFont.BoldFont(14)
        lblExplainOtherSkill.font = UIFont.BoldFont(12)
        
        btnWorkingVolunteerPeople.layer.cornerRadius = 3
        btnPatientCare.layer.cornerRadius = 3
        btnPalliativeCare.layer.cornerRadius = 3
        btnCRPFirstAId.layer.cornerRadius = 3
        btnRecreationalProgramming.layer.cornerRadius = 3
        btnEducationalProgramming.layer.cornerRadius = 3
        btnCustomerServices.layer.cornerRadius = 3
        btnComputer.layer.cornerRadius = 3
        btnVoulnteerLeadership.layer.cornerRadius = 3
        btnOtherSkils.layer.cornerRadius = 3
        
        btnWorkingVolunteerPeople.backgroundColor = UIColor.viewLightGrayColor
        btnPatientCare.backgroundColor = UIColor.viewLightGrayColor
        btnPalliativeCare.backgroundColor = UIColor.viewLightGrayColor
        btnCRPFirstAId.backgroundColor = UIColor.viewLightGrayColor
        btnRecreationalProgramming.backgroundColor = UIColor.viewLightGrayColor
        btnEducationalProgramming.backgroundColor = UIColor.viewLightGrayColor
        btnCustomerServices.backgroundColor = UIColor.viewLightGrayColor
        btnComputer.backgroundColor = UIColor.viewLightGrayColor
        btnVoulnteerLeadership.backgroundColor = UIColor.viewLightGrayColor
        btnOtherSkils.backgroundColor = UIColor.viewLightGrayColor
        
        btnSubmit.themeColorButton()
//        btnSubmit.backgroundColor = UIColor.lightGray
        btnSubmit.titleLabel?.font = UIFont.BoldFont(16.0)
//        self.btnSubmit.isEnabled = false
        
        
    }

    func setupData(){
        
        
        if (userInfo?.sjavms_workingwvulnerablepeople == true) {
            btnWorkingVolunteerPeople.setImage(UIImage(named: "ic_check"), for: .normal)
            btnWorkingVolunteerPeople.backgroundColor = UIColor.clear
            isWorkingVolunteerPeople = true
        }else{
            btnWorkingVolunteerPeople.setImage(UIImage(named: ""), for: .normal)
            btnWorkingVolunteerPeople.backgroundColor = UIColor.viewLightGrayColor
            isWorkingVolunteerPeople = false
        }
        
        if (userInfo?.sjavms_patientcare == true) {
            btnPatientCare.setImage(UIImage(named: "ic_check"), for: .normal)
            btnPatientCare.backgroundColor = UIColor.clear
            isPatientCare = true
        }else{
            btnPatientCare.setImage(UIImage(named: ""), for: .normal)
            btnPatientCare.backgroundColor = UIColor.viewLightGrayColor
            isPatientCare = false
        }
        
        if (userInfo?.sjavms_palliativecare == true) {
            btnPalliativeCare.setImage(UIImage(named: "ic_check"), for: .normal)
            btnPalliativeCare.backgroundColor = UIColor.clear
            isPalliativeCare = true
        }else{
            btnPalliativeCare.setImage(UIImage(named: ""), for: .normal)
            btnPalliativeCare.backgroundColor = UIColor.viewLightGrayColor
            isPalliativeCare = false
        }
        
        if (userInfo?.sjavms_cprorfirstaid == true) {
            btnCRPFirstAId.setImage(UIImage(named: "ic_check"), for: .normal)
            btnCRPFirstAId.backgroundColor = UIColor.clear
            isCRPFirstAId = true
        }else{
            btnCRPFirstAId.setImage(UIImage(named: ""), for: .normal)
            btnCRPFirstAId.backgroundColor = UIColor.viewLightGrayColor
            isCRPFirstAId = false
        }
        
        if (userInfo?.sjavms_recreationalprogramming == true) {
            btnRecreationalProgramming.setImage(UIImage(named: "ic_check"), for: .normal)
            btnRecreationalProgramming.backgroundColor = UIColor.clear
            isRecreationalProgramming = true
        }else{
            btnRecreationalProgramming.setImage(UIImage(named: ""), for: .normal)
            btnRecreationalProgramming.backgroundColor = UIColor.viewLightGrayColor
            isRecreationalProgramming = false
        }
        
        if (userInfo?.sjavms_customerservice == true) {
            btnCustomerServices.setImage(UIImage(named: "ic_check"), for: .normal)
            btnCustomerServices.backgroundColor = UIColor.clear
            isCustomerServices = true
        }else{
            btnCustomerServices.setImage(UIImage(named: ""), for: .normal)
            btnCustomerServices.backgroundColor = UIColor.viewLightGrayColor
            isCustomerServices = true
        }
        
        if (userInfo?.sjavms_educationalprogramming == true) {
            btnEducationalProgramming.setImage(UIImage(named: "ic_check"), for: .normal)
            btnEducationalProgramming.backgroundColor = UIColor.clear
            isEducationalProgramming = true
        }else{
            btnEducationalProgramming.setImage(UIImage(named: ""), for: .normal)
            btnEducationalProgramming.backgroundColor = UIColor.viewLightGrayColor
            isEducationalProgramming = false
        }
        
        if (userInfo?.sjavms_computer == true) {
            btnComputer.setImage(UIImage(named: "ic_check"), for: .normal)
            btnComputer.backgroundColor = UIColor.clear
            isComputer = true
        }else{
            btnComputer.setImage(UIImage(named: ""), for: .normal)
            btnComputer.backgroundColor = UIColor.viewLightGrayColor
            isComputer = false
        }
        
        if (userInfo?.sjavms_volunteerleadership == true) {
            btnVoulnteerLeadership.setImage(UIImage(named: "ic_check"), for: .normal)
            btnVoulnteerLeadership.backgroundColor = UIColor.clear
            isVoulnteerLeadership = true
        }else{
            btnVoulnteerLeadership.setImage(UIImage(named: ""), for: .normal)
            btnVoulnteerLeadership.backgroundColor = UIColor.viewLightGrayColor
            isVoulnteerLeadership = false
        }
        
        if (userInfo?.sjavms_otherskills == true) {
            btnOtherSkils.setImage(UIImage(named: "ic_check"), for: .normal)
            btnOtherSkils.backgroundColor = UIColor.clear
            isOtherSkils = true
        }else{
            btnOtherSkils.setImage(UIImage(named: ""), for: .normal)
            btnOtherSkils.backgroundColor = UIColor.viewLightGrayColor
            isOtherSkils = false
        }
        
        if (userInfo?.sjavms_explainskillother != nil) {
            textView.text = userInfo?.sjavms_explainskillother ?? ""
        }else{
            textView.text = ""
        }
        
        
        
        
    }
    
    
    @IBAction func submitSelected(_ sender: Any) {
        self.updateSkills()
//        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func workingVolunteerPepleTapped(_ sender: Any) {
            if (isWorkingVolunteerPeople){
                btnWorkingVolunteerPeople.setImage(UIImage(named: ""), for: .normal)
                btnWorkingVolunteerPeople.backgroundColor = UIColor.viewLightGrayColor
                isWorkingVolunteerPeople = false
            }else{
                btnWorkingVolunteerPeople.setImage(UIImage(named: "ic_check"), for: .normal)
                btnWorkingVolunteerPeople.backgroundColor = UIColor.clear
                isWorkingVolunteerPeople = true
            }
        edited = true
    }
    
    @IBAction func patientCareTapped(_ sender: Any) {
        if (isPatientCare){
            btnPatientCare.setImage(UIImage(named: ""), for: .normal)
            btnPatientCare.backgroundColor = UIColor.viewLightGrayColor
            isPatientCare = false
        }else{
            btnPatientCare.setImage(UIImage(named: "ic_check"), for: .normal)
            btnPatientCare.backgroundColor = UIColor.clear
            isPatientCare = true
        }
        edited = true
    }
    
    @IBAction func PalliativeCareSelected(_ sender: Any) {
        if (isPalliativeCare){
            btnPalliativeCare.setImage(UIImage(named: ""), for: .normal)
            btnPalliativeCare.backgroundColor = UIColor.viewLightGrayColor
            isPalliativeCare = false
        }else{
            btnPalliativeCare.setImage(UIImage(named: "ic_check"), for: .normal)
            btnPalliativeCare.backgroundColor = UIColor.clear
            isPalliativeCare = true
        }
        edited = true
    }
    
    @IBAction func CRPFirstAIdSelected(_ sender: Any) {
        if (isCRPFirstAId){
            btnCRPFirstAId.setImage(UIImage(named: ""), for: .normal)
            btnCRPFirstAId.backgroundColor = UIColor.viewLightGrayColor
            isCRPFirstAId = false
        }else{
            btnCRPFirstAId.setImage(UIImage(named: "ic_check"), for: .normal)
            btnCRPFirstAId.backgroundColor = UIColor.clear
            isCRPFirstAId = true
        }
        edited = true
    }
    
    @IBAction func RecreationalProgrammingSelected(_ sender: Any) {
        if (isRecreationalProgramming){
            btnRecreationalProgramming.setImage(UIImage(named: ""), for: .normal)
            btnRecreationalProgramming.backgroundColor = UIColor.viewLightGrayColor
            isRecreationalProgramming = false
        }else{
            btnRecreationalProgramming.setImage(UIImage(named: "ic_check"), for: .normal)
            btnRecreationalProgramming.backgroundColor = UIColor.clear
            isRecreationalProgramming = true
        }
        edited = true
    }
    
    @IBAction func ComputerServiceSelected(_ sender: Any) {
        if (isCustomerServices){
            btnCustomerServices.setImage(UIImage(named: ""), for: .normal)
            btnCustomerServices.backgroundColor = UIColor.viewLightGrayColor
            isCustomerServices = false
        }else{
            btnCustomerServices.setImage(UIImage(named: "ic_check"), for: .normal)
            btnCustomerServices.backgroundColor = UIColor.clear
            isCustomerServices = true
        }
        edited = true
    }
    
    @IBAction func computerProgrammingSelected(_ sender: Any) {
        if (isEducationalProgramming){
            btnEducationalProgramming.setImage(UIImage(named: ""), for: .normal)
            btnEducationalProgramming.backgroundColor = UIColor.viewLightGrayColor
            isEducationalProgramming = false
        }else{
            btnEducationalProgramming.setImage(UIImage(named: "ic_check"), for: .normal)
            btnEducationalProgramming.backgroundColor = UIColor.clear
            isEducationalProgramming = true
        }
        edited = true
    }
    
    @IBAction func computerSelected(_ sender: Any) {
        if (isComputer){
            btnComputer.setImage(UIImage(named: ""), for: .normal)
            btnComputer.backgroundColor = UIColor.viewLightGrayColor
            isComputer = false
        }else{
            btnComputer.setImage(UIImage(named: "ic_check"), for: .normal)
            btnComputer.backgroundColor = UIColor.clear
            isComputer = true
        }
        edited = true
    }
    
    @IBAction func voulnteerLeadershipSelected(_ sender: Any) {
        if (isVoulnteerLeadership){
            btnVoulnteerLeadership.setImage(UIImage(named: ""), for: .normal)
            btnVoulnteerLeadership.backgroundColor = UIColor.viewLightGrayColor
            isVoulnteerLeadership = false
        }else{
            btnVoulnteerLeadership.setImage(UIImage(named: "ic_check"), for: .normal)
            btnVoulnteerLeadership.backgroundColor = UIColor.clear
            isVoulnteerLeadership = true
        }
        edited = true
    }
    
    @IBAction func OtherSkilsSelected(_ sender: Any) {
        if (isOtherSkils){
            btnOtherSkils.setImage(UIImage(named: ""), for: .normal)
            btnOtherSkils.backgroundColor = UIColor.viewLightGrayColor
            isOtherSkils = false
            textView.isEditable = false
        }else{
            btnOtherSkils.setImage(UIImage(named: "ic_check"), for: .normal)
            btnOtherSkils.backgroundColor = UIColor.clear
            isOtherSkils = true
            textView.isEditable = true
        }
        edited = true
    }
    
    
    func updateSkills() {
        
        if UserDefaults.standard.userInfo?.sjavms_explainskillother != lblExplainOtherSkill.text{
            edited = true
            otherSkillsExplain = lblExplainOtherSkill.text ?? ""
        }
        
        if edited == true {
            
            self.updatedata(params: [
                "sjavms_workingwvulnerablepeople":isWorkingVolunteerPeople as! Bool,
                "sjavms_patientcare":isPatientCare as! Bool,
                "sjavms_palliativecare":isPalliativeCare as! Bool,
                "sjavms_cprorfirstaid":isCRPFirstAId as! Bool ,
                "sjavms_recreationalprogramming":isRecreationalProgramming as! Bool ,
                "sjavms_educationalprogramming":isEducationalProgramming as! Bool ,
                "sjavms_customerservice":isCustomerServices as! Bool ,
                "sjavms_computer":isComputer as! Bool ,
                "sjavms_volunteerleadership":isVoulnteerLeadership as! Bool ,
                "sjavms_otherskills":isOtherSkils as! Bool,
                "sjavms_explainskillother" : textView.text ?? ""
            ])
            
            
            UserDefaults.standard.userInfo?.sjavms_workingwvulnerablepeople = isWorkingVolunteerPeople
            UserDefaults.standard.userInfo?.sjavms_patientcare = isPatientCare
            UserDefaults.standard.userInfo?.sjavms_palliativecare = isPalliativeCare
            UserDefaults.standard.userInfo?.sjavms_cprorfirstaid = isCRPFirstAId
            UserDefaults.standard.userInfo?.sjavms_recreationalprogramming = isRecreationalProgramming
            UserDefaults.standard.userInfo?.sjavms_customerservice =  isCustomerServices
            UserDefaults.standard.userInfo?.sjavms_educationalprogramming = isEducationalProgramming
            UserDefaults.standard.userInfo?.sjavms_computer = isComputer
            UserDefaults.standard.userInfo?.sjavms_volunteerleadership = isVoulnteerLeadership
            UserDefaults.standard.userInfo?.sjavms_otherskills = isOtherSkils
            UserDefaults.standard.userInfo?.sjavms_explainskillother = textView.text ?? ""
            

            DispatchQueue.main.async {
                ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: "User Detail updated Sucessfully", actionTitle: .KOK, completion: {status in })
            }
            
//            if (isWorkingVolunteerPeople != userInfo?.sjavms_workingwvulnerablepeople){
//                self.updatedata(params: ["sjavms_workingwvulnerablepeople":isWorkingVolunteerPeople])
//            }
//
//            if (isPatientCare != userInfo?.sjavms_patientcare){
//                self.updatedata(params: ["sjavms_patientcare":isPatientCare])
//            }
//            if (isPalliativeCare != userInfo?.sjavms_palliativecare){
//                self.updatedata(params: ["sjavms_palliativecare":isPalliativeCare])
//            }
//            if (isCRPFirstAId != userInfo?.sjavms_cprorfirstaid ){
//                self.updatedata(params: ["sjavms_cprorfirstaid":isCRPFirstAId])
//            }
//            if (isRecreationalProgramming != userInfo?.sjavms_recreationalprogramming){
//                self.updatedata(params: ["sjavms_recreationalprogramming":isRecreationalProgramming])
//            }
//            if (isEducationalProgramming != userInfo?.sjavms_educationalprogramming ){
//                self.updatedata(params: ["sjavms_educationalprogramming":isEducationalProgramming])
//            }
//            if (isCustomerServices != userInfo?.sjavms_customerservice ){
//                self.updatedata(params: ["sjavms_customerservice":isCustomerServices])
//            }
//            if (isComputer != userInfo?.sjavms_computer ){
//                self.updatedata(params: ["sjavms_computer":isComputer])
//            }
//            if (isVoulnteerLeadership != userInfo?.sjavms_volunteerleadership){
//                self.updatedata(params: ["sjavms_volunteerleadership":isVoulnteerLeadership])
//            }
//            if (isOtherSkils != userInfo?.sjavms_otherskills){
//                self.updatedata(params: ["sjavms_otherskills":isOtherSkils])
//            }
//            if (otherSkillsExplain != ){
//                self.updatedata(params: [:otherSkillsExplain])
//            }
//            if (edited != false){
//                self.updatedata(params: ["sjavms_explainskillother" : lblExplainOtherSkill.text ?? ""])
//            }
//            self.getUserIdentity(conId: self.contactId)
        }
        
        
    }
    
    fileprivate func updatedata(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
//        let eventId = self.eventData?.msnfp_engagementopportunityid ?? ""
        
        ENTALDLibraryAPI.shared.requestProfileInfoUpdate(conId: contactId, params: params) { result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                if let pastEvent = response.value {

                }else{
//                    self.showEmptyView(tableVw: self.tableView)
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
        DispatchQueue.main.async {
            LoadingView.hide()
        }
    }
    
    func getUserIdentity(conId:String){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestUserIdentity(conId: UserDefaults.standard.contactIdToken ?? "") { result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result {
            case .success(let response):
                UserDefaults.standard.userInfo = response
                self.callbackToController?(nil, self)
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
}
