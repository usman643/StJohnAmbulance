//
//  ENTALDLibraryAPI.swift
//  ENTALDO
//
//  Created by M.Usman on 25/04/2022.
//

import Foundation

class ENTALDLibraryAPI {
    
    static let shared : ENTALDLibraryAPI = ENTALDLibraryAPI()
    
    private init() {
        
    }
    
    func getConfigData(params:Parameters = [:], completion: @escaping(_ model:ENTALDAPICommonModel?, _ error:ENTALDAPIError?)->Void){
        
        self.sendRequestToServer(urlType: .ENTALDBASEURLTYPE_BASEURL, path: API_CONSTANTS.END_POINTS.KConfigs, params: params) { response, error in
            
            completion(response,error)
        }
    }
    
    
    private func sendRequestToServer(urlType:ENTALDBASEURLTYPE = .ENTALDBASEURLTYPE_BASEURL, path:String, params:Parameters = [:], encoding:ENTALDEncodingType = .ENTJSONEncoding, completion:@escaping (_ response : ENTALDAPICommonModel?, _ error : ENTALDAPIError?)->Void){
        
        let commonParameters = API_CONSTANTS.PARAMS.COMMONPARAMS
        let combinedParams = commonParameters.merging(params ) { $1 } //priority will be given to parameters dictionary keys
        
        ENTALDHttpClient.shared.postRequestWithURL(urlType: urlType, path: path, params: combinedParams) { response, error in
            
            let completeURL = ENTALDAPIUtils.shared.getCompleteUrlBytype(urlType: urlType, andPath: path)
            
            if(error == nil){
//                let responseModel = ENTALDEncryptionUtils.shared.decryptResponseData(response, requestURL: completeURL?.absoluteString ?? "", params: combinedParams)
//                completion(responseModel,nil)
            }else{
                guard let error = error else{return}
                ENTALDAPIErrorUtils.shared.parseError(requestUrl: completeURL?.absoluteString ?? "", requestParams: combinedParams, responseData: response, error: error) { error in
                    
                    completion(nil,error)
                }
            }
        }
    }
    
}
