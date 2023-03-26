//
//  VolunteerEventModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 09/02/2023.
//

import Foundation
struct VolunteerEventResponseModel: Codable {
    let context: String?
    let value: [VolunteerEventsModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([VolunteerEventsModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}


struct VolunteerEventsModel : Codable {
    
    let _sjavms_volunteerevent_value : String?
    let msnfp_schedulestatus : Int?
    let sjavms_start : String?
    let msnfp_participationscheduleid : String?
    let sjavms_end : String?
    let sjavms_VolunteerEvent : VolunteerEventsDataModel?
    
    
}

struct VolunteerEventsDataModel : Codable {
    
    let msnfp_engagementopportunitytitle : String?
    let msnfp_location : String?
    let msnfp_engagementopportunityid : String?
    
}



struct VolunteersOfEventModel : Codable {
    
    let date : String?
    let data : [VolunteerOfEventDataModel]
}





