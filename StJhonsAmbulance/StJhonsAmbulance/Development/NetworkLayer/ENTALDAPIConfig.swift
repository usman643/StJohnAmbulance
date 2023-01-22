//
//  ENTALDAPIConfig.swift
//  ENTALDO
//
//  Created by M.Usman on 23/04/2022.
//

import Foundation

enum ENTALDSERVERTYPE {
    case DEV
    case LIVE
}

class ENTALDAPIConfig {
    
    static let shared : ENTALDAPIConfig = ENTALDAPIConfig()
    
    var portalAuthenticateBaseUrl : String?
    
    private init(){
        
    }
    
    var environment : ENTALDSERVERTYPE = .DEV
    
    func setEnvironmentVariable(){
        switch self.environment {
        case .DEV:
            self.setDevAPIConstants()
        case .LIVE:
            self.setLiveAPIConstants()
        }
    }
    
    
}

extension ENTALDAPIConfig {
    private func setDevAPIConstants(){
        ENTALDAPIConfig.shared.portalAuthenticateBaseUrl = "https://sjasandbox.b2clogin.com/sjasandbox.onmicrosoft.com/oauth2/v2.0/"
        
    }
    
    
    private func setLiveAPIConstants(){
        ENTALDAPIConfig.shared.portalAuthenticateBaseUrl = "https://sjasandbox.b2clogin.com/sjasandbox.onmicrosoft.com/oauth2/v2.0/"
        
    }
    
}
