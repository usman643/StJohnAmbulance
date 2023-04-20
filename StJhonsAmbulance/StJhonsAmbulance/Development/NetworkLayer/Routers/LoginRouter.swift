//
//  LoginRouter.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/21/23.
//

import Foundation

enum LoginRouter: Router {
    
    case portalAuthentication(params:PortalAuthRequest)
    case dynamicAuthentication(params:DynamicAuthRequest)
    case getExternalIdentity(subId:String)
    case getUserIdentity(conId:String)
    case updateUserIdentity(conId:String,  params:[String:Any])
    case getDocumentToken(params:DynamicAuthRequest)
    case simulate401
    
    var procedure: String { //endpoints
        switch self {
        case .portalAuthentication: return "token?p=b2c_1_ropc_auth"
        case .dynamicAuthentication: return "token"
        case .getExternalIdentity: return "adx_externalidentities"
        case .getDocumentToken: return ""
        case .getUserIdentity(let conId):
            return "contacts(\(conId))"
        case .updateUserIdentity(let conId, _):
            return "contacts(\(conId))"
            
        case .simulate401: return "simulate-401"
        }
    }
    
    var params: [String : Any] {
        switch self {
        case .portalAuthentication(let params):
            if let model = params.encodeModel() {
                return model
            }
            return [:]
        case .dynamicAuthentication(let params), .getDocumentToken(let params):
            if let model = params.encodeModel() {
                return model
            }
            return [:]
        case .getExternalIdentity(let subId):
            return [ParameterKeys.filter:"adx_username eq \(subId)"]
            
        case .updateUserIdentity(_, let params):
            return params
        
        default: return [:]
        }
    }
    
    var version: String {
        return "1"
    }
    
    var method: String {
        switch self {
        case .portalAuthentication(_):
            return HTTPMethodType.post.rawValue
        case .dynamicAuthentication(_):
            return HTTPMethodType.post.rawValue
        case .updateUserIdentity(_,_):
            return HTTPMethodType.patch.rawValue
        case .getDocumentToken:
            return HTTPMethodType.post.rawValue
        default:
            break
        }
        return HTTPMethodType.get.rawValue
    }
    
    var urlType: ENTALDBASEURLTYPE {
        switch self {
        case .portalAuthentication(_):
            return .PORTALAUTHENTICATE_BASEURL
        case .dynamicAuthentication(_):
            return .DYNAMICAUTHENTICATE_BASEURL
        case .getDocumentToken:
            return .SAINJOHN_DOCUMENT_AUTH_URL
        default:
            break
        }
        return .SAINJOHN_BASEURL
    }
    
    var encoding: ENTALDEncodingType {
        switch self {
        case .updateUserIdentity(_,_):
            return .ENTJSONEncoding
        default:
            break
        }
        
        return .ENTDefaultEncoding
    }
    
    
    
}
