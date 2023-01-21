//
//  LoginRouter.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/21/23.
//

import Foundation

enum LoginRouter: Router {
    
    case getPostList
    case simulate401
    
    var procedure: String { //endpoints
        switch self {
        case .getPostList: return "posts"
        case .simulate401: return "simulate-401"
        }
    }
    
    var params: [String : Any] {
        switch self {
        case .getPostList:
            return [:]
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
        return .ENTALDBASEURLTYPE_BASEURL
    }
    
    var encoding: ENTALDEncodingType {
        return .ENTJSONEncoding
    }
    
    
    
}
