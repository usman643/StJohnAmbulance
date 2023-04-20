//
//  ENTALDAPIUtils.swift
//  ENTALDO
//
//  Created by M.Usman on 25/04/2022.
//

import Foundation

enum ENTALDBASEURLTYPE {
    case PORTALAUTHENTICATE_BASEURL
    case DYNAMICAUTHENTICATE_BASEURL
    case SAINJOHN_BASEURL
    case SAINJOHN_DOCUMENT_URL
    case SAINJOHN_BASEURL_Api
    case SAINJOHN_DOCUMENT_AUTH_URL
}

class ENTALDAPIUtils {
    
    static let shared : ENTALDAPIUtils = ENTALDAPIUtils()
    
    private init() {
        
    }
    
    func getBaseUrlByType(baseType:ENTALDBASEURLTYPE)->URL?{
        switch baseType {
        case .PORTALAUTHENTICATE_BASEURL:
            return self.getPortalAuthBaseURL()
        case .DYNAMICAUTHENTICATE_BASEURL:
            return self.getDynamicAuthBaseURL()
        case .SAINJOHN_BASEURL:
            return self.getBaseURL()
        case .SAINJOHN_DOCUMENT_URL:
            return self.getDocumentURLAPI()
        case .SAINJOHN_BASEURL_Api:
            return self.getBaseURLAPI()
        case .SAINJOHN_DOCUMENT_AUTH_URL:
            return self.getDocumentAuthURL()
            
        }
    }
    
    private func getDocumentAuthURL()->URL?{
        if let urlStr = ENTALDAPIConfig.shared.documentAuthURL, urlStr != "", let baseURL = URL(string: urlStr){
            return baseURL
        }
        return nil
    }
    
    private func getBaseURLAPI()->URL?{
        if let urlStr = ENTALDAPIConfig.shared.baseURLAPI, urlStr != "", let baseURL = URL(string: urlStr){
            return baseURL
        }
        return nil
    }
    
    private func getDocumentURLAPI()->URL?{
        if let urlStr = ENTALDAPIConfig.shared.documentURLAPI, urlStr != "", let baseURL = URL(string: urlStr){
            return baseURL
        }
        return nil
    }

    private func getBaseURL()->URL?{
        if let urlStr = ENTALDAPIConfig.shared.baseURL, urlStr != "", let baseURL = URL(string: urlStr){
            return baseURL
        }
        return nil
    }
    
    private func getPortalAuthBaseURL()->URL?{
        if let urlStr = ENTALDAPIConfig.shared.portalAuthenticateBaseUrl, urlStr != "", let baseURL = URL(string: urlStr){
            return baseURL
        }
        return nil
    }
    
    private func getDynamicAuthBaseURL()->URL?{
        if let urlStr = ENTALDAPIConfig.shared.dynamicAuthenticateBaseUrl, urlStr != "", let baseURL = URL(string: urlStr){
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
    
    func getJWTToken(accessToken:String)->String?{
        do {
            let jwt = try Jwt.decode(withToken: accessToken, andKey: nil, andVerify: false)
            print("JWT dictionary \(jwt)")
            if let sub = jwt["sub"] as? String {
                return sub
            }
        }catch(let err){
            print("jwt error \(err.localizedDescription)")
        }
        return nil
    }
    
}
