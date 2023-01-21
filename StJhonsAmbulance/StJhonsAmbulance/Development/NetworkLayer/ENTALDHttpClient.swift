//
//  ENTALDHttpClient.swift
//  ENTALDO
//
//  Created by M.Usman on 25/04/2022.
//

import Foundation
import Alamofire

enum ApiResult<T, Failure> where Failure: Error {
    case success(value: T)
    case error(error: Failure, errorResponse: ErrorResponse?)
}



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
    
    func request<T: Codable>(_ router: Router, completion:@escaping (ApiResult<T, ApiError>) ->Void) {
        
        let request = ENTALDNetworkRequest.shared.getRequestFor(baseType: router.urlType, path: router.procedure, params: router.params)
        
        if let client = request?.client, let requstUrl = request?.requestURL?.absoluteString {
            print("request URL \(requstUrl)")
            
            client.request(requstUrl,
                           method: .post,
                           parameters:request?.parameters,
                           encoding:router.encoding.getENcodingType(),
                           headers:nil).validate().responseData(completionHandler: { response in
                
                switch response.result {
                    
                case .success(_):
                    if let data = response.data {
                        self.handleSuccessResponse(data: data) { handler in
                            completion(handler)
                        }
                    }
                    break
                case .failure(let error):
                    completion(.error(error: self.getApiError(from: error), errorResponse: nil))
                }
            })
        }
    }
    
}


extension ENTALDHttpClient {
    private func handleSuccessResponse<T: Codable>(data:Data, completion: @escaping ((ApiResult<T, ApiError>) -> Void)){
        
        do {
            if let responseDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any],
                let errorResponse = ErrorResponse(dictionary: responseDictionary) {
                
                #if DEBUG
                print("Response\n \(errorResponse)")
                #endif
                // can logout app on 401 here
                
                completion(.error(error: .unknownError, errorResponse: errorResponse))
                
            }else {
              
                #if DEBUG
                print("Response")
                print(String(data: data, encoding: .utf8) ?? "")
                #endif

                let decodedObj = try JSONDecoder().decode(T.self, from: data)
                completion(.success(value: decodedObj))
            }
        }catch (let error) {
            
            #if DEBUG
            print("Response")
            print(error)
            #endif
            
            completion(ApiResult.error(error: .invalidJson, errorResponse: nil))
            
        }
    }
    
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }
    
    fileprivate func getApiError(from error: Error) -> ApiError {
        switch (error as NSError).code {
        case 401:
            return .unauthorise
        default: return .unknownError
            
        }
        
    }
}
