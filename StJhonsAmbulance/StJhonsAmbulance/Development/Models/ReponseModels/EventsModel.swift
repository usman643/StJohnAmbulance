//
//  EventsModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 31/01/2023.
//

import Foundation

struct EventsResponseModel : Codable{
    let context: String?
    let value: [EventsModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([EventsModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct EventsModel: Codable {
    
}
