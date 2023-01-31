//
//  MessageModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 31/01/2023.
//

import Foundation
struct MessageResponseModel : Codable{
    let context: String?
    let value: [MessageModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([MessageModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct MessageModel: Codable {
    
}
