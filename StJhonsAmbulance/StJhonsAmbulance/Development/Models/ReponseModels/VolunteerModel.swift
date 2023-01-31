//
//  VolunteerModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 31/01/2023.
//

import Foundation

struct VolunteerResponseModel : Codable{
    let context: String?
    let value: [VolunteerModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([VolunteerModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct VolunteerModel: Codable {
    
}

