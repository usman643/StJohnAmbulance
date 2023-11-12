//
//  ENTALDBaseViewController.swift
//  ENTALDO
//
//  Created by M.Usman on 23/04/2022.
//

import UIKit
import SideMenu
import IQKeyboardManagerSwift

enum RefreshDataObserverType{
    
}

class ENTALDBaseViewController: UIViewController, MenuControllerDelegate {
   
    
    
    var sideMenu: SideMenuVC?
    var menu: SideMenuNavigationController?
    var callbackToController : ControllerCallBackCompletion?
    var dataModel: Any?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        let currentTraitCollection = UITraitCollection.current
        if (UserDefaults.standard.isSystemPrefernceTheme == true){
            if currentTraitCollection.userInterfaceStyle == .light {
                return .darkContent
            } else if currentTraitCollection.userInterfaceStyle == .dark {
                return .lightContent
            }
        }else{
            return UserDefaults.standard.isDarkMode ? .lightContent : .darkContent
        }
        return .lightContent
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerReloadDataNotifications()
        self.setSideMenu(reference: self)
        self.navigationController?.navigationBar.isHidden = true
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        if (UserDefaults.standard.isSystemPrefernceTheme == true){
            setSystemAppearanceMode()
        }else{
            setAppearanceDarkLightMode()
        }
    }
    
    func didSelectMenuItem(named: String) {
        
        if (named == "Home") {
            dismiss(animated: true)
//            let vc = HomeVC(nibName: "HomeVC", bundle: nil)
//            self.navigationController?.pushViewController(vc , animated: true)
            self.navigationController?.popToRootViewController(animated: true)
        }else if(named == "Profile"){
            
            ENTALDControllers.shared.showContactInfoScreen(type: .ENTALDPUSH, from: self, callBack: nil)
                        
        }else if(named == "Qualifications"){
            
            ENTALDControllers.shared.showSideMenuQualificationScreen(type: .ENTALDPUSH, from: self,  callBack: nil)
                        
        }else if(named == "Availability"){
            
            ENTALDControllers.shared.showSideMenuAvailabilityScreen(type: .ENTALDPUSH, from: self, callBack: nil)
            
        }else if(named == "Skills"){
            
            ENTALDControllers.shared.showSideMenuSkillsScreen(type: .ENTALDPUSH, from: self,  callBack: nil)
                        
        }else if(named == "Awards"){
            
            ENTALDControllers.shared.showAwardScreen(type: .ENTALDPUSH, from: self, dataObj: nil, callBack: nil)
                        
        }else if(named == "Language"){
            
            ENTALDControllers.shared.showLanguageScreen(type: .ENTALDPUSH, from: self,  callBack: nil)
                        
        }else if(named == "Settings"){
            
            ENTALDControllers.shared.showSettingScreen(type: .ENTALDPUSH, from: self,  callBack: nil)
                        
        }else if(named == "Change Password"){
            
            ENTALDControllers.shared.showUpdatePasswordScreen(type: .ENTALDPUSH, from: self, callBack: nil)
        }else if(named == "Documents"){
            ENTALDControllers.shared.showContactDocumentScreen(type: .ENTALDPUSH, from: self, callBack: nil)
//            ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: { status in })
        }else if(named == "Shifts"){
            
            ENTALDControllers.shared.showPendingShiftScreen(type: .ENTALDPUSH, from: self, callBack: nil)
        }else if(named == "Event"){
            
            ENTALDControllers.shared.showCSLeadEventVC(type: .ENTALDPUSH, from: self, callBack: nil)
        }else if(named == "Volunteers"){
            
            ENTALDControllers.shared.showVolunteersScreen(type: .ENTALDPUSH, from: self, callBack: nil)

        }else if(named == "Logout"){
            
            UserDefaults.standard.signOut()
            
        }else{
            
            dismiss(animated: true)
        }
    }
    
    func setSideMenu( reference : UIViewController){
        
        self.sideMenu = SideMenuVC()
        if let list = sideMenu {
            
            list.delegate = self
            self.menu = SideMenuNavigationController(rootViewController: list)
            self.menu?.leftSide = true
            self.menu?.setNavigationBarHidden(true, animated: true)
            self.menu?.menuWidth = view.bounds.width * 0.8
            SideMenuManager.default.leftMenuNavigationController = menu
//            SideMenuManager.default.addPanGestureToPresent(toView: self.view)
            
        }
    }
        
    func setAppearanceDarkLightMode() {
        UITabBar.appearance().overrideUserInterfaceStyle = UserDefaults.standard.isDarkMode ? .dark : .light
        UIView.appearance().overrideUserInterfaceStyle = UserDefaults.standard.isDarkMode ? .dark : .light
        UINavigationBar.appearance().overrideUserInterfaceStyle = UserDefaults.standard.isDarkMode ? .dark : .light
        let windows = UIApplication.shared.windows
        for window in windows {
            if NSStringFromClass(window.classForCoder) == "UITextEffectsWindow" {
                    NSLog("===== Ignore UITextEffectsWindow")

                    return
                }
            for view in window.subviews {
                view.removeFromSuperview()
                window.addSubview(view)
            }
        }
    }
    
    
func setSystemAppearanceMode() {
    let currentTraitCollection = UITraitCollection.current
    if currentTraitCollection.userInterfaceStyle == .light {
        
        UITabBar.appearance().overrideUserInterfaceStyle = .light
        UIView.appearance().overrideUserInterfaceStyle = .light
        UINavigationBar.appearance().overrideUserInterfaceStyle = .light
        
    } else if currentTraitCollection.userInterfaceStyle == .dark {
        UITabBar.appearance().overrideUserInterfaceStyle = .dark
        UIView.appearance().overrideUserInterfaceStyle = .dark
        UINavigationBar.appearance().overrideUserInterfaceStyle = .dark

    }
    
    self.setNeedsStatusBarAppearanceUpdate()

//    let windows = UIApplication.shared.windows
//    for window in windows {
//        if NSStringFromClass(window.classForCoder) == "UITextEffectsWindow" {
//                NSLog("===== Ignore UITextEffectsWindow")
//
//                return
//            }
//        for view in window.subviews {
//            view.removeFromSuperview()
//            window.addSubview(view)
//        }
//    }
    
}
    
    private func registerReloadDataNotifications(){
//        NotificationCenter.default.addObserver(self, selector: #selector(userDidChangedStatus), name: Notification.Name(rawValue: ObserverNameConstants.nameStatusChangedNotification), object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(userDidUpdateLocationPermission), name: Notification.Name(rawValue: ObserverNameConstants.locationStatusUpdated), object: nil)
        
    }
    
    @objc
    func userDidChangedStatus(){
        
    }
    
    @objc
    func userDidUpdateLocationPermission(){
        
    }
    
}

extension ENTALDBaseViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
