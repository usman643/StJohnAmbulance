//
//  LanguageVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 16/02/2023.
//

import UIKit

class LanguageVC: ENTALDBaseViewController {
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblPreferredLanguage: UILabel!
    @IBOutlet weak var lblOtherLanguages: UILabel!

    @IBOutlet weak var txtPreferredLanguage: ACFloatingTextfield!
    @IBOutlet weak var txtOtherLanguages: ACFloatingTextfield!

    
    
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
    
    
    
}
