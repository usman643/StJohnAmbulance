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
    case getTherapyDogId(params:[String:Any])
    case getTherapyDogFacility(params:[String:Any])
    case getAdhocHourVoluneteerEvent(params:[String:Any])
    case getNonAdhocHourVoluneteerEvent(params:[String:Any])
    case createAdhocHour(params:[String:Any])
    case createNonAdhocHour(params:[String:Any])
    case updateAvailability(availabilityid:String, params:[String:Any])
    case updateVolunteerShift(shiftId:String, params:[String:Any])
    
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
        case .getTherapyDogId: return "sjavms_vmstherapydogs"
        case .getTherapyDogFacility: return "accounts"
        case .getAdhocHourVoluneteerEvent: return "msnfp_engagementopportunities"
        case .createAdhocHour: return "sjavms_adhochourses"
        case .createNonAdhocHour: return "sjavms_adhochourses"
        case .getNonAdhocHourVoluneteerEvent: return "msnfp_engagementopportunities"
        case .updateAvailability(let availabilityid, _) : return "msnfp_availabilities(\(availabilityid))"
        case .updateVolunteerShift(let shiftId, _) : return "msnfp_participationschedules(\(shiftId))"
            
            
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
        case .getTherapyDogId(let params):
            return params
        case .getTherapyDogFacility(let params):
            return params
        case .getAdhocHourVoluneteerEvent(let params):
            return params
        case .getNonAdhocHourVoluneteerEvent(let params):
            return params
        case .createAdhocHour(let params):
            return params
        case .createNonAdhocHour(let params):
            return params
        case .updateAvailability(_, let params):
            return params
        case .updateVolunteerShift(_, let params):
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
        case .updateVolunteerShift(_,_):
            return HTTPMethodType.patch.rawValue
        case .createAdhocHour(_):
            return HTTPMethodType.post.rawValue
        case .createNonAdhocHour(_):
            return HTTPMethodType.post.rawValue
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
        case .updateVolunteerShift(_,_):
            return .ENTJSONEncoding
        case .createAdhocHour(_):
            return .ENTJSONEncoding
        case .createNonAdhocHour(_):
            return .ENTJSONEncoding
        default:
            break
        }
        return .ENTDefaultEncoding
    }
    
    
    
}
