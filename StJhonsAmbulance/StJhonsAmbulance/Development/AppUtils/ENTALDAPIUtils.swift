//
//  ENTALDAPIUtils.swift
//  ENTALDO
//
//  Created by M.Usman on 25/04/2022.
//

import Foundation

enum ENTALDBASEURLTYPE {
    case ENTALDBASEURLTYPE_BASEURL
}

class ENTALDAPIUtils {
    
    static let shared : ENTALDAPIUtils = ENTALDAPIUtils()
    
    private init() {
        
    }
    
    func getBaseUrlByType(baseType:ENTALDBASEURLTYPE)->URL?{
        switch baseType {
        case .ENTALDBASEURLTYPE_BASEURL:
            return self.getBaseURL()
            
        }
    }
    
    private func getBaseURL()->URL?{
        if let urlStr = ENTALDAPIConfig.shared.baseUrl, urlStr != "", let baseURL = URL(string: urlStr){
            return baseURL
        }
        return nil
    }
    
    func getCompleteUrlBytype(urlType:ENTALDBASEURLTYPE, andPath:String)->URL?{
        guard let baseUrl = self.getBaseUrlByType(baseType: urlType) else {return nil}
        let completeUrl = URL(string: "\(baseUrl.absoluteString)\(andPath)")
        return completeUrl
    }
    
    func statusInRange(code:Int)->Bool{
        if code >= 200 && code <= 299 {
            return true
        }
        return false
    }
    
}
