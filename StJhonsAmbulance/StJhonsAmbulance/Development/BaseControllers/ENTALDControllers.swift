//
//  ENTALDControllers.swift
//  ENTALDO
//
//  Created by M.Usman on 23/04/2022.
//

import Foundation
import UIKit

enum ENTALDControllerType {
    case ENTALDPUSH
    case ENTALDPRESENT
    case ENTALDPUSH_WO_ANIM
    case ENTALDPRESENT_WO_ANIM
    case ENTALDTABBARVC
    case ENTALDMODAL_PRESENT
    case ENTALDPRESENT_OVER_CONTEXT
    case ENTALDPRESENT_POPOVER
}

class ENTALDControllers {
    static let shared : ENTALDControllers = ENTALDControllers()
    
    private init(){
        
    }
    
    func setupHomeViewController(from:UIViewController?, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?){
        self.startFlowFromSplash(from: from, dataObj, callBack: callBack)
    }
    
    func startFlowFromSplash(from:UIViewController?, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?){
        
        if ENTALDHelperUtils.isUserLoggedIn() {
            
//            self.showTabbarViewController(type: .ENTALDPUSH, from: UIApplication.getTopViewController()) { params, controller in
//
//            }
            
            self.showLandingScreen(type: .ENTALDPUSH, from: UIApplication.getTopViewController()) { params, controller in

            }
        }else{
            self.showLoginScreen(type: .ENTALDPUSH, from: UIApplication.getTopViewController()) { params, controller in
                
            }
        }
    }
    
    func showLoginScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = LoginVC.loadFromNib()
        
        let nav = ENTALDBaseNavigationController(rootViewController: vc)
        
        if let window = sceneDelegate?.window{
            window.rootViewController = nav
            window.makeKeyAndVisible()
            window.windowLevel = .normal
        }
    }
    
    func showLandingScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = LandingVC.loadFromNib()
        
        let nav = ENTALDBaseNavigationController(rootViewController: vc)
        
        if let window = sceneDelegate?.window{
            window.rootViewController = nav
            window.makeKeyAndVisible()
            window.windowLevel = .normal
        }
    }
    
    func showTabbarViewController(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?){
        
        let tabbar = ENTALDTabbarViewController()
        tabbar.callbackToController = callBack
        
        let nav = ENTALDBaseNavigationController(rootViewController: tabbar)
        
        if let window = sceneDelegate?.window{
            window.rootViewController = nav
            window.makeKeyAndVisible()
            window.windowLevel = .normal
        }
    }
    
    
    
    private func showViewController(navRoot: Bool, type: ENTALDControllerType, destination: ENTALDBaseViewController, from: UIViewController? = nil, isDisplayonTop:Bool = false, completion: (() -> ())? = nil) {
    
        let isAnimation = type == .ENTALDPRESENT || type == .ENTALDPUSH
        
        if navRoot {
            let navController : ENTALDBaseNavigationController = ENTALDBaseNavigationController(rootViewController: destination)
            
            if destination.definesPresentationContext == true && destination.providesPresentationContextTransitionStyle == true {
                navController.modalPresentationStyle = .overCurrentContext
            }
            
            if type == .ENTALDPUSH || type == .ENTALDPUSH_WO_ANIM {
                from?.navigationController?.pushViewController(destination, animated: isAnimation)
            } else if type == .ENTALDPRESENT || type == .ENTALDPRESENT_WO_ANIM {
                if isDisplayonTop {
                    UIApplication.getTopViewController()?.present(navController, animated: isAnimation, completion: nil)
                }else{
                    navController.modalPresentationStyle = .fullScreen
                    from?.present(navController, animated: isAnimation, completion: completion)
                }
            }else if type == .ENTALDPRESENT_OVER_CONTEXT {
                navController.modalPresentationStyle = .overCurrentContext
                from?.present(navController, animated: isAnimation, completion: completion)
            }
        } else {
            destination.modalPresentationStyle = .fullScreen
            if type == .ENTALDPUSH || type == .ENTALDPUSH_WO_ANIM {
                from?.navigationController?.pushViewController(destination, animated: isAnimation)
            }else if type == .ENTALDPRESENT || type == .ENTALDPRESENT_WO_ANIM {
                if isDisplayonTop {
                    UIApplication.getTopViewController()?.present(destination, animated: isAnimation, completion: nil)
                }else{
                    from?.present(destination, animated: isAnimation, completion: completion)
                }
            }else if type == .ENTALDMODAL_PRESENT {
//                [controller presentPanModal:actionController];
            }else if type == .ENTALDPRESENT_OVER_CONTEXT {
                destination.modalPresentationStyle = .overCurrentContext
                from?.present(destination, animated: isAnimation, completion: completion)
            }else if type == .ENTALDPRESENT_POPOVER {
                destination.modalPresentationStyle = .popover
                from?.present(destination, animated: isAnimation, completion: completion)
            }
        }
    }
    
}
