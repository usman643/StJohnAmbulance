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
   
    func getRequestFor(_ router:Router)->ENTALDNetworkRequest?{

        guard let baseURL = ENTALDAPIUtils.shared.getBaseUrlByType(baseType: router.urlType) else {return nil}
        let request = ENTALDNetworkRequest.shared
        request.requestURL = URL(string: "\(baseURL.absoluteString)\(router.procedure)")
        switch HTTPMethodType(rawValue: router.method) {
        case .post:
            request.parameters = router.params
        case .patch:
            request.parameters = router.params
        case .get:
            var component = URLComponents(string: "\(baseURL.absoluteString)\(router.procedure)")
            var queryItems : [URLQueryItem] = []
            for param in router.params {
                queryItems.append(URLQueryItem(name: param.key, value: param.value as? String))
            }
            component?.queryItems = queryItems
            request.requestURL = component?.url
//            if let urlStr = component?.url?.absoluteString {
//                let replacedUrl = urlStr.replacingOccurrences(of: "$", with: "%24")
//                request.requestURL = URL(string: replacedUrl)
//            }
        default:
            break
        }
        
        request.path = path

        let manager = Session(configuration: URLSessionConfiguration.default)
        manager.sessionConfiguration.timeoutIntervalForRequest = 40.0

        request.client = manager

        return request
    }

}
