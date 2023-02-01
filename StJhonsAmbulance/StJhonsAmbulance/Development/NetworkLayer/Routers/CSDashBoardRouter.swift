//
//  DashBoardRouter.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 31/01/2023.
//

import Foundation

enum DashBoardRouter : Router {
    
    
    case getPendingShiftsOne(params:[String:Any])
    case getPendingShiftsTwo(params:[String:Any])
    case getPendingShiftsThree(params:[String:Any])
    case getMessages(params:[String:Any])
    case getVolunteers(params:[String:Any])
    case simulate401
    
    var procedure: String {
        switch self  {
            
            
        case .getPendingShiftsOne : return "msnfp_engagementopportunities"
        case .getPendingShiftsTwo: return "msnfp_participationschedules"
        case .getPendingShiftsThree : return "msnfp_engagementopportunityschedules"
        case .getMessages : return "emails"
        case .getVolunteers : return "msnfp_groupmemberships"
        case .simulate401: return "simulate-401"
        }
    }
    
    var params: [String : Any] {
        switch self {
        case .getPendingShiftsOne(let params):
            return params
        case .getPendingShiftsTwo(let params):
            return params
        case .getPendingShiftsThree(let params):
            return params
        case .getMessages(let params):
            return params
        case .getVolunteers(let params):
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
