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
    
    let odataEtag : String?
    let subject : String?
    let statuscode : Int?
    let modifiedon : String?
    let description : String?
    //    let senton : String?
    let activityid : String?
    let safedescription : String?
    
    enum CodingKeys: String, CodingKey {
        
        case odataEtag = "@odata.etag"
        case subject
        case statuscode
        case modifiedon
        case description
        //            case senton
        case activityid
        case safedescription
        
    }
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.odataEtag = try container.decodeIfPresent(String.self, forKey: .odataEtag)
        self.subject = try container.decodeIfPresent(String.self, forKey: .subject)
        self.statuscode = try container.decodeIfPresent(Int.self, forKey: .statuscode)
        self.modifiedon = try container.decodeIfPresent(String.self, forKey: .modifiedon)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        //        self.senton = try container.decodeIfPresent(String.self, forKey: .senton)
        self.activityid = try container.decodeIfPresent(String.self, forKey: .activityid)
        self.safedescription = try container.decodeIfPresent(String.self, forKey: .safedescription)
        
    }
    
    
}
