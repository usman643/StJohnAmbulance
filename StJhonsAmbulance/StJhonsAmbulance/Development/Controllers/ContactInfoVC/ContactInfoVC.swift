//
//  ContactInfoVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 15/02/2023.
//

import UIKit

class ContactInfoVC: ENTALDBaseViewController {

    var selectedGender : Int?
    var selectedPronoun : Int?
    var selectedContactMethod : Int?
    var selectedOptNotification : Int?
    var selectedOptNotification_value : Bool?
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblPreferredPronoun: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPrimaryPhone: UILabel!
    @IBOutlet weak var lblContactMethod: UILabel!
    @IBOutlet weak var lblEmergencyContact: UILabel!
    @IBOutlet weak var lblEmergencyName: UILabel!
    @IBOutlet weak var lblOptNotification: UILabel!
    @IBOutlet weak var lblStreetOne: UILabel!
    @IBOutlet weak var lblStreetTwo: UILabel!
    @IBOutlet weak var lblStreetThree: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblProvince: UILabel!
    @IBOutlet weak var lblPostalCde: UILabel!
    
    @IBOutlet weak var txtFirstName: ACFloatingTextfield!
    @IBOutlet weak var txtLastName: ACFloatingTextfield!
    @IBOutlet weak var txtBirthday: ACFloatingTextfield!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtPrimaryPhone: ACFloatingTextfield!
    @IBOutlet weak var txtStreetOne: ACFloatingTextfield!
    @IBOutlet weak var txtStreetTwo: ACFloatingTextfield!
    @IBOutlet weak var txtStreetThree: ACFloatingTextfield!
    @IBOutlet weak var txtCity: ACFloatingTextfield!
    @IBOutlet weak var txtProvince: ACFloatingTextfield!
    @IBOutlet weak var txtPostalCode: ACFloatingTextfield!
    @IBOutlet weak var txtEmergencyContactName: ACFloatingTextfield!
    @IBOutlet weak var txtEmergencyContactPhone: ACFloatingTextfield!
    
    @IBOutlet weak var btnPrefferenNoun: UIButton!
    @IBOutlet weak var btnGender: UIButton!
    @IBOutlet weak var btnContactMethod: UIButton!
    @IBOutlet weak var btnOptNotofocation: UIButton!
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        deocorateUI()
        setupData()
    }

    func deocorateUI(){
        
        lblTitle.textColor = UIColor.themePrimaryWhite
        lblTitle.font = UIFont.BoldFont(16)
        lblFirstName.textColor = UIColor.themePrimaryWhite
        lblFirstName.font = UIFont.BoldFont(12)
        lblLastName.textColor = UIColor.themePrimaryWhite
        lblLastName.font = UIFont.BoldFont(12)
        lblPreferredPronoun.textColor = UIColor.themePrimaryWhite
        lblPreferredPronoun.font = UIFont.BoldFont(12)
        lblGender.textColor = UIColor.themePrimaryWhite
        lblGender.font = UIFont.BoldFont(12)
        lblBirthday.textColor = UIColor.themePrimaryWhite
        lblBirthday.font = UIFont.BoldFont(12)
        lblEmail.textColor = UIColor.themePrimaryWhite
        lblEmail.font = UIFont.BoldFont(12)
        lblPrimaryPhone.textColor = UIColor.themePrimaryWhite
        lblPrimaryPhone.font = UIFont.BoldFont(12)
        lblContactMethod.textColor = UIColor.themePrimaryWhite
        lblContactMethod.font = UIFont.BoldFont(12)
        lblEmergencyContact.textColor = UIColor.themePrimaryWhite
        lblEmergencyContact.font = UIFont.BoldFont(12)
        lblEmergencyName.textColor = UIColor.themePrimaryWhite
        lblEmergencyName.font = UIFont.BoldFont(12)
        lblOptNotification.textColor = UIColor.themePrimaryWhite
        lblOptNotification.font = UIFont.BoldFont(12)
        lblStreetOne.textColor = UIColor.themePrimaryWhite
        lblStreetOne.font = UIFont.BoldFont(12)
        lblStreetTwo.textColor = UIColor.themePrimaryWhite
        lblStreetTwo.font = UIFont.BoldFont(12)
        lblStreetThree.textColor = UIColor.themePrimaryWhite
        lblStreetThree.font = UIFont.BoldFont(12)
        lblCity.textColor = UIColor.themePrimaryWhite
        lblCity.font = UIFont.BoldFont(12)
        lblProvince.textColor = UIColor.themePrimaryWhite
        lblProvince.font = UIFont.BoldFont(12)
        lblPostalCde.textColor = UIColor.themePrimaryWhite
        lblPostalCde.font = UIFont.BoldFont(12)
        
        txtFirstName.font = UIFont.RegularFont(14)
        txtFirstName.layer.borderWidth = 1
        txtFirstName.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtLastName.font = UIFont.RegularFont(14)
        txtLastName.layer.borderWidth = 1
        txtLastName.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtBirthday.font = UIFont.RegularFont(14)
        txtBirthday.layer.borderWidth = 1
        txtBirthday.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtEmail.font = UIFont.RegularFont(14)
        txtEmail.layer.borderWidth = 1
        txtEmail.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtPrimaryPhone.font = UIFont.RegularFont(14)
        txtPrimaryPhone.layer.borderWidth = 1
        txtPrimaryPhone.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtStreetOne.font = UIFont.RegularFont(14)
        txtStreetOne.layer.borderWidth = 1
        txtStreetOne.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtStreetTwo.font = UIFont.RegularFont(14)
        txtStreetTwo.layer.borderWidth = 1
        txtStreetTwo.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtStreetThree.font = UIFont.RegularFont(14)
        txtStreetThree.layer.borderWidth = 1
        txtStreetThree.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtCity.font = UIFont.RegularFont(14)
        txtCity.layer.borderWidth = 1
        txtCity.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtProvince.font = UIFont.RegularFont(14)
        txtProvince.layer.borderWidth = 1
        txtProvince.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtPostalCode.font = UIFont.RegularFont(14)
        txtPostalCode.layer.borderWidth = 1
        txtPostalCode.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtEmergencyContactName.font = UIFont.RegularFont(14)
        txtEmergencyContactName.layer.borderWidth = 1
        txtEmergencyContactName.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtEmergencyContactPhone.font = UIFont.RegularFont(14)
        txtEmergencyContactPhone.layer.borderWidth = 1
        txtEmergencyContactPhone.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        btnPrefferenNoun.backgroundColor = UIColor.themePrimaryWhite
        btnPrefferenNoun.titleLabel?.font = UIFont.BoldFont(14)
        btnPrefferenNoun.layer.cornerRadius = 2
        btnPrefferenNoun.setTitleColor(UIColor.themePrimary, for: .normal)
        btnGender.backgroundColor = UIColor.themePrimaryWhite
        btnGender.titleLabel?.font = UIFont.BoldFont(14)
        btnGender.layer.cornerRadius = 2
        btnGender.setTitleColor(UIColor.themePrimary, for: .normal)
        btnContactMethod.backgroundColor = UIColor.themePrimaryWhite
        btnContactMethod.titleLabel?.font = UIFont.BoldFont(14)
        btnContactMethod.layer.cornerRadius = 2
        btnContactMethod.setTitleColor(UIColor.themePrimary, for: .normal)
        btnOptNotofocation.backgroundColor = UIColor.themePrimaryWhite
        btnOptNotofocation.titleLabel?.font = UIFont.BoldFont(14)
        btnOptNotofocation.layer.cornerRadius = 2
        btnOptNotofocation.setTitleColor(UIColor.themePrimary, for: .normal)
        
        btnSubmit.themeColorButton()
        btnSubmit.backgroundColor = UIColor.lightGray
        btnSubmit.titleLabel?.font = UIFont.BoldFont(16.0)
        self.btnSubmit.isEnabled = false
        
        profileImg.layer.cornerRadius = profileImg.frame.size.height/2
        
        txtFirstName.isUserInteractionEnabled = false
        txtLastName.isUserInteractionEnabled = false
        txtBirthday.isUserInteractionEnabled = false
        txtEmail.isUserInteractionEnabled = false
        txtPrimaryPhone.isUserInteractionEnabled = false
        txtStreetOne.isUserInteractionEnabled = false
        txtStreetTwo.isUserInteractionEnabled = false
        txtStreetThree.isUserInteractionEnabled = false
        txtCity.isUserInteractionEnabled = false
        txtProvince.isUserInteractionEnabled = false
        txtPostalCode.isUserInteractionEnabled = false
        txtEmergencyContactName.isUserInteractionEnabled = false
        txtEmergencyContactPhone.isUserInteractionEnabled = false
        
    }
    
    func setupData(){
        
        profileImg.image = ProcessUtils.shared.convertBase64StringToImage(imageBase64String: UserDefaults.standard.userInfo?.entityimage ?? "")
        txtFirstName.text = UserDefaults.standard.userInfo?.firstname ?? ""
        txtLastName.text = UserDefaults.standard.userInfo?.lastname ?? ""
        txtBirthday.text = UserDefaults.standard.userInfo?.birthdate ?? ""
        txtEmail.text = UserDefaults.standard.userInfo?.emailaddress1 ?? ""
        txtPrimaryPhone.text = UserDefaults.standard.userInfo?.address1_telephone1 ?? ""
        txtStreetOne.text = UserDefaults.standard.userInfo?.address1_line1 ?? ""
        txtStreetTwo.text = UserDefaults.standard.userInfo?.address1_line2 ?? ""
        txtStreetThree.text = UserDefaults.standard.userInfo?.address1_line3 ?? ""
        txtCity.text = UserDefaults.standard.userInfo?.address1_city ?? ""
        txtProvince.text = UserDefaults.standard.userInfo?.address1_stateorprovince ?? ""
        txtPostalCode.text = UserDefaults.standard.userInfo?.address1_postalcode ?? ""
        txtEmergencyContactName.text = UserDefaults.standard.userInfo?.sjavms_emergencycontactname ?? ""
        txtEmergencyContactPhone.text = UserDefaults.standard.userInfo?.sjavms_emergencycontactphone ?? ""
        
        let gender = self.getGender(UserDefaults.standard.userInfo?.gendercode ?? 0)
        let noun = self.getPreferedNoun(UserDefaults.standard.userInfo?.sjavms_preferredpronouns ?? 0)
        let contactMethod = self.getPreferedContactMethod(UserDefaults.standard.userInfo?.preferredcontactmethodcode ?? 0)
        
        btnPrefferenNoun.setTitle(noun , for: .normal)
        btnGender.setTitle(gender, for: .normal)
        btnContactMethod.setTitle(contactMethod, for: .normal)
        if (UserDefaults.standard.userInfo?.sjavms_optoutofnotifications == true) {
            btnOptNotofocation.setTitle("ON", for: .normal)
        }else{
            btnOptNotofocation.setTitle("OFF", for: .normal)
        }
        

    }
    
    
    
    @IBAction func selectGenderTapped(_ sender: Any) {
//        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: { status in })
    }
    
    @IBAction func selectPronounTapped(_ sender: Any) {
//        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: { status in })
    }
    
    @IBAction func optNotificationTapped(_ sender: Any) {
//        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: { status in })
    }
    
    @IBAction func preferredMethodTapped(_ sender: Any) {
//        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: { status in })
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func submitTapped(_ sender: Any) {
        
        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: { status in })
    }
    
    
    
    func getGender(_ preferedLanguage:Int)->String?{
        let language = ProcessUtils.shared.genderData?.filter({$0.attributevalue == preferedLanguage}).first?.value
        return language ?? ""
    }
    
    func getPreferedNoun(_ preferedNoun:Int)->String?{
        let noun = ProcessUtils.shared.prefferedPronounData?.filter({$0.attributevalue == preferedNoun}).first?.value
        return noun ?? ""
    }
    
    func getPreferedContactMethod(_ prefferedContactId:Int)->String?{
        let contactMethod = ProcessUtils.shared.prefferedMethodContactData?.filter({$0.attributevalue == prefferedContactId}).first?.value
        return contactMethod ?? ""
    }
    
    func updateUserInfo(){
        
    
        
//        var params:[String:Any] = [
//            "firstname" : txtFirstName.text ?? "",
//            "lastname" : txtLastName.text ?? "",
//            "birthdate" : txtBirthday.text ?? "",
//            "emailaddress1" : txtEmail.text ?? "",
//            "address1_telephone1" : txtPrimaryPhone.text ?? "",
//            "address1_line1" : txtStreetOne.text ?? "",
//            "address1_line2" : txtStreetTwo.text ?? "",
//            "address1_line3" : txtStreetThree.text ?? "",
//            "address1_city" : txtCity.text ?? "",
//            "address1_stateorprovince" : txtProvince.text ?? "",
//            "address1_postalcode" : txtPostalCode.text ?? "",
//            "sjavms_emergencycontactname" : txtEmergencyContactName.text ?? "",
//            "sjavms_emergencycontactphone" : txtEmergencyContactPhone.text ?? ""
//        ]
//        
//        if (selectedGender != nil){
//            params.ns.addEntries(from: ["gendercode" : selectedGender])
//        }
//        if (selectedPronoun != nil){
//            params.ns.addEntries(from: ["sjavms_preferredpronouns" : selectedPronoun])
//        }
//        if (selectedContactMethod != nil){
//            params.ns.addEntries(from: ["preferredcontactmethodcode" : selectedContactMethod])
//        }
//        
//        if (selectedOptNotification != nil){
//            params.ns.addEntries(from: ["sjavms_optoutofnotifications" : selectedOptNotification_value])
//        }
//        
//    
    }
    
    
    
    
}
