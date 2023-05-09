//
//  SideMenuHoursResponseModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 16/02/2023.
//

import Foundation

struct AvailablityHourResponseModel: Codable {
    let value: [AvailablityHourModel]?
}

struct AvailablityHourModel : Codable{
    
    let msnfp_availabilitytitle : String?
    let msnfp_effectivefrom : String?
    let msnfp_effectiveto : String?
    let msnfp_workingdays : String?
    let msnfp_availabilityid : String?
    
    
}



struct SideMenuHoursResponseModel : Codable {
    
    let value: [SideMenuHoursModel]?
    
}

struct SideMenuHoursModel : Codable {
    
    let msnfp_schedulestatus : Int?
    let sjavms_start : String?
    let sjavms_end : String?
    let _sjavms_volunteerevent_value : String?
    let _msnfp_engagementopportunityscheduleid_value : String?
    let sjavms_hours : Float?
    let msnfp_participationscheduleid : String?
    var sjavms_VolunteerEvent : SideMenuHoursEventModel?
    let sjavms_programid: String?
    var program_name: String?
    var msnfp_location: String?
    var sjavms_checkedin: String?
    let msnfp_engagementOpportunityScheduleId: EngagementOpportunityScheduleModel?
}

struct SideMenuHoursEventModel : Codable {
    
    let _sjavms_program_value : String?
    var program_name : String?
    let msnfp_engagementopportunityid : String?
    let msnfp_engagementopportunitytitle : String?

}


struct EngagementOpportunityScheduleModel : Codable {
    
    let msnfp_shiftname : String?
    let msnfp_engagementopportunityschedule : String?
    let msnfp_engagementopportunityscheduleid : String?

}

struct AdhocHourVolunteerEventResponseModel : Codable {
    
    let value: [AdhocHourVolunteerEventModel]?
    
}

struct AdhocHourVolunteerEventModel : Codable {
    
    let msnfp_engagementopportunitytitle : String?
    let msnfp_engagementopportunityid : String?
}


struct NonAdhocHourVolunteerEventResponseModel : Codable {
    
    let value: [NonAdhocHourVolunteerEventModel]?
    
}

struct NonAdhocHourVolunteerEventModel : Codable {

    let msnfp_engagementopportunitytitle : String?
    let msnfp_engagementopportunitystatus : Int?
    let msnfp_needsreviewedparticipants : Int?
    let msnfp_minimum : Int?
    let msnfp_maximum : Int?
    let _sjavms_group_value : String?
    let msnfp_endingdate : String?
    let msnfp_cancelledparticipants : Int?
    let msnfp_appliedparticipants : Int?
    let msnfp_startingdate : String?
    let msnfp_engagementopportunityid : String?
    
}

struct TherapyDogFacilityResponseModel : Codable {
    
    let value: [TherapyDogFacilityModel]?
    
}

struct TherapyDogFacilityModel : Codable {
    
    let name : String?
    let statecode : Int?
    let createdon : String?
    let sjavms_typeoffacility : String?
    let accountid : String?
    
}


struct TherapyDogIdResponseModel : Codable {
    
    let value: [TherapyDogIdModel]?
    
}

struct TherapyDogIdModel : Codable {
    
    let sjavms_veterinaryexpiry : String?
    let sjavms_dogsbreed : String?
//    let sjavms_childevaluation : String?
//    let sjavms_adultevaluation : String?
    let sjavms_name : String?
//    let sjavms_immunizationexpires : String?
    let sjavms_vmstherapydogid : String?
    
}

