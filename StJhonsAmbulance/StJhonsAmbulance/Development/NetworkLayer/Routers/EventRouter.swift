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
    
    case simulate401
    
    var procedure: String {
        switch self  {
        case .getCurrentEvent : return ""
        case .getUpcomingEvents : return ""
        case .getPastEvents : return ""
        case .getPendingApprovalEvents : return ""
        case .getPendingPublishEvents : return ""
            
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
