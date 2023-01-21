//
//  ENTALDHttpClient.swift
//  ENTALDO
//
//  Created by M.Usman on 25/04/2022.
//

import Foundation
import Alamofire




class ENTALDHttpClient {
    
    static let shared : ENTALDHttpClient = ENTALDHttpClient()
    
    private init() {
        
    }
    
    private func getHeaders()->HTTPHeaders{
        let headers: HTTPHeaders = [
            "Content-Type": Content_Type,
            "Accept": Accept_Type,
            "Accept-Encoding" : Accept_Encoding,
        ]
        return headers
    }
    
    
    func postRequestWithURL(urlType:ENTALDBASEURLTYPE = .ENTALDBASEURLTYPE_BASEURL, path:String, params:Parameters = [:], encoding:ENTALDEncodingType = .ENTJSONEncoding, completion:@escaping (_ response : Any?, _ error : Error?) -> Void){

        var encryptedParams = params
        
        let request = ENTALDNetworkRequest.shared.getRequestFor(baseType: urlType, path: path, params: params)
        
        if let client = request?.client, let requstUrl = request?.requestURL?.absoluteString {
            print("request URL \(requstUrl)")
            
            client.request(requstUrl,
                           method: .post,
                           parameters:request?.parameters,
                           encoding:encoding.getENcodingType(),
                           headers:nil).validate().responseData(completionHandler: { response in
                
                switch response.result {
                    
                case .success(_):
                    completion(response.data, nil)
                    break
                case .failure(let error):
                    print("failed case \(error.localizedDescription)")
                    completion(nil, error)
                }
            })
        }
    }
    
}
