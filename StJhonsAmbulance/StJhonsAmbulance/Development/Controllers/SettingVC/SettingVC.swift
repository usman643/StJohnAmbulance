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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func decorateUI(){
        lblTitle.textColor = UIColor.headerGreen
        lblTitle.font = UIFont.HeaderBoldFont(18)
        lblTheme.textColor = UIColor.themePrimaryWhite
        lblTheme.font = UIFont.BoldFont(16)
        
    }
    
    
    @IBAction func changePassTapped(_ sender: Any) {
        
        ENTALDControllers.shared.showChangePasswordScreen(type: .ENTALDPUSH, from: self, callBack: nil)
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
