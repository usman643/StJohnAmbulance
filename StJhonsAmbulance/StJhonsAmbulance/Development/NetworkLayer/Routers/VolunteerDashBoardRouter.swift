//
//  VolunteerDashBoardRouter.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 07/02/2023.
//

import Foundation

enum VolunteerDashBoardRouter : Router {
    
    
    case getScheduleOne(params:[String:Any])
    case getScheduleTwo(params:[String:Any])
    case getScheduleThree(params:[String:Any])
    case getMessages(params:[String:Any])
    case getContact(params:[String:Any])
    case getEvent(params:[String:Any])
    case getNonEvent(params:[String:Any])
    case getAwards(params:[String:Any])
    case getVolunteerPastEvent(params:[String:Any])
    case getVolunteerAvailableEvent(params:[String:Any])
    case getVolunteerEvent(params:[String:Any])
    case simulate401
    
    var procedure: String {
        switch self  {
            
            
        case .getScheduleOne : return "msnfp_groupmemberships"
        case .getScheduleTwo: return "msnfp_engagementopportunities"
        case .getScheduleThree : return "msnfp_participationschedules"
        case .getVolunteerPastEvent : return "msnfp_participationschedules"
        case .getVolunteerAvailableEvent : return "msnfp_engagementopportunities"
        case .getVolunteerEvent : return "msnfp_participationschedules"
        case .getEvent : return "msnfp_participationschedules"
        case .getNonEvent : return "msnfp_participationschedules"
        case .getMessages : return "emails"
        case .getContact : return "contacts"
        case .getAwards : return "msnfp_awardversions"
            
            
            
        case .simulate401: return "simulate-401"
        }
    }
    
    var params: [String : Any] {
        switch self {
        case .getScheduleOne(let params):
            return params
        case .getScheduleTwo(let params):
            return params
        case .getScheduleThree(let params):
            return params
        case .getEvent(let params):
            return params
        case .getNonEvent(let params):
            return params
        case .getMessages(let params):
            return params
        case .getContact(let params):
            return params
        case .getAwards(let params):
            return params
        case .getVolunteerPastEvent(let params):
            return params
        case .getVolunteerEvent(let params):
            return params
         case .getVolunteerAvailableEvent(let params):
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
