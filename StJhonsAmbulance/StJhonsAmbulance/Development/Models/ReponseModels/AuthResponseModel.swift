//
//  AuthResponseModel.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/22/23.
//

import Foundation

struct PortalAuthModel : Codable {
    let access_token: String?
    let token_type:String?
    let expires_in:String?
    let refresh_token:String?
    let id_token:String?
}

struct ExternalAuthModel : Codable {
    let context: String?
    let value: [ExternalAuthValueModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([ExternalAuthValueModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct ExternalAuthValueModel : Codable {
    let _adx_contactid_value: String?
}


struct UserIdentityModel : Codable {
    let adx_identity_username: String?
    let address2_name:String?
    let birthdate:String?
    let firstname:String?
    let lastname:String?
    let address1_city:String?
    let address1_postalcode: String?
    let fullname:String?
    let emailaddress1:String?
    let address1_composite:String?
    let entityimage_url:String?
    
}
