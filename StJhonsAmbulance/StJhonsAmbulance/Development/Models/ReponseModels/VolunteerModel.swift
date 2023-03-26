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
    
    let msnfp_groupmembershipid : String?
    let msnfp_membershiprole : Int?
    let msnfp_contactId : VolunteerContactModel?
    let sjavms_RoleType : VolunteerRoleModel?
    
}

struct VolunteerContactModel : Codable{
    
    let fullname : String?
    let lastname : String?
    let telephone1 : String?
    let emailaddress1 : String?
    let address1_stateorprovince : String?
    let address1_postalcode : String?
    let address1_line1 : String?
    let address1_country : String?
    let address1_city : String?
    let contactid : String?
    let sjavms_preferredpronouns : String?

}

struct VolunteerRoleModel : Codable{
    
    let sjavms_rolecategory : Int?
    let sjavms_name : String?
    let sjavms_roletypeid : String?

}









struct VolunteerOfEventDataResponseModel: Codable {
    
    let value: [VolunteerOfEventDataModel]?
  
}

struct VolunteerOfEventDataModel : Codable {
    
    let msnfp_schedulestatus : Int?
    let sjavms_start : String?
    let sjavms_end : String?
    let sjavms_hours : Float?
    let _sjavms_volunteerevent_value : String?
    let _sjavms_volunteer_value : String?
    let msnfp_participationscheduleid : String?
    let sjavms_checkedin : String?
    let sjavms_Volunteer : VolunteerOfEventVolunteerModel?
    
    
//
//    let msnfp_name : String?
//    let createdon : String?
//    let msnfp_schedulestatus : Int?
//    let sjavms_end : String?
//    let sjavms_VolunteerEvent : VolunteerEventModel?
    
    
}

struct VolunteerOfEventVolunteerModel : Codable {
    
    let fullname : String?
    let contactid : String?
   
    
}

struct VounteerEventDataByDate : Codable {
    
    let key : String?
    let value : [VolunteerOfEventDataModel]?
    
    
}


