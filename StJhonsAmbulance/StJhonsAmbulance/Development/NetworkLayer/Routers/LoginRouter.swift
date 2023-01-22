//
//  LoginRouter.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/21/23.
//

import Foundation

enum LoginRouter: Router {
    
    case portalAuthentication(params:PortalAuthRequest)
    case simulate401
    
    var procedure: String { //endpoints
        switch self {
        case .portalAuthentication: return "token?p=b2c_1_ropc_auth"
        case .simulate401: return "simulate-401"
        }
    }
    
    var params: [String : Any] {
        switch self {
        case .portalAuthentication(let params):
            if let model = params.encodeModel() {
                return model
            }
            return [:]
        default: return [:]
        }
    }
    
    var version: String {
        return "1"
    }
    
    var method: String {
        return HTTPMethodType.get.rawValue
    }
    
    var urlType: ENTALDBASEURLTYPE {
        return .PORTALAUTHENTICATE_BASEURL
    }
    
    var encoding: ENTALDEncodingType {
        return .ENTDefaultEncoding
    }
    
    
    
}
