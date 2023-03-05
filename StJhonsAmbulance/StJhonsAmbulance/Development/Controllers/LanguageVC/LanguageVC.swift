//
//  LanguageVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 16/02/2023.
//

import UIKit

class LanguageVC: ENTALDBaseViewController {
    
    var languageData : [LanguageModel] = []
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPreferredLanguage: UILabel!
    @IBOutlet weak var lblOtherLanguages: UILabel!
    @IBOutlet weak var txtPreferredLanguage: ACFloatingTextfield!
    @IBOutlet weak var txtOtherLanguages: ACFloatingTextfield!
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLanguages()
        decorateUI()
    }
    
    
    @IBAction func submitTapped(_ sender: Any) {
        
        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
    }
    
    func decorateUI(){
        
        lblTitle.textColor = UIColor.themePrimaryWhite
        lblTitle.font = UIFont.BoldFont(16)
        
        lblPreferredLanguage.textColor = UIColor.themePrimaryWhite
        lblPreferredLanguage.font = UIFont.BoldFont(14)
        
        txtPreferredLanguage.textColor = UIColor.themeBlackText
        txtPreferredLanguage.font = UIFont.BoldFont(14)
        txtOtherLanguages.textColor = UIColor.themeBlackText
        txtOtherLanguages.font = UIFont.BoldFont(14)
        
        lblOtherLanguages.textColor = UIColor.themePrimaryWhite
        lblOtherLanguages.font = UIFont.BoldFont(14)
        
        
        txtPreferredLanguage.layer.borderWidth = 1
        txtPreferredLanguage.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        txtOtherLanguages.layer.borderWidth = 1
        txtOtherLanguages.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        btnSubmit.themeColorButton()
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getLanguages() {
        
        let params : [String:Any] = [
            ParameterKeys.filter : "objecttypecode eq 'contact' and attributename eq 'sjavms_otherknownlanguages' and langid eq 1033"
        ]
        
        self.getLanguageData(params: params)
        
    }
    
    
    fileprivate func getLanguageData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestPreferedLanguage(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let qualification = response.value {
                    self.languageData = qualification
                    
                    DispatchQueue.main.async {
                        
                        self.txtPreferredLanguage.text = self.getPreferedLanguage(UserDefaults.standard.userInfo?.sjavms_preferredlanguage ?? 0)
                        
                        self.txtOtherLanguages.text = self.getOtherLanguage()
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
    
    
    func showGroupsPicker(list:[LanguageModel] = []){
        if (self.languageData.count != 0){
            ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, dataObj: self.languageData) { params, controller in
                
                if let data = params as? LanguageModel {
//                    ProcessUtils.shared.selectedUserGroup = data
                    
//                    self.btn2.setTitle("\(data.msnfp_groupId?.getGroupName() ?? "")", for: .normal)
//    //                self.btn1.setTitle(data.sjavms_RoleType?.getRoleType() ?? "", for: .normal)
//                    self.nextBtn.isEnabled = true
//                    self.nextBtn.backgroundColor = UIColor.themePrimary
                }
            }
        }else{
            self.getLanguages()
        }
        
    }
    
    func getPreferedLanguage(_ preferedLanguage:Int)->String?{
        let language = languageData.filter({$0.attributevalue == preferedLanguage}).first?.value
        return language
    }
    
    func getOtherLanguage()->String?{
        
        var language = ""
        for lang in self.languageData {
            if let languageName = lang.value{
                if (lang.value == self.languageData.last?.value ) {
                    language += "\(languageName)"
                }else{
                    language += "\(languageName), "
                }
                
                
            }
            
           
        }
        
        return language
        
        
    }
    
    
    
    
    
}
