//
//  ScheduleModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 08/02/2023.
//

import Foundation

struct ScheduleResponseModelOne : Codable {
    let context: String?
    let value: [ScheduleGroupsModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([ScheduleGroupsModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}


struct ScheduleGroupsModel : Codable {
    
    let msnfp_groupmembershipid : String?
    let msnfp_groupmembershipname : String?
    let _msnfp_groupid_value : String?
    let msnfp_groupId : ScheduleGroupIdsModel?

}

struct ScheduleGroupIdsModel : Codable {
    let msnfp_groupname : String?
    let msnfp_groupid : String?
    let _sjavms_groupid_value : String?

}


struct ScheduleResponseModelTwo: Codable {
    let context: String?
    let value: [ScheduleModelTwo]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([ScheduleModelTwo].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}


struct ScheduleModelTwo : Codable {
    
    let msnfp_engagementopportunitytitle : String?
    let msnfp_engagementopportunitystatus : Int?
    let msnfp_startingdate : String?
    let msnfp_endingdate : String?
    let msnfp_location : String?
    let msnfp_engagementopportunityid : String?
    let sjavms_msnfp_engagementopportunity_msnfp_group :  [EngagementopportunityGroupModel]?
}
struct EngagementopportunityGroupModel : Codable {
    
    
    
}


struct ScheduleResponseModelThree: Codable {
    let value: [ScheduleModelThree]?
}


struct ScheduleModelThree : Codable {
    
    let _sjavms_volunteerevent_value : String?
    let sjavms_volunteerevent_value : String?
    let sjavms_programe_value : String?
    let msnfp_schedulestatus : Int?
    let sjavms_start : String?
    let msnfp_participationscheduleid : String?
    let sjavms_end : String?
    let sjavms_checkedin : Bool?
    var time_difference : Int?
    var msnfp_description : String?
    var msnfp_shortdescription : String?
    let sjavms_VolunteerEvent : ScheduleDataModel?
    let sjavms_msnfp_engagementopportunity_msnfp_group : [SjavmsMsnfpEngagementopportunity]?
    
    
    enum CodingKeys: String, CodingKey {
        case _sjavms_volunteerevent_value
        case sjavms_volunteerevent_value = "_createdby_value@OData.Community.Display.V1.FormattedValue"
        case sjavms_programe_value = "_modifiedby_value@OData.Community.Display.V1.FormattedValue"
        case msnfp_schedulestatus
        case sjavms_start
        case msnfp_participationscheduleid
        case sjavms_end
        case sjavms_checkedin
        case time_difference
        case msnfp_description
        case msnfp_shortdescription
        case sjavms_VolunteerEvent
        case sjavms_msnfp_engagementopportunity_msnfp_group
    }
}


struct ScheduleDataModel : Codable {
    
    let msnfp_engagementopportunitytitle : String?
    let msnfp_location : String?
    let msnfp_engagementopportunityid : String?
    let msnfp_engagementopportunitystatus : Int?
    let program : String?
//    let sjavms_msnfp_engagementopportunity_msnfp_group : [SjavmsMsnfpEngagementopportunity]?
    
    enum CodingKeys: String, CodingKey {
        case msnfp_engagementopportunitytitle
        case msnfp_location
        case msnfp_engagementopportunityid
        case msnfp_engagementopportunitystatus
        case program = "_sjavms_program_value@OData.Community.Display.V1.FormattedValue"
    }
    
}


//============================


struct AvailableEventResponseModel: Codable {
    let context: String?
    let value: [AvailableEventModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([AvailableEventModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}


struct AvailableEventModel : Codable {
    
    let msnfp_engagementopportunitytitle : String?
    let msnfp_engagementopportunitystatus : Int?
    let msnfp_startingdate : String?
    let msnfp_endingdate : String?
    let msnfp_location : String?
    let msnfp_engagementopportunityid : String?
    let _sjavms_program_value : String?
    let sjavms_program_value : String?
    let msnfp_description : String?
    let msnfp_shortdescription : String?
    let msnfp_maximum : Int?
    let msnfp_minimum : Int?
    let sjavms_checkin : Bool?
    let sjavms_checkedin : Bool?
    let sjavms_msnfp_engagementopportunity_msnfp_group : [SjavmsMsnfpEngagementopportunity]?
//    let sjavms_msnfp_engagementopportunity_msnfp_group :  [EngagementopportunityGroupModel]?
    
    enum CodingKeys: String, CodingKey {
        case msnfp_engagementopportunitytitle
        case msnfp_engagementopportunitystatus
        case msnfp_startingdate
        case msnfp_endingdate
        case msnfp_location
        case msnfp_engagementopportunityid
        case _sjavms_program_value
        case sjavms_program_value = "_sjavms_program_value@OData.Community.Display.V1.FormattedValue"
        case msnfp_maximum
        case msnfp_minimum
        case msnfp_description
        case msnfp_shortdescription
        case sjavms_checkin
        case sjavms_checkedin
        case sjavms_msnfp_engagementopportunity_msnfp_group
    }
}


struct ScheduleEventResponseDataModel : Codable {
    
    let engagements : [ScheduleEventDataModel]?
}

struct ScheduleEventDataModel : Codable {
    
    let OppId : String?
    let Title : String?
    let Program : String?
    let StatusCode : String?
    let StartDateFull : String?
    let StartDate : String?
    let StartDateString : String?
    let Desc : String?
    let EndDateFull : String?
    let EndDate : String?
    let EndDateString : String?
    let LocationTypeName : String?
    let LocationTypeValue : Int?
    let LocationTitle : String?
    let City : String?
}

struct ScheduleEngagementResponseModel : Codable{
    
    var values : [ScheduleEngagementModel]?
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.values = try container.decodeIfPresent([ScheduleEngagementModel].self)
    }
    
}


struct ScheduleEngagementModel : Codable {
   
    let OppId : String?
    let Title : String?
    let Program : String?
    let StatusCode : String?
    let StartDateFull : String?
    let StartDate : String?
    let StartDateString : String?
    let Desc : String?
    let EndDateFull : String?
    let EndDate : String?
    let EndDateString : String?
    let LocationTypeName : String?
    let LocationTypeValue : String?
    let LocationTitle : String?
    let City : String?
    let VolunteeringEventId : String?
}
