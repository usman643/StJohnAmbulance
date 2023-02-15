//
//  ProgramModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 14/02/2023.
//

import Foundation

struct ProgramResponseModel : Codable{
    let context: String?
    let value: [ProgramModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([ProgramModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct ProgramModel: Codable {
    
    let sjavms_name : String?
    let sjavms_posteventsurvey : Bool?
    let sjavms_emergencymanagementprogram : String?
    let versionnumber : Int?
    let sjavms_programid : String?
    
}

