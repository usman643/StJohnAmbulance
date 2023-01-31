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
    
    func requestDynamicAuth(params:DynamicAuthRequest, _ completion:@escaping((ApiResult<PortalAuthModel, ApiError>) -> Void)){
        let router = LoginRouter.dynamicAuthentication(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestExternalAuth(subId:String, _ completion:@escaping((ApiResult<ExternalAuthModel, ApiError>) -> Void)){
        let router = LoginRouter.getExternalIdentity(subId: subId)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestUserIdentity(conId:String, _ completion:@escaping((ApiResult<UserIdentityModel, ApiError>) -> Void)){
        let router = LoginRouter.getUserIdentity(conId: conId)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestAssociatedGroups(params:[String:Any], _ completion:@escaping((ApiResult<LandingResponseModel, ApiError>) -> Void)){
        let router = LandingRouter.getAssiciatedGroups(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }

    func requestPendingShifts(params:[String:Any],  _ completion:@escaping((ApiResult<PendingShiftResponseModel, ApiError>) -> Void )){
        let router = PendingShiftRouter.getPendingShifts(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
}

