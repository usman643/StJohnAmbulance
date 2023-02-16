//
//  ChangePasswordVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 16/02/2023.
//

import UIKit

class ChangePasswordVC: ENTALDBaseViewController {
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblOldPass: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblNewPass: UILabel!
    @IBOutlet weak var lblConfirmPass: UILabel!
    @IBOutlet weak var txtUsername: ACFloatingTextfield!
    @IBOutlet weak var txtOldPass: ACFloatingTextfield!
    @IBOutlet weak var txtNewPass: ACFloatingTextfield!
    @IBOutlet weak var txtConfirmPass: ACFloatingTextfield!
    
    
    @IBOutlet weak var btnSubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
    }


    @IBAction func submitTapped(_ sender: Any) {
        
        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
    }
    
    func decorateUI(){
        
        lblTitle.textColor = UIColor.themePrimaryWhite
        lblTitle.font = UIFont.BoldFont(16)
        lblUserName.textColor = UIColor.themePrimaryWhite
        
        lblOldPass.textColor = UIColor.themePrimaryWhite
        lblOldPass.font = UIFont.BoldFont(14)
        lblUserName.textColor = UIColor.themePrimaryWhite
        lblUserName.font = UIFont.BoldFont(14)
        lblNewPass.textColor = UIColor.themePrimaryWhite
        lblNewPass.font = UIFont.BoldFont(14)
        lblConfirmPass.textColor = UIColor.themePrimaryWhite
        lblConfirmPass.font = UIFont.BoldFont(14)
        
        txtUsername.textColor = UIColor.themeBlackText
        txtUsername.font = UIFont.BoldFont(14)
        txtOldPass.textColor = UIColor.themeBlackText
        txtOldPass.font = UIFont.BoldFont(14)
        txtNewPass.textColor = UIColor.themeBlackText
        txtNewPass.font = UIFont.BoldFont(14)
        txtConfirmPass.textColor = UIColor.themeBlackText
        txtConfirmPass.font = UIFont.BoldFont(14)
        
        txtUsername.layer.borderWidth = 1
        txtUsername.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtOldPass.layer.borderWidth = 1
        txtOldPass.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtNewPass.layer.borderWidth = 1
        txtNewPass.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtConfirmPass.layer.borderWidth = 1
        txtConfirmPass.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        btnSubmit.themeColorButton()
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        
        self.txtUsername.isUserInteractionEnabled = false
        self.txtUsername.text = UserDefaults.standard.userInfo?.adx_identity_username
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
