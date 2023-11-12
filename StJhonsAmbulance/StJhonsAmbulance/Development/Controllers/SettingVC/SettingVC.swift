//
//  SettingVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 16/02/2023.
//

import UIKit

class SettingVC: ENTALDBaseViewController {

    var isSystemPreferTheme = false
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTheme: UILabel!
    @IBOutlet weak var lblThemeDark: UILabel!
    
    @IBOutlet weak var lblFrench: UILabel!
    @IBOutlet weak var lblEnglish: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var languageSwitch: UISwitch!
    @IBOutlet weak var lbllSystmePreferedTheme: UILabel!
    
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnSystemPreferTheme: UIButton!
    
    @IBOutlet weak var btnChangePassword: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        decorateUI()
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

    func decorateUI(){
        lblTitle.textColor = UIColor.headerGreen
        lblTitle.font = UIFont.HeaderBoldFont(18)
        lblTheme.textColor = UIColor.themePrimaryWhite
        lblTheme.font = UIFont.BoldFont(16)
        lblThemeDark.textColor = UIColor.themePrimaryWhite
        lblThemeDark.font = UIFont.BoldFont(16)
        lblFrench.font = UIFont.BoldFont(16)
        lblFrench.textColor = UIColor.themePrimaryWhite
        lblEnglish.font = UIFont.BoldFont(16)
        lblEnglish.textColor = UIColor.themePrimaryWhite
        lbllSystmePreferedTheme.font = UIFont.BoldFont(16)
        lbllSystmePreferedTheme.textColor = UIColor.themePrimaryWhite
        
        themeSwitch.onTintColor = UIColor.themePrimary
        languageSwitch.onTintColor = UIColor.themePrimary
        
        btnChangePassword.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnChangePassword.titleLabel?.font = UIFont.MediumFont(14)
        headerView.addBottomShadow()
        let originalImage = UIImage(named: "messages-bubble-square-text")!
        let tintedImage = ProcessUtils.shared.tintImage(originalImage)
        btnMessage.setImage(tintedImage, for: .normal)
        
        
        let currentTraitCollection = UITraitCollection.current

        if (UserDefaults.standard.isSystemPrefernceTheme){
            
            isSystemPreferTheme = true
            
            btnSystemPreferTheme.setImage(UIImage(named: "Check box selected"), for: .normal)
            if currentTraitCollection.userInterfaceStyle == .light {
                // The device is in light mode
                              themeSwitch.isOn = false
                UserDefaults.standard.isDarkMode = false
            } else if currentTraitCollection.userInterfaceStyle == .dark {
                // The device is in dark mode
                              themeSwitch.isOn = true
                UserDefaults.standard.isDarkMode = true
            }
            themeSwitch.isEnabled = false
        }else{
            
            btnSystemPreferTheme.setImage(UIImage(named: "Checkbox unselected"), for: .normal)
            themeSwitch.isEnabled = true
            isSystemPreferTheme = false
        }
        
//        themeSwitch.isOn = UserDefaults.standard.isDarkMode
        
    }
    
    func setupData(){
        
        lblTitle.text = "Setting".localized
        lbllSystmePreferedTheme.text = "System Prefered Theme".localized
        lblTheme.text = "Light Mode".localized
        lblThemeDark.text = "Dark Mode".localized
        lblFrench.text = "French".localized
        lblEnglish.text = "English".localized
        
        btnChangePassword.setTitle("Change Password".localized, for: .normal)
    }
    
    @IBAction func changePassTapped(_ sender: Any) {
        
        ENTALDControllers.shared.showChangePasswordScreen(type: .ENTALDPUSH, from: self, callBack: nil)
    }
    
    @IBAction func messageTapped(_ sender: Any) {
        ENTALDControllers.shared.showGroupMessageVC(type: .ENTALDPUSH, from: self, callBack: nil)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func themeSwicthAction(_ sender: Any) {
        
        UserDefaults.standard.isDarkMode = themeSwitch.isOn
        self.setAppearanceDarkLightMode()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    
    @IBAction func systemThemePreferenceAction(_ sender: Any) {
        
        if (isSystemPreferTheme){
            isSystemPreferTheme = false
            UserDefaults.standard.isSystemPrefernceTheme = false
            btnSystemPreferTheme.setImage(UIImage(named:  "Checkbox unselected"), for: .normal)
            themeSwitch.isEnabled = true
            let currentTraitCollection = UITraitCollection.current
                if currentTraitCollection.userInterfaceStyle == .light {
                    // The device is in light mode
                                  themeSwitch.isOn = false
                    UserDefaults.standard.isDarkMode = false
                } else if currentTraitCollection.userInterfaceStyle == .dark {
                    // The device is in dark mode
                                  themeSwitch.isOn = true
                    UserDefaults.standard.isDarkMode = true
                }
        }else{
            UserDefaults.standard.isSystemPrefernceTheme = true
            isSystemPreferTheme = true
            btnSystemPreferTheme.setImage(UIImage(named: "Check box selected"), for: .normal)
            themeSwitch.isEnabled = false
            self.setSystemAppearanceMode()
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        
    }
    
}
