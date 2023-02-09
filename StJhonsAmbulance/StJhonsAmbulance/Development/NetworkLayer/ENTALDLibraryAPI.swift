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
    
    func requestCurrentEvents(params:[String:Any],  _ completion:@escaping((ApiResult<CurrentEventsResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getCurrentEvent(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestUpcomingEvents(params:[String:Any],  _ completion:@escaping((ApiResult<CurrentEventsResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getUpcomingEvents(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestPastEvents(params:[String:Any],  _ completion:@escaping((ApiResult<CurrentEventsResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getPastEvents(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestApprovalPendingApproval(params:[String:Any],  _ completion:@escaping((ApiResult<PendingApprovalEventsResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getPendingApprovalEvents(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestPendingPublishEvents(params:[String:Any],  _ completion:@escaping((ApiResult<UnpublishedEventsResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getPendingPublishEvents(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestLatestUpcomingEvent(params:[String:Any],  _ completion:@escaping((ApiResult<CurrentEventsResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getLatestUpcomingEvents(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestVolunteerEvent(params:[String:Any],  _ completion:@escaping((ApiResult<PendingShiftResponseModelTwo, ApiError>) -> Void )){
        let router = VolunteerDashBoardRouter.getEvent(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestVolunteerNonEvent(params:[String:Any],  _ completion:@escaping((ApiResult<PendingShiftResponseModelTwo, ApiError>) -> Void )){
        let router = VolunteerDashBoardRouter.getNonEvent(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestScheduleOne(params:[String:Any],  _ completion:@escaping((ApiResult<ScheduleResponseModelOne, ApiError>) -> Void )){
        let router = VolunteerDashBoardRouter.getScheduleOne(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestScheduleTwo(params:[String:Any],  _ completion:@escaping((ApiResult<ScheduleResponseModelTwo, ApiError>) -> Void )){
        let router = VolunteerDashBoardRouter.getScheduleTwo(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestScheduleThree(params:[String:Any],  _ completion:@escaping((ApiResult<ScheduleResponseModelThree, ApiError>) -> Void )){
        let router = VolunteerDashBoardRouter.getScheduleThree(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestVolunteerAward(params:[String:Any],  _ completion:@escaping((ApiResult<VolunteerAwardResponseModel, ApiError>) -> Void )){
        let router = VolunteerDashBoardRouter.getAwards(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    
    
}

