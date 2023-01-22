//
//  ENTALDAPPConfig.swift
//  ENTALDO
//
//  Created by M.Usman on 23/04/2022.
//

import Foundation
import UIKit

class ENTALDAppConfig {

    static let shared : ENTALDAppConfig = ENTALDAppConfig()
    
    private init(){
        
    }
    
    func showAppLaunch(){
        ENTALDControllers.shared.setupHomeViewController(from: UIApplication.getTopViewController(), callBack: nil)
    }
    
    
    
}
