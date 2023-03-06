//
//  SettingVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 16/02/2023.
//

import UIKit

class SettingVC: ENTALDBaseViewController {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTheme: UILabel!
    
    @IBOutlet weak var themeSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        decorateUI()
    }

    func decorateUI(){
        lblTitle.textColor = UIColor.themePrimaryWhite
        lblTitle.font = UIFont.BoldFont(16)
        lblTheme.textColor = UIColor.themePrimaryWhite
        lblTheme.font = UIFont.BoldFont(16)
        
    }

    @IBAction func backTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func themeSwicthAction(_ sender: Any) {
        
        UserDefaults.standard.isDarkMode = themeSwitch.isOn
        self.setAppearanceDarkLightMode()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
}
