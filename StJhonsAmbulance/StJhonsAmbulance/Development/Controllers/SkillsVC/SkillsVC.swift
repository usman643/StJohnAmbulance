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
        // Do any additional setup after loading the view.
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
        
        btnWorkingVolunteerPeople.backgroundColor = UIColor.colorGrey72
        btnPatientCare.backgroundColor = UIColor.colorGrey72
        btnPalliativeCare.backgroundColor = UIColor.colorGrey72
        btnCRPFirstAId.backgroundColor = UIColor.colorGrey72
        btnRecreationalProgramming.backgroundColor = UIColor.colorGrey72
        btnEducationalProgramming.backgroundColor = UIColor.colorGrey72
        btnCustomerServices.backgroundColor = UIColor.colorGrey72
        btnComputer.backgroundColor = UIColor.colorGrey72
        btnVoulnteerLeadership.backgroundColor = UIColor.colorGrey72
        btnOtherSkils.backgroundColor = UIColor.colorGrey72
        
        btnSubmit.themeColorButton()
        btnSubmit.backgroundColor = UIColor.lightGray
        btnSubmit.titleLabel?.font = UIFont.BoldFont(16.0)
//        self.btnSubmit.isEnabled = false
        
        
    }

    
    
    
    @IBAction func submitSelected(_ sender: Any) {
        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
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
    }
    
    
}
