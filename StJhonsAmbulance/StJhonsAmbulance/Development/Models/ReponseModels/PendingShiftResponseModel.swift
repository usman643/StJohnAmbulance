//
//  PendingShiftResponseModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 31/01/2023.
//

import Foundation


struct PendingShiftResponseModelOne : Codable {
    let context: String?
    let value: [PendingShiftModelOne]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([PendingShiftModelOne].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
}

struct PendingShiftModelOne : Codable {

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
    let sjavms_msnfp_engagementopportunity_msnfp_group : [PendingShiftVolunteerModelOne]?

 
}


struct PendingShiftVolunteerModelOne : Codable {
    
  
//    let _sjavms_owningteam_value : String?
    let _sjavms_program_value : String?
    let modifiedon : String?
    let _owninguser_value : String?
    let _sjavms_groupid_value : String?
    let sjavms_emergencymanagement : Bool?
//    let overriddencreatedon : String?
    let _sjavms_roletype_value : String?
//    let importsequencenumber : String?
//    let _modifiedonbehalfby_value : String?
    let msnfp_groupname : String?
    let msnfp_groupid : String?
    let statecode : Int?
    let _sjavms_branch_value : String?
    let versionnumber : Int?
//    let utcconversiontimezonecode : String?
//    let _createdonbehalfby_value : String?
//    let msnfp_description : String?
    let _modifiedby_value : String?
    let createdon : String?
    let _owningbusinessunit_value : String?
    let msnfp_grouptype : Int?
    let sjavms_unitnumber : String?
    let statuscode : Int?
//    let _owningteam_value : String?
    let _createdby_value : String?
    let _ownerid_value : String?
//    let timezoneruleversionnumber : String?
    
}


//==========================PendingShiftResponseModelTwo================================//


struct PendingShiftResponseModelTwo : Codable {
    let context: String?
    let value: [PendingShiftModelTwo]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([PendingShiftModelTwo].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct PendingShiftModelTwo : Codable {
    
    let msnfp_name : String?
    let createdon : String?
    let sjavms_program : String?
    let msnfp_participationscheduleid : String?
    let msnfp_schedulestatus : Int?
    let sjavms_start : String?
    let sjavms_end : String?
    let sjavms_hours : Float?
    let _sjavms_volunteerevent_value : String?
    let _sjavms_volunteer_value : String?
    var event_name : String?
    var event_starttime : String?
    var event_endtime : String?
    var event_selected : Bool?
    var sjavms_checkedin : Bool?
    let sjavms_Volunteer : PendingShiftVolunteerModelTwo?
    let sjavms_VolunteerEvent : VolunteerEventModel?
}

struct PendingShiftVolunteerModelTwo : Codable {
    let fullname : String?
    let contactid : String?
}

struct VolunteerEventModel : Codable {
    
    let sjavms_eventrequirements : String?
    let msnfp_street2 : String?
    let msnfp_zippostalcode : String?
    let msnfp_city : String?
    let msnfp_engagementopportunitytitle : String?
    let msnfp_location : String?
    let msnfp_stateprovince : String?
    let msnfp_street3 : String?
    let _sjavms_program_value : String?
    let msnfp_street1 : String?
    let msnfp_engagementopportunityid : String?
    let program : String?
    
    enum CodingKeys: String, CodingKey {
        case sjavms_eventrequirements
        case msnfp_street2
        case msnfp_zippostalcode
        case msnfp_city
        case msnfp_engagementopportunitytitle
        case msnfp_location
        case msnfp_stateprovince
        case msnfp_street3
        case _sjavms_program_value
        case msnfp_street1
        case msnfp_engagementopportunityid
        case program = "_sjavms_program_value@OData.Community.Display.V1.FormattedValue"
    }
    
}

//========================PendingShiftResponseModelThree==========================//




struct PendingShiftResponseModelThree : Codable {

    let value: [PendingShiftModelThree]?
   
}

struct PendingShiftModelThree : Codable {

    let msnfp_engagementopportunityschedule : String?
    let createdon : String?
    let msnfp_totalhours : Float?
//    let msnfp_startperiod : String?
    let msnfp_hoursperday : Float?
    let _msnfp_engagementopportunity_value : String?
//    let msnfp_endperiod : String?
    let msnfp_effectiveto : String?
    let msnfp_effectivefrom : String?
//    let msnfp_workingdays : String?
    let msnfp_engagementopportunityscheduleid : String?
    

}
        

struct VolunteerStatusShiftResponseModel : Codable {

    let value: [VolunteerStatusShift]?
    
}

struct VolunteerStatusShift : Codable {
    
    let  msnfp_schedulestatus : Int?
    let msnfp_participationscheduleid : String?
    
}
