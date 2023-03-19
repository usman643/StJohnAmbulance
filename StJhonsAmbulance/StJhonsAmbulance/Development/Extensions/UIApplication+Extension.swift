//
//  UIApplication+Extension.swift
//  THERMS On-Duty
//
//  Created by Muhammad Usman on 05/12/2021.
//

import Foundation
import UIKit

extension UIApplication {
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    
    class func getLastViewController(base: UIViewController? = UIApplication.shared.windows.last?.rootViewController) -> UIViewController? {
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.last
        if let nav = base as? UINavigationController {
            return nav.visibleViewController
        }
        

        
        return UIViewController()
    }
    
    class func topNavigation(_ viewController: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> ENTALDBaseNavigationController? {
        
        if let nav = viewController as? ENTALDBaseNavigationController {
            return nav
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return selected.navigationController as? ENTALDBaseNavigationController
            }
        }
        if let presented = viewController?.presentedViewController {
            return topNavigation(presented)
        }
        
        
        return viewController?.navigationController as? ENTALDBaseNavigationController
    }
    
    class func visibleController()->UIViewController?{
        let root = sceneDelegate?.window?.rootViewController
        return UIApplication.getTopViewController(base: root)
    }
    
    //// Right to left
    static var isRTL: Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == UIUserInterfaceLayoutDirection.rightToLeft
    }
    //// Left to right
    static var isLTR: Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == UIUserInterfaceLayoutDirection.leftToRight
    }
    
    static var appVersion: String {
        if let infoDic = Bundle.main.infoDictionary, let version = infoDic["CFBundleShortVersionString"] as? String {
            return version
        }
        return ""
    }
    
    static var appName: String {
        if let infoDic = Bundle.main.infoDictionary, let name = infoDic["CFBundleName"] as? String {
            return name
        }
        return ""
    }
   
}
