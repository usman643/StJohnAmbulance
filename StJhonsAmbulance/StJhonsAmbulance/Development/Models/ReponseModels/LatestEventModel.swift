//
//  LatestEventModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 10/02/2023.
//

import Foundation

struct LatestEventResponseModel: Codable {
    let context: String?
    let value: [LatestEventModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([LatestEventModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct LatestEventModel : Codable {
    
    let msnfp_engagementopportunitytitle : String?
    let msnfp_engagementopportunitystatus : Int?
    let msnfp_startingdate : String?
    let msnfp_endingdate : String?
    let msnfp_location : String?
    let msnfp_engagementopportunityid : String?
    let sjavms_msnfp_engagementopportunity_msnfp_group :  [EngagementopportunityGroupModel]?
}








struct LatestEventDataResponseModel: Codable {
    let context: String?
    let value: [LatestEventDataModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([LatestEventDataModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct LatestEventDataModel : Codable {
    
    let msnfp_participationscheduleid : String?
    let statuscode : Int?
    let statecode : Int?
    let msnfp_schedulestatus : Int?
    let sjavms_start : String?
    let sjavms_end : String?
    let sjavms_VolunteerEvent : LatestImcomingEventDataModel?
    
}

struct LatestImcomingEventDataModel : Codable {
    
    let msnfp_engagementopportunitytitle : String?
    let msnfp_location : String?
    let msnfp_engagementopportunityid : String?
    
}

