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
    
    func requestPendingPublishEvents(params:[String:Any],  _ completion:@escaping((ApiResult<CurrentEventsResponseModel, ApiError>) -> Void )){
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
    
    func requestVolunteerPastEvent(params:[String:Any],  _ completion:@escaping((ApiResult<VolunteerEventResponseModel, ApiError>) -> Void )){
        let router = VolunteerDashBoardRouter.getVolunteerPastEvent(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestVolunteerAvailableEventTwo(params:[String:Any],  _ completion:@escaping((ApiResult<AvailableEventResponseModel, ApiError>) -> Void )){
        let router = VolunteerDashBoardRouter.getVolunteerAvailableEventTwo(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestVolunteerAvailableEventThree(params:[String:Any],  _ completion:@escaping((ApiResult<AvailableEventResponseModel, ApiError>) -> Void )){
        let router = VolunteerDashBoardRouter.getVolunteerAvailableEventThree(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    
    func requestVolunteerLatestEventInfo(params:[String:Any],  _ completion:@escaping((ApiResult<LatestEventResponseModel, ApiError>) -> Void )){
        let router = VolunteerDashBoardRouter.getLatestEventInfo(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestVolunteerLatestEvents(params:[String:Any],  _ completion:@escaping((ApiResult<LatestEventDataResponseModel, ApiError>) -> Void )){
        let router = VolunteerDashBoardRouter.getLatestEvents(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestVolunteersOfEvent(params:[String:Any],  _ completion:@escaping((ApiResult<VolunteerOfEventDataResponseModel, ApiError>) -> Void )){
        let router = DashBoardRouter.getVolunteersOfEvent(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    
    func requestAllProgram(params:[String:Any],  _ completion:@escaping((ApiResult<ProgramResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getAllProgram(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
        
    func requestContactInfo(params:[String:Any],  _ completion:@escaping((ApiResult<ContactResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getContactInfo(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestSideMenuAvailablityHour(params:[String:Any],  _ completion:@escaping((ApiResult<AvailablityHourResponseModel, ApiError>) -> Void )){
        let router = SideMenuRouter.getAvailablityHour(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestAdhocHour(params:[String:Any],  _ completion:@escaping((ApiResult<SideMenuHoursResponseModel, ApiError>) -> Void )){
        let router = SideMenuRouter.getAdhocHour(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestSideMenuVolunteerHour(params:[String:Any],  _ completion:@escaping((ApiResult<SideMenuHoursResponseModel, ApiError>) -> Void )){
        let router = SideMenuRouter.getVolunteerHour(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestExternalQualification(params:[String:Any],  _ completion:@escaping((ApiResult<ExternalQualificationResponseModel, ApiError>) -> Void )){
        let router = SideMenuRouter.getExternalQualification(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestSJAQualification(params:[String:Any],  _ completion:@escaping((ApiResult<SJAQualificationResponseModel, ApiError>) -> Void )){
        let router = SideMenuRouter.getSJAQualification(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestProfileInfoDetail(params:[String:Any],  _ completion:@escaping((ApiResult<LanguageResponseModel, ApiError>) -> Void )){
        let router = SideMenuRouter.getlanguages(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestPreferedLanguage(params:[String:Any],  _ completion:@escaping((ApiResult<PrefferedLanguageResponseModel, ApiError>) -> Void )){
        let router = SideMenuRouter.getPreffferedLanguages(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func postGroupMessage(params:PostGroupMessageRequestModel,  _ completion:@escaping((ApiResult<LanguageResponseModel, ApiError>) -> Void )){
        let router = DashBoardRouter.postMessages(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }

    func requestQualificationTypes(params:[String : Any],  _ completion:@escaping((ApiResult<SJAQualificationTypeResponseModel, ApiError>) -> Void )){
        let router = SideMenuRouter.getQualificationsType(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestEventPrograme(params:[String : Any],  _ completion:@escaping((ApiResult<EventProgramResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getProgram(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestEventBranch(params:[String : Any],  _ completion:@escaping((ApiResult<EventBranchResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getBranch(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestEventCouncil(params:[String : Any],  _ completion:@escaping((ApiResult<EventCouncilResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getCouncil(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestVolunteerEventClickOption(params:[String : Any],  _ completion:@escaping((ApiResult<VolunteerEventClickOptionResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getEventClickShiftOption(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestVolunteerEventClickShiftDetail(params:[String : Any],  _ completion:@escaping((ApiResult<VolunteerEventClickShiftDetailResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getEventClickShiftDetail(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
        
    func getEventParticipationCheck(params:[String : Any],  _ completion:@escaping((ApiResult<VolunteerEventParticipationCheckResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getEventParticipationCheck(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func getEventSummary(params:[String : Any],  _ completion:@escaping((ApiResult<EventSummaryResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getEventSummary(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }

    func getReportedShifts(params:[String : Any],  _ completion:@escaping((ApiResult<VolunteerOfEventDataResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getReportedShift(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }

    func getParticipantCount(params:[String : Any],  _ completion:@escaping((ApiResult<ParticipantsCountResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getParticipantCount(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func getOrgnizerContact(params:[String : Any],  _ completion:@escaping((ApiResult<OrgnizerEventResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getOrganizerContact(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func getvolunteerShiftStatus(params:[String : Any],  _ completion:@escaping((ApiResult<VolunteerStatusShiftResponseModel, ApiError>) -> Void )){
        let router = EventRouter.getvolunteerShiftStatus(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ///========================  Patch Requests ===========================
    
    
    func requestCloseEvent(eventId:String, params:[String:Any],  _ completion:@escaping((ApiResult<ProgramResponseModel, ApiError>) -> Void )){
        let router = EventRouter.cancelEvent(eventId:eventId, params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    
    func requestPendingShiftUpdate(eventId:String, params:[String:Any],  _ completion:@escaping((ApiResult<ProgramResponseModel, ApiError>) -> Void )){
        let router = EventRouter.pendingShiftUpdate(eventId: eventId, params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }

    
    func requestProfileInfoUpdate(conId:String, params:[String:Any],  _ completion:@escaping((ApiResult<ProgramResponseModel, ApiError>) -> Void )){
        let router = LoginRouter.updateUserIdentity(conId: conId, params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func requestContactInfoUpdate(contactId:String , params:[String:Any],  _ completion:@escaping((ApiResult<ContactResponseModel, ApiError>) -> Void )){
        let router = EventRouter.updateContactInfo(contactId: contactId, params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }

    func updateEventStatus(eventid:String , params:[String:Any],  _ completion:@escaping((ApiResult<ContactResponseModel, ApiError>) -> Void )){
        let router = EventRouter.updateEventStatus(eventId: eventid, params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func bookShift(params:[String:Any],  _ completion:@escaping((ApiResult<ContactResponseModel, ApiError>) -> Void )){
        let router = EventRouter.bookShift(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func cancelVolunteerEvent(eventId:String, params:[String:Any],  _ completion:@escaping((ApiResult<ProgramResponseModel, ApiError>) -> Void )){
        let router = EventRouter.cancelVolunteerEvent(eventId:eventId, params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func cancelVolunteerShift(eventId:String, params:[String:Any],  _ completion:@escaping((ApiResult<ProgramResponseModel, ApiError>) -> Void )){
        let router = EventRouter.cancelVolunteerShift(eventId:eventId, params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }

    func applyforShift(params:[String:Any],  _ completion:@escaping((ApiResult<ContactResponseModel, ApiError>) -> Void )){
        let router = EventRouter.applyShift(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    func createEventRequest(params:[String:Any],  _ completion:@escaping((ApiResult<CurrentEventsResponseModel, ApiError>) -> Void )){
        let router = EventRouter.createEvent(params: params)
        ENTALDHttpClient.shared.request(router, completion: completion)
    }
    
    
    
}

