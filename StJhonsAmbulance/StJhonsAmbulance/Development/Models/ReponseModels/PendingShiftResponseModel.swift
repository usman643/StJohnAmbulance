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
    let msnfp_participationscheduleid : String?
    let msnfp_schedulestatus : Int?
    let sjavms_start : String?
    let sjavms_end : String?
    let sjavms_hours : Float?
    let _sjavms_volunteerevent_value : String?
    let _sjavms_volunteer_value : String?
    let sjavms_Volunteer : PendingShiftVolunteerModelTwo?
    let sjavms_VolunteerEvent : VolunteerEventModel?
}

struct PendingShiftVolunteerModelTwo : Codable {
    let fullname : String?
    let contactid : String?
}

struct VolunteerEventModel : Codable {
    let msnfp_engagementopportunitytitle : String?
    let _sjavms_program_value : String?
    let msnfp_engagementopportunityid : String?
}

//========================PendingShiftResponseModelThree==========================//




struct PendingShiftResponseModelThree : Codable {
    let context: String?
    let value: [PendingShiftModelThree]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([PendingShiftModelThree].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct PendingShiftModelThree : Codable {

    let msnfp_engagementopportunityschedule : String?
    let createdon : String?
    let msnfp_totalhours : String?
    let msnfp_startperiod : String?
    let msnfp_hoursperday : String?
    let _msnfp_engagementopportunity_value : String?
    let msnfp_endperiod : String?
    let msnfp_effectiveto : String?
    let msnfp_effectivefrom : String?
    let msnfp_workingdays : String?
    let msnfp_engagementopportunityscheduleid : String?
    

}
