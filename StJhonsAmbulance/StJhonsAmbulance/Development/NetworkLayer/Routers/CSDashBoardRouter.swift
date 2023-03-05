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
    case postMessages(params:PostGroupMessageRequestModel)
    case getVolunteers(params:[String:Any])
    case getVolunteersOfEvent(params:[String:Any])
    case simulate401
    
    var procedure: String {
        switch self  {
            
            
        case .getPendingShiftsOne : return "msnfp_engagementopportunities"
        case .getPendingShiftsTwo: return "msnfp_participationschedules"
        case .getPendingShiftsThree : return "msnfp_engagementopportunityschedules"
        case .getMessages : return "emails"
        case .postMessages : return "emails"
        case .getVolunteers : return "msnfp_groupmemberships"
        case .getVolunteersOfEvent : return "msnfp_participationschedules"
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
        case .postMessages(let params):
            if let model = params.encodeModel() {
                return model
            }
            return [:]
        case .getVolunteers(let params):
            return params
        case .getVolunteersOfEvent(let params):
            return params
        default: return [:]
        }
        
        
    }
    
    var version: String {
        return "1"
    }
    
    var method: String {
        switch self {
        case .postMessages(_):
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
        case .postMessages(_):
            return .ENTJSONEncoding
        default:
            break
        }
        return .ENTDefaultEncoding
    }
    
    
}
