//
//  EventRouter.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 31/01/2023.
//

import Foundation
enum EventRouter : Router {
    
    case getCurrentEvent(params:[String:Any])
    case getUpcomingEvents(params:[String:Any])
    case getPastEvents(params:[String:Any])
    case getPendingApprovalEvents(params:[String:Any])
    case getPendingPublishEvents(params:[String:Any])
    case getLatestUpcomingEvents(params:[String:Any])
    case getAllProgram(params:[String:Any])
    case cancelEvent(eventId:String, params:[String:Any])
    case pendingShiftUpdate(eventId:String, params:[String:Any])
    case getContactInfo(params:[String:Any])
    
    case simulate401
   
    var procedure: String {
        switch self  {
        case .getCurrentEvent : return "msnfp_engagementopportunities"
        case .getUpcomingEvents : return "msnfp_engagementopportunities"
        case .getPastEvents : return "msnfp_engagementopportunities"
        case .getPendingApprovalEvents : return "sjavms_eventrequests"
        case .getPendingPublishEvents : return "msnfp_engagementopportunities"
        case .getLatestUpcomingEvents : return "msnfp_engagementopportunities"
        case .getAllProgram : return "sjavms_programs"
        case .cancelEvent(let eventID, _) : return "msnfp_engagementopportunities(\(eventID))"
        case .pendingShiftUpdate(let eventId, _) : return "msnfp_engagementopportunities(\(eventId))"
        case .getContactInfo : return "msnfp_engagementopportunities"
            
        case .simulate401: return "simulate-401"
        }
    }
    
    var params: [String : Any] {
        switch self {
        case .getCurrentEvent(let params):
            return params
        case .getUpcomingEvents(let params):
            return params
        case .getPastEvents(let params):
            return params
        case .getPendingApprovalEvents(let params):
            return params
        case .getPendingPublishEvents(let params):
            return params
        case .getLatestUpcomingEvents(let params):
            return params
        case .getAllProgram(let params):
            return params
        case .cancelEvent(_, let params):
            return params
        case .pendingShiftUpdate(_, let params):
            return params
        case .getContactInfo(let params):
            return params
        default: return [:]
        }
        
        
    }
    
    var version: String {
        return "1"
    }
    
    var method: String {
        switch self {
        case .cancelEvent(_,_):
            return HTTPMethodType.patch.rawValue
        case .pendingShiftUpdate(_,_):
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
        case .cancelEvent(_,_):
            return .ENTJSONEncoding
        case .pendingShiftUpdate(_,_):
            return .ENTJSONEncoding
        default:
            break
        }
        return .ENTDefaultEncoding
    }
    
    
}
