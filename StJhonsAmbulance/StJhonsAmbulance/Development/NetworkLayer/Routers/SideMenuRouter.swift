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
    case getPreffferedLanguages(params:[String:Any])
    case getQualificationsType(params:[String:Any])
    case updateAvailability(availabilityid:String, params:[String:Any])
    case simulate401
    
    var procedure: String { //endpoints
        switch self {
        case .getExternalQualification: return "sjavms_verifiedqualifications"
        case .getSJAQualification: return "bdo_qualificationgaineds"
        case .getAdhocHour: return "msnfp_participationschedules"
        case .getVolunteerHour: return "msnfp_participationschedules"
        case .getAvailablityHour: return "msnfp_availabilities"
        case .getlanguages:return "stringmaps"
        case .getPreffferedLanguages:return "adx_portallanguages"
        case .getQualificationsType: return "stringmaps"
        case .updateAvailability(let availabilityid, _) : return "msnfp_availabilities(\(availabilityid))"
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
        case .getQualificationsType(let params):
            return params
        case .getPreffferedLanguages(let params):
            return params
        case .getlanguages(let params):
            return params
        case .updateAvailability(_, let params):
            return params
        default: return [:]
        }
    }
    
    var version: String {
        return "1"
    }
    
    var method: String {
        switch self {
        case .updateAvailability(_,_):
            return HTTPMethodType.patch.rawValue
        default:
            break
        }
        return HTTPMethodType.get.rawValue
    }
    
    var urlType: ENTALDBASEURLTYPE {
        return .SAINJOHN_BASEURL
    }
    
    var encoding: ENTALDEncodingType {
        switch self {
        case .updateAvailability(_,_):
            return .ENTJSONEncoding
        default:
            break
        }
        return .ENTDefaultEncoding
    }
    
    
    
}
