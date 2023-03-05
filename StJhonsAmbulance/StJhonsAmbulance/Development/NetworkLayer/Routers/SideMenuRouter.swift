//
//  SideMenuRouter.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 16/02/2023.
//

import Foundation

enum SideMenuRouter: Router {
    
    case getExternalQualification(params:[String:Any])
    case getSJAQualification(params:[String:Any])
    case getAdhocHour(params:[String:Any])
    case getVolunteerHour(params:[String:Any])
    case getAvailablityHour(params:[String:Any])
    case getlanguages(params:[String:Any])
    case simulate401
    
    var procedure: String { //endpoints
        switch self {
        case .getExternalQualification: return "sjavms_verifiedqualifications"
        case .getSJAQualification: return "bdo_qualificationgaineds"
        case .getAdhocHour: return "msnfp_participationschedules"
        case .getVolunteerHour: return "msnfp_participationschedules"
        case .getAvailablityHour: return "msnfp_availabilities"
        case .getlanguages:return "stringmaps"
            
        case .simulate401: return "simulate-401"
        }
    }
    
    var params: [String : Any] {
        switch self {
        case .getExternalQualification(let params):
            return params
        case .getSJAQualification(let params):
            return params
        case .getAdhocHour(let params):
            return params
        case .getVolunteerHour(let params):
            return params
        case .getAvailablityHour(let params):
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
