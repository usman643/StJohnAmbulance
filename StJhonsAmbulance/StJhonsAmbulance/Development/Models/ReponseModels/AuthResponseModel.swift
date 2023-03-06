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
    var value: [ExternalAuthValueModel]?
    
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
    let address3_addressid:String?
    let birthdate:String?
    let firstname:String?
    let lastname:String?
    let address1_city:String?
    let address1_stateorprovince:String?
    let address1_postalcode: String?
    let fullname:String?
    let emailaddress1:String?
    let address1_composite:String?
    let entityimage_url:String?
    let entityimage : String?
    let sjavms_alias : String?
    let sjavms_activedate : String?
    let msnfp_totalengagements : Int?
    let sjavms_yearsofservice : Int?
    let address1_line1 : String?
    let address1_line2 : String?
    let address1_telephone1 : String?
    let sjavms_totalpendinghrs : Float?
    let sjavms_legacyhours : Float?
    let sjavms_emergencycontactname : String?
    let address1_line3 : String?
    let sjavms_totalhourscompletedthisyear : Float?
    let sjavms_totalhourscompletedpreviousyear : Float?
    let msnfp_totalengagementhours : Float?
    let sjavms_employmentstatus : Int?
    let bdo_preferredlanguage : Int?
    let gendercode : Int?
    let sjavms_preferredlanguage : Int?
    let sjavms_otherknownlanguages : String?
    let contactid : String?
    
    
    var sjavms_workingwvulnerablepeople : Bool?
    var sjavms_patientcare : Bool?
    var sjavms_palliativecare : Bool?
    var sjavms_cprorfirstaid : Bool?
    var sjavms_recreationalprogramming : Bool?
    var sjavms_customerservice : Bool?
    var sjavms_educationalprogramming : Bool?
    var sjavms_computer : Bool?
    var sjavms_volunteerleadership : Bool?
    var sjavms_otherskills : Bool?
    var sjavms_explainskillother : String?
    
    
}

