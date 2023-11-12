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
    case getChatMessages(params:[String:Any])
    case saveChatMessages(params:[String:Any])
    case getMessages(params:[String:Any])
    case postMessages(params:PostGroupMessageRequestModel)
    case postAddAvailability(params:PostAddAvailabilityRequestModel)
    case getVolunteers(params:[String:Any])
    case getVolunteersOfEvent(params:[String:Any])
    case getDashboardTilesOrder(params:[String:Any])
    case saveDashboardTilesOrder(params:[String:Any])
    case updateDashboardTilesOrder(orderId:String, params:[String:Any])
    case simulate401
    
    var procedure: String {
        switch self  {
            
            
        case .getPendingShiftsOne : return "msnfp_engagementopportunities"
        case .getPendingShiftsTwo: return "msnfp_participationschedules"
        case .getPendingShiftsThree : return "msnfp_engagementopportunityschedules"
        case .getMessages : return "emails"
        case .getChatMessages : return "sjavms_inappmessages"
        case .saveChatMessages : return "sjavms_inappmessages"
        case .postMessages : return "emails"
        case .postAddAvailability : return "msnfp_availabilities"
        case .getVolunteers : return "sjavms_groupmemberships"
        case .getVolunteersOfEvent : return "msnfp_participationschedules"
        case .getDashboardTilesOrder : return "sjavms_dashboard_orders"
        case .saveDashboardTilesOrder : return "sjavms_dashboard_orders"
        case .updateDashboardTilesOrder(let orderId, _) : return "sjavms_dashboard_orders(\(orderId))"
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
        case .getChatMessages(let params):
            return params
        case .saveChatMessages(let params):
            return params
        case .getMessages(let params):
            return params
        case .postMessages(let params):
            if let model = params.encodeModel() {
                return model
            }
            return [:]
        case .postAddAvailability(let params):
            if let model = params.encodeModel() {
                return model
            }
            return [:]
        case .getVolunteers(let params):
            return params
        case .getVolunteersOfEvent(let params):
            return params
        case .getDashboardTilesOrder(let params):
            return params
        case .saveDashboardTilesOrder(let params):
            return params
        case .updateDashboardTilesOrder(_, let params):
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
        case .postAddAvailability(_):
            return HTTPMethodType.post.rawValue
        case .saveDashboardTilesOrder(_):
            return HTTPMethodType.post.rawValue
        case .saveChatMessages(_):
            return HTTPMethodType.post.rawValue
        case .updateDashboardTilesOrder(_,_):
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
        case .postMessages(_):
            return .ENTJSONEncoding
        case .postAddAvailability(_):
            return .ENTJSONEncoding
        case .saveDashboardTilesOrder(_):
            return .ENTJSONEncoding
        case .saveChatMessages(_):
            return .ENTJSONEncoding
        case .updateDashboardTilesOrder(_,_):
            return .ENTJSONEncoding
        default:
            break
        }
        return .ENTDefaultEncoding
    }
    
    
}
