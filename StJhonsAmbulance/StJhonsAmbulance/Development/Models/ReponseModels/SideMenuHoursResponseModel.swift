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
    let sjavms_VolunteerEvent : SideMenuHoursEventModel?
 
}

struct SideMenuHoursEventModel : Codable {
    
    let _sjavms_program_value : String?
    let msnfp_engagementopportunityid : String?
    let msnfp_engagementopportunitytitle : String?

}




