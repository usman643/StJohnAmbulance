//
//  LoginVC.swift
//  SJA
//
//  Created by ENT20121341 on 20/01/2023.
//

import UIKit
import ACFloatingTextfield_Swift

class LoginVC: ENTALDBaseViewController {
    
    var isRememberPassword: Bool!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var headerLogoView: UIView!
    @IBOutlet weak var headerLogoImgView: UIImageView!
    @IBOutlet weak var txtUserName: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var lblStaySigin: UILabel!
    
    @IBOutlet weak var lblAccountRegister: UILabel!
    @IBOutlet weak var lblLoginWith: UILabel!
    @IBOutlet weak var MainVw: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnForgotPass: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnShowPass: UIButton!
    @IBOutlet weak var gmailView: UIView!
    @IBOutlet weak var fbView: UIView!
    
    @IBOutlet weak var btnStaySignIn: UIButton!
    
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtUserName.text = "dougsalomon@outlook.com"
        self.txtPassword.text = "qAz!2#sss"
        UserDefaults.standard.authToken = nil
        isRememberPassword = false
        decorateUI()
    }

    func decorateUI(){
        self.navigationController?.navigationBar.isHidden = true
        headerLogoView.layer.cornerRadius =  headerLogoView.frame.size.height/2
        headerLogoView.backgroundColor = UIColor.themePrimary
        txtUserName.addDoneOnKeyboardWithTarget(self, action: #selector(nextButtonClicked), titleText: "Email")
        txtPassword.addDoneOnKeyboardWithTarget(self, action: #selector(doneButtonClicked), titleText: "Password")
        
        btnLogin.themeColorButton()
        MainVw.backgroundColor = UIColor.white
        MainVw.layer.cornerRadius = 30
        MainVw.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        btnLogin.backgroundColor = UIColor.themeSecondry
        btnRegister.titleLabel?.textColor = UIColor.themePrimary
        txtPassword.isSecureTextEntry = true
        txtPassword.textColor = UIColor.textBlackColor
        txtUserName.textColor = UIColor.textBlackColor
        
        
        gmailView.layer.cornerRadius = gmailView.frame.size.height/2
       addShadow(to: gmailView)
       addShadow(to: fbView)
        fbView.layer.cornerRadius = fbView.frame.size.height/2
        fbView.backgroundColor = UIColor.textWhiteColor
        gmailView.backgroundColor = UIColor.textWhiteColor
        
        btnStaySignIn.layer.cornerRadius = 2
        lblTitle.font = UIFont.BoldFont(42)
        lblEmail.font = UIFont.BoldFont(20)
        lblPassword.font = UIFont.BoldFont(20)
        txtUserName.font = UIFont.RegularFont(16)
        txtPassword.font = UIFont.RegularFont(16)
        lblStaySigin.font = UIFont.RegularFont(14)
        btnForgotPass.titleLabel?.font = UIFont.RegularFont(14)
        lblAccountRegister.font = UIFont.RegularFont(14)
        btnRegister.titleLabel?.font = UIFont.RegularFont(14)
        lblLoginWith.font = UIFont.RegularFont(14)
        btnLogin.titleLabel?.font = UIFont.BoldFont(20)
        
        lblTitle.textColor = UIColor.textWhiteColor
        lblEmail.textColor = UIColor.textBlackColor
        lblPassword.textColor = UIColor.textBlackColor
        txtUserName.textColor = UIColor.textGrayColor
        txtPassword.textColor = UIColor.textGrayColor
        lblStaySigin.textColor = UIColor.textGrayColor
        btnForgotPass.titleLabel?.textColor = UIColor.textGrayColor
        lblAccountRegister.textColor = UIColor.textBlackColor
        
        lblLoginWith.textColor = UIColor.textGrayColor
        txtUserName.placeHolderColor = UIColor.textLightGrayColor
        txtPassword.placeHolderColor = UIColor.textLightGrayColor
        btnLogin.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnRegister.titleLabel?.textColor = UIColor.themePrimaryColor
        
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        
        let regVC = PendingEventVC(nibName: "PendingEventVC", bundle: nil)
        self.navigationController?.pushViewController(regVC, animated: true)
        
//        ENTALDControllers.shared.showTabbarViewController(type: .ENTALDPUSH, from: UIApplication.getTopViewController()) { params, controller in
//
//        }
    }
    
    @IBAction func forgotTapped(_ sender: Any) {
        let regVC = ForgetVC(nibName: "ForgetVC", bundle: nil)
        self.navigationController?.pushViewController(regVC, animated: true)
        
    }
    
    func showLandingScreen(){
       
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        guard let email = self.txtUserName.text else {
            self.txtUserName.showErrorWithText(errorText: "Please enter email")
            return
        }
        if email == "" {
            self.txtUserName.showErrorWithText(errorText: "Please enter email")
            return
        }
        
        if !email.isEmail {
            self.txtUserName.showErrorWithText(errorText: "Please enter valid email")
            return
        }
        
        guard let password = self.txtPassword.text else {
            self.txtPassword.showErrorWithText(errorText: "Please Enter Password")
            return
        }
        
        if (password == ""){
            self.txtPassword.showErrorWithText(errorText: "Please Enter Password")
            return
        }
        
        let params : PortalAuthRequest = PortalAuthRequest(username: email, password: password, grant_type: "password", scope: "openid 86d0acb3-3740-41ef-b0e2-cf2e9f77fdb7 offline_access", client_id: "86d0acb3-3740-41ef-b0e2-cf2e9f77fdb7", response_type: "token id_token")
        
        self.portalAuthentication(params: params)
    }
    
    @IBAction func staySignin(_ sender: Any) {
        if (isRememberPassword){
            btnStaySignIn.setImage(UIImage(named: ""), for: .normal)
            btnStaySignIn.backgroundColor = UIColor.viewLightGrayColor
            isRememberPassword = false
        }else{
            btnStaySignIn .setImage(UIImage(named: "ic_check"), for: .normal)
            btnStaySignIn.backgroundColor = UIColor.clear
            isRememberPassword = true
        }
    
        
    }
    @IBAction func gmailLoginTapped(_ sender: Any) {
    }
    
    @IBAction func fbLoginTapped(_ sender: Any) {
    }
    
    @IBAction func showSecureFieldAction(_ sender: UIButton) {
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
        let image = UIImage(named: "Vectoreye")?.withRenderingMode(.alwaysTemplate)
        btnShowPass.setImage(image, for: .normal)
        if (txtPassword.isSecureTextEntry){
            btnShowPass.tintColor = UIColor.lightGray
           
        }else{
            btnShowPass.tintColor = UIColor.themePrimaryColor
        }
        
    }
    

    @objc func doneButtonClicked(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc func nextButtonClicked(_ sender: Any) {
//        txtUsername.resignFirstResponder()
        let _ = txtPassword.becomeFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
            return true
    }
    
    
    
    func addShadow(to view: UIView) {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowRadius = view.frame.size.height/2
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = .zero
        view.clipsToBounds = false
    }
}


extension LoginVC {
    
    func portalAuthentication(params:PortalAuthRequest){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        ENTALDLibraryAPI.shared.requestPortalAuth(params: params) { result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result {
            case .success(let response):
                if let sessionToken = response.access_token {
                    if let subId = ENTALDAPIUtils.shared.getJWTToken(accessToken: sessionToken){
                        self.dynamicAuthentication(subId: subId)
                    }
                }
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
    
    func dynamicAuthentication(subId:String){
        
        let params : DynamicAuthRequest = DynamicAuthRequest(grant_type: "client_credentials", client_id: "e0508903-f48f-418c-ad61-7a2f38ff50a4", resource: "https://sja-sandbox.crm3.dynamics.com/", client_secret: "82a8Q~inojTl~emDlThirKD6TEV64PG0EH_rccGW")
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        ENTALDLibraryAPI.shared.requestDynamicAuth(params: params) { result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result {
            case .success(let response):
                if let token = response.access_token {
                    UserDefaults.standard.authToken = token
                    self.externalAuthentication(subId: subId)
                }
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
    
    
    func externalAuthentication(subId:String){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        ENTALDLibraryAPI.shared.requestExternalAuth(subId: subId) { result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result {
            case .success(let response):
                if let contactId = response.value?.first?._adx_contactid_value {
                    UserDefaults.standard.contactIdToken = contactId
                    self.getUserIdentity(conId: contactId)
                }
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
