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
    case patch = "PATCH"
}

enum ApiResult<T, Failure> where Failure: Error {
    case success(value: T)
    case error(error: Failure, errorResponse: ErrorResponse?)
}



class ENTALDHttpClient {
    
    static let shared : ENTALDHttpClient = ENTALDHttpClient()
    
    private init() {
        
    }
    
    private func getHeaders(externalToken:String = "")->HTTPHeaders{
        var headers: HTTPHeaders = []
        
        if let token = UserDefaults.standard.authToken {
            if externalToken == "" {
                headers.add(HTTPHeader(name: "Authorization", value: "Bearer \(token)"))
                headers.add(HTTPHeader(name: "Content-Type", value: "application/json"))
            }
            
        }
        
        return headers
    }
    
    func request<T: Codable>(_ router: Router, externalToken:String = "", completion:@escaping (ApiResult<T, ApiError>) ->Void) {
        
        if ProcessUtils.shared.shouldRefreshToken() && router.procedure != "token?p=b2c_1_ropc_auth" {
            ProcessUtils.shared.refreshToken { status in
                if status {
                    self.request(router, completion: completion)
                }
            }
            return
        }

        guard let request = ENTALDNetworkRequest.shared.getRequestFor(router) else{return}
        
        if HTTPMethod(rawValue: router.method) == .get {
            self.getRequest(request, externalToken: externalToken, completion: completion)
            return
        }
        
        #if DEBUG
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: request.parameters ?? [:], options: .prettyPrinted)
            print("Json Request")
            print(String(data: jsonData, encoding: .utf8) ?? "")
        } catch {
            print(error.localizedDescription)
        }
        #endif
        
        if let client = request.client, let requstUrl = request.requestURL?.absoluteString {
            print("request URL :  \(requstUrl)")
            let headers = self.getHeaders(externalToken: externalToken)
            client.request(requstUrl,
                           method: HTTPMethod(rawValue: router.method),
                           parameters:request.parameters,
                           encoding:router.encoding.getENcodingType(),
                           headers:headers.count > 0 ? headers : nil).validate().responseData(completionHandler: { response in
                
                switch response.result {
                    
                case .success(_):
                    if let data = response.data {
                        self.handleSuccessResponse(data: data) { handler in
                            completion(handler)
                        }
                    }else if HTTPMethod(rawValue: router.method) == .patch || HTTPMethod(rawValue: router.method) == .post{
                        completion(ApiResult.error(error: .patchSuccess, errorResponse: nil))
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
    
    private func getRequest<T: Codable>(_ netRequest:ENTALDNetworkRequest, externalToken:String = "", completion:@escaping (ApiResult<T, ApiError>) ->Void) {

        guard let requestUrl = netRequest.requestURL else {return}
        
        print("get Request \(requestUrl)")
        
        var request = URLRequest(url: requestUrl)
        if externalToken != "" {
            request.addValue("Bearer \(externalToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json;odata=verbose", forHTTPHeaderField: "Accept")
        }else{
            request.addValue("Bearer \(UserDefaults.standard.authToken ?? "")", forHTTPHeaderField: "Authorization")
        }
        request.addValue("keep-alive", forHTTPHeaderField: "Connection")
        request.addValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        request.addValue("odata.include-annotations=OData.Community.Display.V1.FormattedValue", forHTTPHeaderField: "Prefer")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error as? NSError {
                if error.code == 401 || error.code == 401 || error.code == 3840 {
                    UserDefaults.standard.signOut()
                    
                }
                completion(.error(error: self.getApiError(from: error), errorResponse: nil))
            }else if let data = data{
                if (data.count != 0){
                    self.handleSuccessResponse(data: data) { handler in
                        completion(handler)
                    }
                }else{
                    UserDefaults.standard.signOut()
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
                print("++++++++++Response++++++++++++ \n\(errorResponse)")
                #endif
                // can logout app on 401 here
                
                completion(.error(error: .unknownError, errorResponse: errorResponse))
                
            }else {
                
                #if DEBUG
                print("++++++++++Response++++++++++++ \n")
                print(String(data: data, encoding: .utf8) ?? "")
                #endif
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let dict = json as? [String:Any] {
                    let result = dict.filter({
                        if let value = $0.value as? String{
                            return !value.contains("<null>")
                        }
                        return true
                    })
                    let jsonData = try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
                    let decodedObj = try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(value: decodedObj))
                    print("results \(result)")
                }else{
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    let decodedObj = try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(value: decodedObj))
                }
                
            }
        }catch (let error) {
            
            #if DEBUG
            print("++++++++++Response++++++++++++ \n")
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
    
    
    func requestForRefreshToken<T: Codable>(_ router: Router, completion:@escaping (ApiResult<T, ApiError>) ->Void) {
        
        guard let request = ENTALDNetworkRequest.shared.getRequestFor(router) else{return}
        
        if let client = request.client, let requstUrl = request.requestURL?.absoluteString {
            print("request URL :  \(requstUrl)")
            
            client.request(requstUrl,
                           method: HTTPMethod(rawValue: router.method),
                           parameters:request.parameters,
                           encoding:router.encoding.getENcodingType()).validate().responseData(completionHandler: { response in
                
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
    
    
    func downloadFile (using url: URL, access_token:String? = nil, file_Name:String?, completion: @escaping(_ response : Any, _ error : Error?) -> Void) {
        
        let fileName = url.lastPathComponent
        let destination: DownloadRequest.Destination = { _ , _ in
            
            let documentURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentURLs.appendingPathComponent(file_Name ?? "test File")
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        print("File Name &&&  \(fileName)")
        
        var request : URLRequest!
        do {
            request = try URLRequest(url: url, method: .get)
        }catch(let err){
            print("Request Not valid \(err.localizedDescription)")
            return
        }
        
        if let token = access_token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        AF.download(request, to:destination).downloadProgress(closure: { (progress) in
            print("Progresss -------> \(progress.totalUnitCount)")
        }).validate()
            .response {response in
                
                let statusCode = response.response?.statusCode
                switch response.result {
                case .success(_):
                    if statusCode == 200{
                        print("Successs #################")
                        completion(statusCode as Any, nil)
                    }
                case .failure(let error):
                    completion("", error)
                    print("File Upload Error on external \(error.localizedDescription)")
                }
            }
    }
    
}
