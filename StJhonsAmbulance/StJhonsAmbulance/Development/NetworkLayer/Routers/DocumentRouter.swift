//
//  DocumentRouter.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 18/04/2023.
//

import Foundation

enum DocumentRouter: Router {
    
    case getContactDocuments(params:[String:Any])
    case getContactDocumentstwoEvent(participationId:String)

    
    case simulate401
    
    var procedure: String { //endpoints
        switch self {
        case .getContactDocuments: return "sharepointdocumentlocations"
        case .getContactDocumentstwoEvent(let participationId) : return "GetFolderByServerRelativePath(decodedurl='/sites/VMSSandbox/contact/\(participationId)')/files"
           
        case .simulate401: return "simulate-401"
        }
    }
    
    var params: [String : Any] {
        switch self {
        case .getContactDocuments(let params):
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
        switch self{
             case .getContactDocumentstwoEvent:
                 return .SAINJOHN_DOCUMENT_URL
             default:
                 break
             }
        return .SAINJOHN_BASEURL
    }
    
    var encoding: ENTALDEncodingType {
        return .ENTDefaultEncoding
    }
    
    
    
}
