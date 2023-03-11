//
//  LanguageVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 16/02/2023.
//

import UIKit

protocol OtherLanguageCloseDelegate {
    
    func otherLanguageClose(index:Int)
}

class LanguageVC: ENTALDBaseViewController,OtherLanguageCloseDelegate {
    
    
    var languageData : [LanguageModel] = []
    let prefferedLanguages = ProcessUtils.shared.prefferedLanguageData
    
    var preferredLanguage:Int?
    var otherKnownLanguage = ""
    let conId = UserDefaults.standard.contactIdToken ?? ""
    var otherLanguageData:[String] = []
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPreferredLanguage: UILabel!
    @IBOutlet weak var lblOtherLanguages: UILabel!
    @IBOutlet weak var txtPreferredLanguage: ACFloatingTextfield!
    @IBOutlet weak var txtOtherLanguages: ACFloatingTextfield!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var colViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnPrefferedLanguage: UIButton!
    @IBOutlet weak var btnOtherLanguage: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "LanguageCVC", bundle: nil), forCellWithReuseIdentifier: "LanguageCVC")
        getLanguages()
        decorateUI()
        
        otherKnownLanguage = UserDefaults.standard.userInfo?.sjavms_otherknownlanguages ?? ""
        otherLanguageData = otherKnownLanguage.components(separatedBy: ",")
        self.btnOtherLanguage.setTitle("Select Option", for: .normal)
        
        if let prfferedLang = self.getOtherLanguage(UserDefaults.standard.userInfo?.sjavms_preferredlanguage ?? 00){
            self.btnPrefferedLanguage.setTitle("\(prfferedLang)", for: .normal)
            
        }
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
        
        btnPrefferedLanguage .setTitleColor( UIColor.textWhiteColor, for: .normal)
        btnPrefferedLanguage.titleLabel?.font = UIFont.BoldFont(14)
        
        btnOtherLanguage .setTitleColor( UIColor.textWhiteColor, for: .normal)
        btnOtherLanguage.titleLabel?.font = UIFont.BoldFont(14)
        
    }
    
    func otherLanguageClose(index: Int) {
        self.otherLanguageData.remove(at: index)
        self.collectionView.reloadData()
    }
    
    
    @IBAction func prefferLanguageTapped(_ sender: Any) {
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.prefferedLanguage, dataObj: self.prefferedLanguages) { params, controller in
            
            if let data = params as? PrefferedLanguageModel {
                self.btnPrefferedLanguage.setTitle("\(data.adx_name ?? "")", for: .normal)
//                self.txtPreferredLanguage.text = data.adx_name ?? ""
                
                  
                self.preferredLanguage = self.getOtherLanguageCode(data.adx_name ?? "")
            }
        }
        
    }
    
    @IBAction func otherLanguageTapped(_ sender: Any) {
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.language, dataObj: self.languageData) { params, controller in
            
            if let data = params as? LanguageModel {
                self.btnOtherLanguage.setTitle("\(data.value ?? "")", for: .normal)
                
//                self.txtOtherLanguages.text = data.value ?? ""
                var selectLang = "\(data.attributevalue ?? 0)"
                if (!self.otherLanguageData.contains("\(selectLang)")){
                    self.otherLanguageData.append("\(data.attributevalue ?? 0)")
//                    self.collectionView.reloadData()
                }
                self.collectionView.reloadData()
                
            }
        }
        
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        
//        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
        
        self.updateLanguagesData()
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
        
        ENTALDLibraryAPI.shared.requestProfileInfoDetail(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let qualification = response.value {
                    self.languageData = qualification
                    
                    DispatchQueue.main.async {
                        if let prfferedLang = self.getOtherLanguage(UserDefaults.standard.userInfo?.sjavms_preferredlanguage ?? 00){
                            self.btnPrefferedLanguage.setTitle("\(prfferedLang)", for: .normal)
                            
                        }
                        self.collectionView.reloadData()
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
    
    
    func getOtherLanguage(_ preferedLanguage:Int)->String?{
        let language = languageData.filter({$0.attributevalue == preferedLanguage}).first?.value
        return language
    }

    func getOtherLanguageCode(_ preferedLanguage:String)->Int?{
        let language = languageData.filter({$0.value == preferedLanguage}).first?.attributevalue
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
    
    
    
    
    func updateLanguagesData(){
        
//        otherLanguageData
        otherKnownLanguage =  otherLanguageData.joined(separator:",")
        
        if (preferredLanguage != nil  || otherKnownLanguage != ""){
            DispatchQueue.main.async {
                LoadingView.show()
            }
            var params:[String:Any] = [:]
            
            if (otherKnownLanguage != "" ){
                params["sjavms_otherknownlanguages"] = otherKnownLanguage as String
                
            }
            if (preferredLanguage != nil){
                params["sjavms_preferredlanguage"] = preferredLanguage as? Int
                
            }
            
            
            params["adx_preferredlanguageid@odata.bind"] = "/adx_portallanguages(bb2f4092-0856-ed11-9561-0022486dccc4)"
            print(params)
            ENTALDLibraryAPI.shared.requestProfileInfoUpdate(conId: self.conId, params: params){ result in
                DispatchQueue.main.async {
                    LoadingView.hide()
                }
                switch result{
                case .success(value: _):
                    break
                case .error(let error, let errorResponse):
                    if error == .patchSuccess {
                        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Languages Updated Successfully", message: "", actionTitle: .KOK, completion: { status in })
                        UserDefaults.standard.userInfo?.sjavms_otherknownlanguages = self.otherKnownLanguage
                        UserDefaults.standard.userInfo?.sjavms_preferredlanguage = self.preferredLanguage
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
        }else{
            ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Please Change Language", actionTitle: .KOK, completion: {status in })
        }
    }
    
    
    
}



extension LanguageVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return otherLanguageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LanguageCVC", for: indexPath) as! LanguageCVC
        let langCode = Int(otherLanguageData[indexPath.row])
        cell.lblTitle.text = self.getOtherLanguage(langCode ?? 00)
        cell.index =  indexPath.row
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSizeMake(130, 40)
    }
    
    
    
}
