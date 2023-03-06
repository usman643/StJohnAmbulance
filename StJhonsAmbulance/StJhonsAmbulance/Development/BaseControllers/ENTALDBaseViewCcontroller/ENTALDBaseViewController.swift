//
//  ENTALDBaseViewController.swift
//  ENTALDO
//
//  Created by M.Usman on 23/04/2022.
//

import UIKit

enum RefreshDataObserverType{
    
}

class ENTALDBaseViewController: UIViewController {
    
    var callbackToController : ControllerCallBackCompletion?
    var dataModel: Any?
    
    /// Appearance to be applied for navigation bar.
//    private lazy var navBarAppearance: UINavigationBarAppearance = {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithTransparentBackground()
//        appearance.shadowImage = UIImage()
//        appearance.shadowColor = nil
//        appearance.backgroundColor = .clear
//
//        return appearance
//    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerReloadDataNotifications()
//        setAppearanceDarkLightMode()
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        navigationController?.navigationBar.compactAppearance = navBarAppearance
//        navigationController?.navigationBar.standardAppearance = navBarAppearance
//        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        self.navigationController?.navigationBar.isHidden = true
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
