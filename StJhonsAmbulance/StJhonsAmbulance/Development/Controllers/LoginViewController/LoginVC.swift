//
//  LoginVC.swift
//  SJA
//
//  Created by ENT20121341 on 20/01/2023.
//

import UIKit
import ACFloatingTextfield_Swift

class LoginVC: ENTALDBaseViewController {


    @IBOutlet weak var headerLogoView: UIView!
    @IBOutlet weak var headerLogoImgView: UIImageView!
    @IBOutlet weak var txtUserName: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    
    
    @IBOutlet weak var MainVw: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnForgotPass: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnShowPass: UIButton!
    
    @IBOutlet weak var gmailView: UIView!
    @IBOutlet weak var fbView: UIView!
    
    
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtUserName.text = "dougsalomon@outlook.com"
        self.txtPassword.text = "qAz!2#sss"
        decorateUI()
    }

    
    func decorateUI(){
        self.navigationController?.navigationBar.isHidden = true
        headerLogoView.layer.cornerRadius =  headerLogoView.frame.size.height/2
        headerLogoView.backgroundColor = UIColor.themePrimary
        txtUserName.addDoneOnKeyboardWithTarget(self, action: #selector(nextButtonClicked), titleText: "Email")
        txtPassword.addDoneOnKeyboardWithTarget(self, action: #selector(doneButtonClicked), titleText: "Password")

        MainVw.backgroundColor = UIColor.white
        MainVw.layer.cornerRadius = 30
        MainVw.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        btnLogin.backgroundColor = UIColor.themeSecondry
        btnRegister.titleLabel?.textColor = UIColor.themePrimary
        txtPassword.isSecureTextEntry = true
        txtPassword.textColor = UIColor.black
        txtUserName.textColor = UIColor.black
        
        gmailView.layer.cornerRadius = gmailView.frame.size.height/2
       addShadow(to: gmailView)
       addShadow(to: fbView)
        fbView.layer.cornerRadius = fbView.frame.size.height/2
        
    }
    
    @IBAction func registerTapped(_ sender: Any) {
       
        
    }
    @IBAction func forgotTapped(_ sender: Any) {
//        let regVC = ForgetVC(nibName: "ForgetVC", bundle: nil)
//        self.navigationController?.pushViewController(regVC, animated: true)
        
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
        
    }
    @IBAction func gmailLoginTapped(_ sender: Any) {
    }
    
    @IBAction func fbLoginTapped(_ sender: Any) {
    }
    
    @IBAction func showSecureFieldAction(_ sender: UIButton) {
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
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
        LoadingView.show()
        ENTALDLibraryAPI.shared.requestPortalAuth(params: params) { result in
            LoadingView.hide()
            switch result {
            case .success(let response):
                if let sessionToken = response.access_token {
                    print("Got Access Token \(ENTALDAPIUtils.shared.getJWTToken(accessToken: sessionToken))")
                }
                break
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
            }
        }
        
    }
    
}
