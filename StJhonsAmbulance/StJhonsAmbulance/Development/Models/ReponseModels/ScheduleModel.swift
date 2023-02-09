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
    let msnfp_engagementopportunityid : String?
    let sjavms_msnfp_engagementopportunity_msnfp_group :  [EngagementopportunityGroupModel]?
}
struct EngagementopportunityGroupModel : Codable {
    
    
    
}


struct ScheduleResponseModelThree: Codable {
    let context: String?
    let value: [ScheduleModelThree]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([ScheduleModelThree].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}


struct ScheduleModelThree : Codable {
    
    let _sjavms_volunteerevent_value : String?
    let msnfp_schedulestatus : Int?
    let sjavms_start : String?
    let msnfp_participationscheduleid : String?
    let sjavms_end : String?
    let sjavms_VolunteerEvent : ScheduleDataModel?
    
    
}


struct ScheduleDataModel : Codable {
    
    let msnfp_engagementopportunitytitle : String?
    let msnfp_location : String?
    let msnfp_engagementopportunityid : String?
    
}
