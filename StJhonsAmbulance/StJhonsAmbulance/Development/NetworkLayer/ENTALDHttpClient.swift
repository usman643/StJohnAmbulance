//
//  ENTALDHttpClient.swift
//  ENTALDO
//
//  Created by M.Usman on 25/04/2022.
//

import Foundation
import Alamofire

enum HTTPMethodType : String {
    case post = "POST"
    case get = "GET"
}

enum ApiResult<T, Failure> where Failure: Error {
    case success(value: T)
    case error(error: Failure, errorResponse: ErrorResponse?)
}



class ENTALDHttpClient {
    
    static let shared : ENTALDHttpClient = ENTALDHttpClient()
    
    private init() {
        
    }
    
    private func getHeaders()->HTTPHeaders{
        var headers: HTTPHeaders = []
        
        if let token = UserDefaults.standard.authToken {
            headers.add(HTTPHeader(name: "Authorization", value: "Bearer \(token)"))
        }
        
        return headers
    }
    
    func request<T: Codable>(_ router: Router, completion:@escaping (ApiResult<T, ApiError>) ->Void) {
        
        guard let request = ENTALDNetworkRequest.shared.getRequestFor(router) else{return}
        
        if HTTPMethod(rawValue: router.method) == .get {
            self.getRequest(request, completion: completion)
            return
        }
        
        
        if let client = request.client, let requstUrl = request.requestURL?.absoluteString {
            print("request URL \(requstUrl)")
            
            client.request(requstUrl,
                           method: HTTPMethod(rawValue: router.method),
                           parameters:request.parameters,
                           encoding:router.encoding.getENcodingType(),
                           headers:self.getHeaders()).validate().responseData(completionHandler: { response in
                
                switch response.result {
                    
                case .success(_):
                    if let data = response.data {
                        self.handleSuccessResponse(data: data) { handler in
                            completion(handler)
                        }
                    }
                    break
                case .failure(let error):
                    if let data = response.data {
                        self.handleSuccessResponse(data: data) { handler in
                            completion(handler)
                        }
                    }else{
                        completion(.error(error: self.getApiError(from: error), errorResponse: nil))
                    }
                }
            })
        }
    }
    
    private func getRequest<T: Codable>(_ netRequest:ENTALDNetworkRequest, completion:@escaping (ApiResult<T, ApiError>) ->Void) {
        
        
        guard let requestUrl = netRequest.requestURL else {return}
        
        var request = URLRequest(url: requestUrl)
        request.addValue("Bearer \(UserDefaults.standard.authToken ?? "")", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.error(error: self.getApiError(from: error), errorResponse: nil))
            }else if let data = data{
                self.handleSuccessResponse(data: data) { handler in
                    completion(handler)
                }
            }
        }
        task.resume()
        
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
