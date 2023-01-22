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
    
    func requestPortalAuth(params:PortalAuthRequest, _ completion:@escaping((ApiResult<PortalAuthModel, ApiError>) -> Void)){
        let router = LoginRouter.portalAuthentication(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
}
