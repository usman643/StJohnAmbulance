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
    
    var baseUrl : String?
    var onlineOffer_Python_URL : String?
    
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
        ENTALDAPIConfig.shared.baseUrl = "https://apidvb2baldpy.etenvbiz.com/api_adr/v2/"
        
    }
    
    
    private func setLiveAPIConstants(){
        ENTALDAPIConfig.shared.baseUrl = "https://apidvb2baldpy.etenvbiz.com/api_adr/v2/"
        
    }
    
}
