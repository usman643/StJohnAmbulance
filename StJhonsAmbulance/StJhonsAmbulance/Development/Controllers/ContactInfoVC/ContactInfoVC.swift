//
//  ContactInfoVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 15/02/2023.
//

import UIKit
import MobileCoreServices

class ContactInfoVC: ENTALDBaseViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate,UIScrollViewDelegate {

    var selectedGender : Int?
    var selectedPronoun : Int?
    var selectedContactMethod : Int?
    var selectedOptNotification : String?
    var selectedOptNotification_value : Bool?
    let imagePicker = UIImagePickerController()
    var url : URL?
    var filename :String?
    var imgBase64 : String?
    let contactId = UserDefaults.standard.contactIdToken ?? ""
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    
    @IBOutlet weak var lblYearsOfService: UILabel!
    @IBOutlet weak var lblCurrentYearHours: UILabel!
    @IBOutlet weak var lblLastYearHours: UILabel!
    @IBOutlet weak var lblLifetimeHours: UILabel!
    
    @IBOutlet weak var lblLifeTimeHour: UILabel!
    @IBOutlet weak var lblThisYearHour: UILabel!
    @IBOutlet weak var lblLServiceYears: UILabel!
    @IBOutlet weak var lblLastYearHour: UILabel!
    
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btnMessage: UIButton!
    
    @IBOutlet weak var updateViewBottomCostraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        deocorateUI()
        setupData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func deocorateUI(){
        
        
        
        lblTitle.textColor = UIColor.headerGreen
        lblTitle.font = UIFont.HeaderBoldFont(18)
        lblFirstName.textColor = UIColor.textGrayColor
        lblFirstName.font = UIFont.BoldFont(12)
        lblLastName.textColor = UIColor.textGrayColor
        lblLastName.font = UIFont.BoldFont(12)
        lblPreferredPronoun.textColor = UIColor.textGrayColor
        lblPreferredPronoun.font = UIFont.BoldFont(12)
        lblGender.textColor = UIColor.textGrayColor
        lblGender.font = UIFont.BoldFont(12)
        lblBirthday.textColor = UIColor.textGrayColor
        lblBirthday.font = UIFont.BoldFont(12)
        lblEmail.textColor = UIColor.textGrayColor
        lblEmail.font = UIFont.BoldFont(12)
        lblPrimaryPhone.textColor = UIColor.textGrayColor
        lblPrimaryPhone.font = UIFont.BoldFont(12)
        lblContactMethod.textColor = UIColor.textGrayColor
        lblContactMethod.font = UIFont.BoldFont(12)
        lblEmergencyContact.textColor = UIColor.textGrayColor
        lblEmergencyContact.font = UIFont.BoldFont(12)
        lblEmergencyName.textColor = UIColor.textGrayColor
        lblEmergencyName.font = UIFont.BoldFont(12)
        lblOptNotification.textColor = UIColor.textGrayColor
        lblOptNotification.font = UIFont.BoldFont(12)
        lblStreetOne.textColor = UIColor.textGrayColor
        lblStreetOne.font = UIFont.BoldFont(12)
        lblStreetTwo.textColor = UIColor.textGrayColor
        lblStreetTwo.font = UIFont.BoldFont(12)
        lblStreetThree.textColor = UIColor.textGrayColor
        lblStreetThree.font = UIFont.BoldFont(12)
        lblCity.textColor = UIColor.textGrayColor
        lblCity.font = UIFont.BoldFont(12)
        lblProvince.textColor = UIColor.textGrayColor
        lblProvince.font = UIFont.BoldFont(12)
        lblPostalCde.textColor = UIColor.textGrayColor
        lblPostalCde.font = UIFont.BoldFont(12)
        
        lblLifeTimeHour.font = UIFont.BoldFont(9)
        lblLifeTimeHour.textColor = UIColor.textGrayColor
        lblThisYearHour.font = UIFont.BoldFont(9)
        lblThisYearHour.textColor = UIColor.textGrayColor
        lblLServiceYears.font = UIFont.BoldFont(9)
        lblLServiceYears.textColor = UIColor.textGrayColor
        lblLastYearHour.font = UIFont.BoldFont(9)
        lblLastYearHour.textColor = UIColor.textGrayColor
        
        txtFirstName.font = UIFont.RegularFont(14)
        txtFirstName.layer.borderWidth = 0
        txtFirstName.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtLastName.font = UIFont.RegularFont(14)
        txtLastName.layer.borderWidth = 0
        txtLastName.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtBirthday.font = UIFont.RegularFont(14)
        txtBirthday.layer.borderWidth = 0
        txtBirthday.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtEmail.font = UIFont.RegularFont(14)
        txtEmail.layer.borderWidth = 0
        txtEmail.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtPrimaryPhone.font = UIFont.RegularFont(14)
        txtPrimaryPhone.layer.borderWidth = 0
        txtPrimaryPhone.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtStreetOne.font = UIFont.RegularFont(14)
        txtStreetOne.layer.borderWidth = 0
        txtStreetOne.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtStreetTwo.font = UIFont.RegularFont(14)
        txtStreetTwo.layer.borderWidth = 0
        txtStreetTwo.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtStreetThree.font = UIFont.RegularFont(14)
        txtStreetThree.layer.borderWidth = 0
        txtStreetThree.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtCity.font = UIFont.MediumFont(14)
        txtCity.layer.borderWidth = 0
        txtCity.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtProvince.font = UIFont.RegularFont(14)
        txtProvince.layer.borderWidth = 0
        txtProvince.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtPostalCode.font = UIFont.RegularFont(14)
        txtPostalCode.layer.borderWidth = 0
        txtPostalCode.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtEmergencyContactName.font = UIFont.RegularFont(14)
        txtEmergencyContactName.layer.borderWidth = 0
        txtEmergencyContactName.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtEmergencyContactPhone.font = UIFont.RegularFont(14)
        txtEmergencyContactPhone.layer.borderWidth = 0
        txtEmergencyContactPhone.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        btnPrefferenNoun.backgroundColor = UIColor.clear
        btnPrefferenNoun.titleLabel?.font = UIFont.RegularFont(14)
        btnPrefferenNoun.layer.cornerRadius = 2
        btnPrefferenNoun.setTitleColor(UIColor.textBlackColor, for: .normal)
        btnGender.backgroundColor = UIColor.clear
        btnGender.titleLabel?.font = UIFont.RegularFont(14)
        btnGender.layer.cornerRadius = 2
        btnGender.setTitleColor(UIColor.textBlackColor, for: .normal)
        btnContactMethod.backgroundColor = UIColor.clear
        btnContactMethod.titleLabel?.font = UIFont.RegularFont(14)
        btnContactMethod.layer.cornerRadius = 2
        btnContactMethod.setTitleColor(UIColor.textBlackColor, for: .normal)
        btnOptNotofocation.backgroundColor = UIColor.clear
        btnOptNotofocation.titleLabel?.font = UIFont.RegularFont(14)
        btnOptNotofocation.layer.cornerRadius = 2
        btnOptNotofocation.setTitleColor(UIColor.textBlackColor, for: .normal)
        
        btnSubmit.themeColorButton()
        btnSubmit.backgroundColor = UIColor.themePrimaryColor
        btnSubmit.titleLabel?.font = UIFont.BoldFont(18.0)
        btnSubmit.layer.cornerRadius = 4
//        self.btnSubmit.isEnabled = false
        profileImg.layer.cornerRadius = 8
    
        lblYearsOfService.font = UIFont.BoldFont(14)
        lblCurrentYearHours.font = UIFont.BoldFont(14)
        lblLastYearHours.font = UIFont.BoldFont(14)
        lblLifetimeHours.font = UIFont.BoldFont(14)
        
        lblYearsOfService.textColor = UIColor.themeBlackText
        lblCurrentYearHours.textColor = UIColor.themeBlackText
        lblLastYearHours.textColor = UIColor.themeBlackText
        lblLifetimeHours.textColor = UIColor.themeBlackText
        
        lblYearsOfService.text = "\(UserDefaults.standard.userInfo?.sjavms_qualifiedyearsofservice?.getFormattedNumber() ?? "")"
        lblCurrentYearHours.text = "\(UserDefaults.standard.userInfo?.sjavms_totalhourscompletedthisyear?.getFormattedNumber() ?? "")"
        lblLastYearHours.text = "\(UserDefaults.standard.userInfo?.sjavms_totalhourscompletedpreviousyear?.getFormattedNumber() ?? "")"
        lblLifetimeHours.text = "\(UserDefaults.standard.userInfo?.msnfp_totalengagementhours?.getFormattedNumber() ?? "")"

        
        txtFirstName.lineColor = UIColor.textLightGrayColor
        txtLastName.lineColor = UIColor.textLightGrayColor
        txtBirthday.lineColor = UIColor.textLightGrayColor
        txtEmail.lineColor = UIColor.textLightGrayColor
        txtPrimaryPhone.lineColor = UIColor.textLightGrayColor
        txtStreetOne.lineColor = UIColor.textLightGrayColor
        txtStreetTwo.lineColor = UIColor.textLightGrayColor
        txtStreetThree.lineColor = UIColor.textLightGrayColor
        txtCity.lineColor = UIColor.textLightGrayColor
        txtProvince.lineColor = UIColor.textLightGrayColor
        txtPostalCode.lineColor = UIColor.textLightGrayColor
        txtEmergencyContactName.lineColor = UIColor.textLightGrayColor
        txtEmergencyContactPhone.lineColor = UIColor.textLightGrayColor
        headerView.addBottomShadow()
        lblContact.font =  UIFont.RegularFont(14)
        lblContact.textColor =  UIColor.themeBlackText
        lblAddress.font =  UIFont.RegularFont(14)
        lblAddress.textColor =  UIColor.themeBlackText
        let originalImage = UIImage(named: "messages-bubble-square-text")!
        let tintedImage = ProcessUtils.shared.tintImage(originalImage)
        btnMessage.setImage(tintedImage, for: .normal)
    }
    
    func setupData(){
        lblTitle.text = "Profile".localized
        lblLifeTimeHour.text = "LIFETIME HOURS".localized
        lblThisYearHour.text = "HOURS THIS YEAR".uppercased().localized
        lblLServiceYears.text = "YEAR OF SERVICE".uppercased().localized
        lblLastYearHour.text = "HOURS LAST YEAR".uppercased().localized
        
        lblFirstName.text = "First Name".localized
        lblLastName.text = "Last Name".localized
        lblPreferredPronoun.text = "Preferred Pronouns".localized
        lblGender.text = "Gender".localized
        lblBirthday.text = "Birthday".localized
        lblEmail.text = "Email".localized
        lblContact.text = "Contact".localized
        lblPrimaryPhone.text = "Primary Phone".localized
        lblContactMethod.text = "Method of Conatct".localized
        lblOptNotification.text = "Opt Out of Notifications".localized
        lblEmergencyName.text = "Emergency Contact Name".localized
        lblEmergencyContact.text = "Emergency Contact Phone".localized
        lblAddress.text = "Address".localized
        lblStreetThree.text = "Street".localized
        lblCity.text = "City".localized
        lblProvince.text = "Province".localized
        lblPostalCde.text = "Postal Code".localized
        btnSubmit.setTitle("Update".localized, for: .normal)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        let userDefaultObj = UserDefaults.standard.userInfo
        DispatchQueue.main.async {
            self.profileImg.image = ProcessUtils.shared.convertBase64StringToImage(imageBase64String: userDefaultObj?.entityimage ?? "") ?? UIImage(named: "ic_profile")
        }
        
        lblName.text = "\(userDefaultObj?.firstname ?? "") \(userDefaultObj?.lastname ?? "")"
        txtFirstName.text = userDefaultObj?.firstname ?? ""
        txtLastName.text = userDefaultObj?.lastname ?? ""
        txtBirthday.text = userDefaultObj?.birthdate ?? ""
        txtEmail.text = userDefaultObj?.emailaddress1 ?? ""
        txtPrimaryPhone.text = userDefaultObj?.address1_telephone1 ?? ""
        txtStreetOne.text = userDefaultObj?.address1_line1 ?? ""
        txtStreetTwo.text = userDefaultObj?.address1_line2 ?? ""
        txtStreetThree.text = userDefaultObj?.address1_line3 ?? ""
        txtCity.text = userDefaultObj?.address1_city ?? ""
        txtProvince.text = userDefaultObj?.address1_stateorprovince ?? ""
        txtPostalCode.text = userDefaultObj?.address1_postalcode ?? ""
        txtEmergencyContactName.text = userDefaultObj?.sjavms_emergencycontactname ?? ""
        txtEmergencyContactPhone.text = userDefaultObj?.sjavms_emergencycontactphone ?? ""
        var gender = ""
        if userDefaultObj?.gendercode == 2 {
            gender = "Male".localized
        }else if userDefaultObj?.gendercode ==  1 {
            gender = "Female".localized
        }

        btnGender.setTitle(gender, for: .normal)
        
//         = self.getGender(userDefaultObj?.gendercode ?? 0)
        let noun = self.getPreferedNoun(userDefaultObj?.sjavms_preferredpronouns ?? 0)
        let contactMethod = self.getPreferedContactMethod(userDefaultObj?.preferredcontactmethodcode ?? 0)
        
        btnPrefferenNoun.setTitle(noun , for: .normal)
        btnGender.setTitle(gender, for: .normal)
        btnContactMethod.setTitle(contactMethod, for: .normal)
        if (UserDefaults.standard.userInfo?.sjavms_optoutofnotifications == true) {
            btnOptNotofocation.setTitle("ON".localized, for: .normal)
        }else{
            btnOptNotofocation.setTitle("OFF".localized, for: .normal)
        }
    }
    
    
    
    @IBAction func selectGenderTapped(_ sender: Any) {
//        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: { status in })
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.gender, dataObj: ProcessUtils.shared.genderData) { [self] params, controller in
            
            if let data = params as? LanguageModel {
                self.btnGender.setTitle("\(data.value ?? "")", for: .normal)
                self.selectedGender = data.attributevalue ?? 000
            }
        }
        
    }
    
    @IBAction func selectPronounTapped(_ sender: Any) {
//        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: { status in })
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.pronoun, dataObj: ProcessUtils.shared.prefferedPronounData) { params, controller in
            
            if let data = params as? LanguageModel {
                self.btnPrefferenNoun.setTitle("\(data.value ?? "")", for: .normal)
                self.selectedPronoun = data.attributevalue ?? 000
            }
        }
    }
    
    @IBAction func optNotificationTapped(_ sender: Any) {
//        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: { status in })
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.optNotification, dataObj: ProcessUtils.shared.optOutNotification) { params, controller in

            self.selectedOptNotification  = params as? String
            var status = ProcessUtils.shared.optOutNotification.filter({$0.value == params as? String}).first?.key
            if (status == 0) {
                self.selectedOptNotification_value = false
                self.btnOptNotofocation.setTitle("OFF", for: .normal)
            }else if(status == 1){
                self.selectedOptNotification_value = true
                self.btnOptNotofocation.setTitle("ON", for: .normal)
            }
//            if let data = params as? Bool {
//
//                if data == true{
//                    self.btnOptNotofocation.setTitle("Yes", for: .normal)
//                    self.selectedOptNotification = true
//                    self.selectedOptNotification_value = true
//                }else{
//                    self.btnOptNotofocation.setTitle("No", for: .normal)
//                    self.selectedOptNotification_value = false
//                    self.selectedOptNotification = false
//                }
//            }
        }
    }
    
    @IBAction func preferredMethodTapped(_ sender: Any) {
//        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: { status in })
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.prefferedData, dataObj: ProcessUtils.shared.prefferedMethodContactData) { params, controller in
            
            if let data = params as? LanguageModel {
                self.btnContactMethod.setTitle("\(data.value ?? "")", for: .normal)
                self.selectedContactMethod = data.attributevalue ?? 000
            }
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func submitTapped(_ sender: Any) {
        self.updateUserInfo()
//        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: { status in })
    }
    
    
    @IBAction func messageTapped(_ sender: Any) {
        
        ENTALDControllers.shared.showGroupMessageVC(type: .ENTALDPUSH, from: self, callBack: nil)
        
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
    
    
    @IBAction func selectProfileImg(_ sender: Any) {
        self.showAlert()
    }
    
    func updateUserInfo(){
        
    
        DispatchQueue.main.async {
            LoadingView.show()
            self.view.endEditing(true)
        }
        var params:[String:Any] = [
            "firstname" : txtFirstName.text ?? "",
            "lastname" : txtLastName.text ?? "",
            "birthdate" : txtBirthday.text ?? "",
            "emailaddress1" : txtEmail.text ?? "",
            "address1_telephone1" : txtPrimaryPhone.text ?? "",
            "address1_line1" : txtStreetOne.text ?? "",
            "address1_line2" : txtStreetTwo.text ?? "",
            "address1_line3" : txtStreetThree.text ?? "",
            "address1_city" : txtCity.text ?? "",
            "address1_stateorprovince" : txtProvince.text ?? "",
            "address1_postalcode" : txtPostalCode.text ?? "",
            "sjavms_emergencycontactname" : txtEmergencyContactName.text ?? "",
            "sjavms_emergencycontactphone" : txtEmergencyContactPhone.text ?? ""
        ]
        
        if (selectedGender != nil){
            params["gendercode"] = selectedGender
        
        }
        if (selectedPronoun != nil){
            params["sjavms_preferredpronouns"] = selectedPronoun

        }
        if (selectedContactMethod != nil){
          params["preferredcontactmethodcode"] = selectedContactMethod
        }
        
        if (selectedOptNotification != nil){
          params["sjavms_optoutofnotifications"] = selectedOptNotification_value
        }
        
        if (imgBase64 != nil){
            params["entityimage"] = self.imgBase64
        }
        
        
        ENTALDLibraryAPI.shared.requestProfileInfoUpdate(conId: self.contactId, params: params){ result in
        DispatchQueue.main.async {
            LoadingView.hide()
        }
        switch result{
        case .success(value: _):
             break
        case .error(let error, let errorResponse):
            if error == .patchSuccess {
            
                self.getUserIdentity(conId: self.contactId)

                
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
    
    func getUserIdentity(conId:String){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestUserIdentity(conId: conId) { result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result {
            case .success(let response):
                UserDefaults.standard.userInfo = response
//                self.setupData()
                
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
                
//                ENTALDAlertView.shared.showContactAlertWithTitle(title: "Profile Updated Successfully", message: "", actionTitle: .KOK, completion: { status in
//                    
//
//                    
//                })
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
    
    
    //MARK: - UIImagePickerControllerDelegate

  
    
     func showAlert() {

            let alert = UIAlertController(title: "Image Selection", message: "Pick image from photo library", preferredStyle: .actionSheet)
//            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
//                self.getImage(fromSourceType: .camera)
//            }))
            alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
                self.getImage(fromSourceType: .photoLibrary)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

        //get image from source type
        func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {

            if UIImagePickerController.isSourceTypeAvailable(sourceType){
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = sourceType
                imagePicker.modalPresentationStyle = .fullScreen
                self.present(imagePicker, animated: true, completion: nil)
            }
            
        }

        //MARK:- UIImagePickerViewDelegate.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
 
        guard let urle = info[.imageURL] as? URL else { return }
        guard let image = info[.originalImage] as? UIImage else {
                    fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
                }
        
        self.profileImg.image = image
        self.imgBase64 = convertImageToBase64String(img: image)
        url = urle
        
        dismiss(animated: true)
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

            let yOffset = scrollView.contentOffset.y
            if yOffset > 220{ // You can adjust this value according to when you want to show the custom view
                if (((yOffset - 220) + 16 ) > 16 && !(((yOffset - 220) + 16 ) < 16)){
                    self.updateViewBottomCostraint.constant = (yOffset - 220) + 16
                }else{
                    self.updateViewBottomCostraint.constant = 16
                }
                
            } else {
                self.updateViewBottomCostraint.constant = 16
            }
        }
    
}
