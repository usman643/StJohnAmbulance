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
    let sjavms_emergencymanagementprogram : Bool?
    let versionnumber : Int?
    let sjavms_programid : String?
    let _sjavms_programsid_value : String?
    
}

struct ProgramStatusModel : Codable{
    
    var status_id : Int?
    var status_value : String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status_id = try container.decodeIfPresent(Int.self, forKey: .status_id)
        self.status_value = try container.decodeIfPresent(String.self, forKey: .status_value)
        
    }
}


struct PatchReponseModel: Codable {
    
    let error : ErrorModel?
    
    
}

struct ErrorModel: Codable {
    
    let message : String?
    
}
