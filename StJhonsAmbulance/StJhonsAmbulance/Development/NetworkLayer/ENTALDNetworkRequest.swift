//
//  ENTALDNetworkRequest.swift
//  ENTALDO
//
//  Created by M.Usman on 25/04/2022.
//

import Foundation
import Alamofire

enum ENTALDEncodingType {
    case ENTDefaultEncoding
    case ENTJSONEncoding
    
    func getENcodingType() -> ParameterEncoding{
        switch self {
        case .ENTDefaultEncoding :
            return URLEncoding.default
        case .ENTJSONEncoding :
            return JSONEncoding.default
        }
    }
}

class ENTALDConnectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class ENTALDNetworkRequest {
    
    static let shared : ENTALDNetworkRequest = ENTALDNetworkRequest()
    
    private init() {
        
    }
    
    var path : String?
    var client : Session?
    var parameters: Parameters?
    var requestPath: String?
    var requestURL: URL?
   
    func getRequestFor(baseType:ENTALDBASEURLTYPE, path:String, params:Parameters?)->ENTALDNetworkRequest?{

        guard let baseURL = ENTALDAPIUtils.shared.getBaseUrlByType(baseType: baseType) else {return nil}
        let request = ENTALDNetworkRequest.shared
        request.requestURL = URL(string: "\(baseURL.absoluteString)\(path)")
        request.parameters = params
        request.path = path

        let manager = Session(configuration: URLSessionConfiguration.default)
        manager.sessionConfiguration.timeoutIntervalForRequest = 60.0

        request.client = manager

        return request
    }

}
