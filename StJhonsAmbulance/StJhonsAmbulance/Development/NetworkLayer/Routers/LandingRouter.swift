//
//  LandingRouter.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/23/23.
//

import Foundation

enum LandingRouter: Router {
    
    case getAssiciatedGroups(params:[String:Any])
    case simulate401
    
    var procedure: String { //endpoints
        switch self {
        case .getAssiciatedGroups: return "msnfp_groupmemberships"
            
        case .simulate401: return "simulate-401"
        }
    }
    
    var params: [String : Any] {
        switch self {
        case .getAssiciatedGroups(let params):
            return params
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
        return .SAINJOHN_BASEURL
    }
    
    var encoding: ENTALDEncodingType {
        return .ENTDefaultEncoding
    }
    
    
    
}
