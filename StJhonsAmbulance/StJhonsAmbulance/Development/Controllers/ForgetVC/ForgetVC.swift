//
//  ForgetVC.swift
//  SJA
//
//  Created by ENT20121341 on 20/01/2023.
//

import UIKit

class ForgetVC: ENTALDBaseViewController {

    
    @IBOutlet weak var headerLogoView: UIView!
    @IBOutlet weak var headerLogoImgView: UIImageView!
    @IBOutlet weak var txtUserName: ACFloatingTextfield!
    
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var MainVw: UIView!
    @IBOutlet weak var btnSendEmail: UIButton!
    @IBOutlet weak var btnlogin: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
        
        // Do any additional setup after loading the view.
    }

    func decorateUI(){
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.themeSecondry
        headerLogoView.layer.cornerRadius =  headerLogoView.frame.size.height/2
        headerLogoView.backgroundColor = UIColor.themePrimary
        txtUserName.addDoneOnKeyboardWithTarget(self, action: #selector(doneButtonClicked), titleText: "Email")

        self.view.backgroundColor = UIColor.themeSecondry
        MainVw.layer.cornerRadius = 40
        MainVw.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        btnSendEmail.themeColorButton()
        btnlogin.titleLabel?.textColor = UIColor.themePrimary
        
        lblTitle.font = UIFont.BoldFont(24)
        lblDesc.font = UIFont.BoldFont(16)
        lblEmail.font = UIFont.BoldFont(16)
        
        lblTitle.textColor = UIColor.textWhiteColor
        lblDesc.textColor = UIColor.themePrimaryColor
        lblEmail.textColor = UIColor.black
        
        btnSendEmail.titleLabel?.textColor = UIColor.textWhiteColor
        btnSendEmail.titleLabel?.font = UIFont.BoldFont(16)

    }

    @objc func doneButtonClicked(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        
        let regVC = LoginVC(nibName: "LoginVC", bundle: nil)
        self.navigationController?.pushViewController(regVC, animated: true)
    }
    
    
}
