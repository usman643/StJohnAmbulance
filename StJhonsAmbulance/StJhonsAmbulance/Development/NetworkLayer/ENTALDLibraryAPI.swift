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

    func requestPendingShiftsOne(params:[String:Any],  _ completion:@escaping((ApiResult<PendingShiftResponseModelOne, ApiError>) -> Void )){
        let router = DashBoardRouter.getPendingShiftsOne(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestPendingShiftsTwo(params:[String:Any],  _ completion:@escaping((ApiResult<PendingShiftResponseModelTwo, ApiError>) -> Void )){
        let router = DashBoardRouter.getPendingShiftsTwo(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
        
    func requestPendingShiftsThree(params:[String:Any],  _ completion:@escaping((ApiResult<PendingShiftResponseModelThree, ApiError>) -> Void )){
        let router = DashBoardRouter.getPendingShiftsThree(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestMessages(params:[String:Any],  _ completion:@escaping((ApiResult<MessageResponseModel, ApiError>) -> Void )){
        let router = DashBoardRouter.getMessages(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestVolunteer(params:[String:Any],  _ completion:@escaping((ApiResult<VolunteerResponseModel, ApiError>) -> Void )){
        let router = DashBoardRouter.getVolunteers(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
}

