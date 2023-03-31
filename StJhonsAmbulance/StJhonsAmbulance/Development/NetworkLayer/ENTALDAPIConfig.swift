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
    
    var baseURLAPI : String?
    var baseURL : String?
    var portalAuthenticateBaseUrl : String?
    var dynamicAuthenticateBaseUrl : String?
    
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
        ENTALDAPIConfig.shared.baseURLAPI = "https://sja-sandbox.api.crm3.dynamics.com/api/data/v9.2/"
        ENTALDAPIConfig.shared.baseURL = "https://sja-sandbox.crm3.dynamics.com/api/data/v9.2/"
        ENTALDAPIConfig.shared.portalAuthenticateBaseUrl = "https://sjasandbox.b2clogin.com/sjasandbox.onmicrosoft.com/oauth2/v2.0/"
        ENTALDAPIConfig.shared.dynamicAuthenticateBaseUrl = "https://login.microsoftonline.com/4eb3d202-86fa-4a81-b4de-47e3389ef4d0/oauth2/"
    
    }
    
    
    private func setLiveAPIConstants(){
        ENTALDAPIConfig.shared.baseURLAPI = "https://sja-sandbox.api.crm3.dynamics.com/api/data/v9.2/"
        ENTALDAPIConfig.shared.baseURL = "https://sja-sandbox.crm3.dynamics.com/api/data/v9.2/"
        ENTALDAPIConfig.shared.portalAuthenticateBaseUrl = "https://sjasandbox.b2clogin.com/sjasandbox.onmicrosoft.com/oauth2/v2.0/"
        ENTALDAPIConfig.shared.dynamicAuthenticateBaseUrl = "https://login.microsoftonline.com/4eb3d202-86fa-4a81-b4de-47e3389ef4d0/oauth2/"
    }
    
}
