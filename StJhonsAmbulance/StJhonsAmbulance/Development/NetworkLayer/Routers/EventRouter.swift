//
//  EventRouter.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 31/01/2023.
//

import Foundation
enum EventRouter : Router {
    
    case getCurrentEvent(params:[String:Any])
    case getUpcomingEvents(params:[String:Any])
    case getPastEvents(params:[String:Any])
    case getPendingApprovalEvents(params:[String:Any])
    case getPendingPublishEvents(params:[String:Any])
    case getLatestUpcomingEvents(params:[String:Any])
    case getAllProgram(params:[String:Any])
    case cancelEvent(eventId:String, params:[String:Any])
    case cancelVolunteerEvent(eventId:String, params:[String:Any])
    case cancelVolunteerShift(eventId:String, params:[String:Any])
    case pendingShiftUpdate(eventId:String, params:[String:Any])
    case getProgram(params:[String:Any])
    case getBranch(params:[String:Any])
    case getCouncil(params:[String:Any])
    case getContactInfo(params:[String:Any])
    case getEventClickShiftOption(params:[String:Any])
    case getPenndingApprovalClickShiftOption(params:[String:Any])
    case getEventClickShiftDetail(params:[String:Any])
    case getEventParticipationCheck(params:[String:Any])
    case getEventSummary(params:[String:Any])
    case getPendingApprovalEventSummary(params:[String:Any])
    case getReportedShift(params:[String:Any])
    case updateContactInfo(contactId:String, params:[String:Any])
    case updateEventStatus(eventId:String, params:[String:Any])
    case updateSummaryData(eventId:String, params:[String:Any])
    case updatePendingApprovalSummaryData(eventId:String, params:[String:Any])
    case addScheduleShift(params:[String:Any])
    case volunteerCheckIn(participationId:String, params:[String:Any])
    case cancelResgitertoAttendEvent(participationId:String, params:[String:Any])
    case getParticipantCount(params:[String:Any])
    case getOrganizerContact(params:[String:Any])
    case bookShift(params:[String:Any])
    case applyShift(params:[String:Any])
    case cancelParticipation(participationId:String, params:[String:Any])
    case getvolunteerShiftStatus(params:[String:Any])
    case getReportedShiftsData(params:[String:Any])
    case getAuditHistory(params:[String:Any])
    case getOtherVoulnteerParticipation(params:[String:Any])
    case getEventDatilTabInfo(params:[String:Any])
    case approvePendingEvent(eventId:String, params:[String:Any])
    
    case createEvent(params:[String:Any])
    
    case simulate401
   
    var procedure: String {
        switch self  {
        case .getCurrentEvent : return "msnfp_engagementopportunities"
        case .getUpcomingEvents : return "msnfp_engagementopportunities"
        case .getPastEvents : return "msnfp_engagementopportunities"
        case .getPendingApprovalEvents : return "sjavms_eventrequests"
        case .getPendingPublishEvents : return "msnfp_engagementopportunities"
        case .getLatestUpcomingEvents : return "msnfp_engagementopportunities"
        case .getAllProgram : return "sjavms_programs"
        case .cancelEvent(let eventID, _) : return "msnfp_engagementopportunities(\(eventID))"
        case .cancelVolunteerEvent(let eventID, _) : return "msnfp_participationschedules(\(eventID))"
        case .cancelVolunteerShift(let eventID, _) : return "msnfp_participations(\(eventID))"
        case .pendingShiftUpdate(let eventId, _) : return "msnfp_participationschedules(\(eventId))"
        case .getContactInfo : return "msnfp_engagementopportunities"
        case .getProgram : return "msnfp_groups"
        case .getBranch : return "sjavms_branchs"
        case .getCouncil : return "sjavms_vmscouncils"
        case .getEventClickShiftOption : return "msnfp_engagementopportunityschedules"
        case .getPenndingApprovalClickShiftOption : return "sjavms_eventrequests"
        case .getEventClickShiftDetail : return "msnfp_publicengagementopportunities"
        case .getEventParticipationCheck : return "msnfp_participations"
        case .getEventSummary : return "msnfp_engagementopportunities"
        case .getPendingApprovalEventSummary : return "sjavms_eventrequests"
        case .getReportedShift : return "msnfp_participationschedules"
        case .updateContactInfo(let contactId, _) : return "contacts(\(contactId))"
        case .updateEventStatus(let eventId, _) : return "msnfp_engagementopportunities(\(eventId))"
        case .updateSummaryData(let eventId, _) : return "msnfp_engagementopportunities(\(eventId))"
        case .updatePendingApprovalSummaryData(let eventId, _) : return "sjavms_eventrequests(\(eventId))"
        case .addScheduleShift: return "msnfp_engagementopportunityschedules"
        case .volunteerCheckIn(let participationId, _) : return "msnfp_participationschedules(\(participationId))"
        case .cancelResgitertoAttendEvent(let participationId, _) : return "msnfp_participations(\(participationId))"
        case .getParticipantCount : return "msnfp_participations"
        case .getOrganizerContact : return "msnfp_engagementopportunities"
        case .createEvent : return "sjavms_eventrequests"
        case .bookShift : return "msnfp_participationschedules"
        case .applyShift : return "msnfp_participations"
        case .cancelParticipation(let participationId, _) : return "msnfp_participations(\(participationId))"
        case .getvolunteerShiftStatus : return "msnfp_participationschedules"
        case .getReportedShiftsData : return "msnfp_participationschedules"
        case .getAuditHistory : return "audits"
        case .getOtherVoulnteerParticipation : return "msnfp_participations"
        case .getEventDatilTabInfo : return "msnfp_publicengagementopportunities"
        case .approvePendingEvent(let eventID, _) : return "sjavms_eventrequests(\(eventID))"
            
            
        case .simulate401: return "simulate-401"
        }
    }
    
    var params: [String : Any] {
        switch self {
        case .getCurrentEvent(let params):
            return params
        case .getUpcomingEvents(let params):
            return params
        case .getPastEvents(let params):
            return params
        case .getPendingApprovalEvents(let params):
            return params
        case .getPendingPublishEvents(let params):
            return params
        case .getLatestUpcomingEvents(let params):
            return params
        case .getAllProgram(let params):
            return params
        case .cancelEvent(_, let params):
            return params
        case .cancelVolunteerEvent(_, let params):
            return params
        case .cancelVolunteerShift(_, let params):
            return params
        case .volunteerCheckIn(_, let params):
            return params
        case .pendingShiftUpdate(_, let params):
            return params
        case .getContactInfo(let params):
            return params
        case .getProgram(let params):
            return params
        case .getBranch(let params):
            return params
        case .getCouncil(let params):
            return params
        case .getEventClickShiftOption(let params):
            return params
        case .getPenndingApprovalClickShiftOption(let params):
            return params
        case .getEventClickShiftDetail(let params):
            return params
        case .getEventParticipationCheck(let params):
            return params
        case .getEventSummary(let params):
            return params
        case .getPendingApprovalEventSummary(let params):
            return params
        case .getReportedShift(let params):
            return params
        case .updateContactInfo(_, let params):
            return params
        case .updateEventStatus(_, let params):
            return params
        case .updateSummaryData(_, let params):
            return params
        case .updatePendingApprovalSummaryData(_, let params):
            return params
        case .addScheduleShift(let params):
            return params
        case .cancelResgitertoAttendEvent(_, let params):
            return params
        case .cancelParticipation(_, let params):
            return params
        case .getParticipantCount(let params):
            return params
        case .getOrganizerContact(let params):
            return params
        case .createEvent(let params):
            return params
        case .bookShift(let params):
            return params
        case .applyShift(let params):
            return params
        case .getvolunteerShiftStatus(let params):
            return params
        case .getReportedShiftsData(let params):
            return params
        case .getAuditHistory(let params):
            return params
        case .getOtherVoulnteerParticipation(let params):
            return params
        case .approvePendingEvent(_, let params):
            return params
            
            
        default: return [:]
        }
        
        
    }
    
    var version: String {
        return "1"
    }
    
    var method: String {
        switch self {
        case .cancelEvent(_,_):
            return HTTPMethodType.patch.rawValue
        case .cancelVolunteerEvent(_,_):
            return HTTPMethodType.patch.rawValue
        case .cancelVolunteerShift(_,_):
            return HTTPMethodType.patch.rawValue
        case .pendingShiftUpdate(_,_):
            return HTTPMethodType.patch.rawValue
        case .updateContactInfo(_,_):
            return HTTPMethodType.patch.rawValue
        case .updateEventStatus(_,_):
            return HTTPMethodType.patch.rawValue
        case .cancelResgitertoAttendEvent(_,_):
            return HTTPMethodType.patch.rawValue
        case .updateSummaryData(_,_):
            return HTTPMethodType.patch.rawValue
        case .updatePendingApprovalSummaryData(_,_):
            return HTTPMethodType.patch.rawValue
        case .addScheduleShift:
            return HTTPMethodType.post.rawValue
        case .volunteerCheckIn(_,_):
            return HTTPMethodType.patch.rawValue
        case .cancelParticipation(_,_):
            return HTTPMethodType.patch.rawValue
        case .createEvent:
            return HTTPMethodType.post.rawValue
        case .bookShift:
            return HTTPMethodType.post.rawValue
        case .applyShift:
            return HTTPMethodType.post.rawValue
        case .approvePendingEvent(_,_):
            return HTTPMethodType.patch.rawValue
            
        default:
            break
        }
        return HTTPMethodType.get.rawValue
    }
    
    var urlType: ENTALDBASEURLTYPE {
//        switch self{
//        case .getAuditHistory:
//            return .SAINJOHN_BASEURL_Api
//        default:
//            break
//        }
    
        return .SAINJOHN_BASEURL
    }
    
    var encoding: ENTALDEncodingType {
        switch self {
        case .cancelEvent(_,_):
            return .ENTJSONEncoding
        case .cancelVolunteerEvent(_,_):
            return .ENTJSONEncoding
        case .cancelVolunteerShift(_,_):
            return .ENTJSONEncoding
        case .pendingShiftUpdate(_,_):
            return .ENTJSONEncoding
        case .updateContactInfo(_,_):
            return .ENTJSONEncoding
        case .cancelResgitertoAttendEvent(_,_):
            return .ENTJSONEncoding
        case .updateEventStatus(_,_):
            return .ENTJSONEncoding
        case .updateSummaryData(_,_):
            return .ENTJSONEncoding
        case .updatePendingApprovalSummaryData(_,_):
            return .ENTJSONEncoding
        case .addScheduleShift:
            return .ENTJSONEncoding
        case .volunteerCheckIn(_,_):
            return .ENTJSONEncoding
        case .cancelParticipation(_,_):
            return .ENTJSONEncoding
        case .createEvent:
            return .ENTJSONEncoding
        case .bookShift:
            return .ENTJSONEncoding
        case .applyShift:
            return .ENTJSONEncoding
        case .approvePendingEvent(_,_):
            return .ENTJSONEncoding
        default:
            break
        }
        return .ENTDefaultEncoding
    }
    
    
}
