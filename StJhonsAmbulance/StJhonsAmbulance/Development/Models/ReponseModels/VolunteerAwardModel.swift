//
//  VolunteerAwardModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 08/02/2023.
//

import Foundation

struct VolunteerAwardResponseModel : Codable {
    let context: String?
    let value: [VolunteerAwardModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([VolunteerAwardModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}
struct VolunteerAwardModel: Codable{
    
    let _msnfp_awardid_value : String?
    let msnfp_awarddate : String?
    let msnfp_awardversionid : String?
}
