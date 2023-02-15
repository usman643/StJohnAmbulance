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
    
    let odataEtag : String?
    let msnfp_groupmembershipid : String?
    let msnfp_membershiprole : Int?
    let msnfp_contactId : VolunteerContactModel?
    let sjavms_RoleType : VolunteerRoleModel?
    
    enum CodingKeys: String, CodingKey {
        case odataEtag = "@odata.etag"
        case msnfp_groupmembershipid
        case msnfp_membershiprole
        case msnfp_contactId
        case sjavms_RoleType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.odataEtag = try container.decodeIfPresent(String.self, forKey: .odataEtag)
        self.msnfp_groupmembershipid = try container.decodeIfPresent(String.self, forKey: .msnfp_groupmembershipid)
        self.msnfp_membershiprole = try container.decodeIfPresent(Int.self, forKey: .msnfp_membershiprole)
        self.msnfp_contactId = try container.decodeIfPresent(VolunteerContactModel.self, forKey: .msnfp_contactId)
        self.sjavms_RoleType = try container.decodeIfPresent(VolunteerRoleModel.self, forKey: .sjavms_RoleType)
        
    }
    
    
}

struct VolunteerContactModel : Codable{
    
    let fullname : String?
//    let telephone1 : String?
    let emailaddress1 : String?
    let address1_stateorprovince : String?
    let address1_postalcode : String?
    let address1_country : String?
    let address1_city : String?
    let contactid : String?
    
    enum CodingKeys: String, CodingKey {
        case fullname
//        case telephone1
        case emailaddress1
        case address1_stateorprovince
        case address1_postalcode
        case address1_country
        case address1_city
        case contactid
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fullname = try container.decodeIfPresent(String.self, forKey: .fullname)
//        self.telephone1 = try container.decodeIfPresent(Int.self, forKey: .telephone1)
        self.emailaddress1 = try container.decodeIfPresent(String.self, forKey: .emailaddress1)
        self.address1_stateorprovince = try container.decodeIfPresent(String.self, forKey: .address1_stateorprovince)
        self.address1_postalcode = try container.decodeIfPresent(String.self, forKey: .address1_postalcode)
        self.address1_country = try container.decodeIfPresent(String.self, forKey: .address1_country)
        self.address1_city = try container.decodeIfPresent(String.self, forKey: .address1_city)
        self.contactid = try container.decodeIfPresent(String.self, forKey: .contactid)
        
    }
    
    
}

struct VolunteerRoleModel : Codable{
    
    let sjavms_rolecategory : Int?
    let sjavms_name : String?
    let sjavms_roletypeid : String?
    
    enum CodingKeys: CodingKey {
        case sjavms_rolecategory
        case sjavms_name
        case sjavms_roletypeid
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sjavms_rolecategory = try container.decodeIfPresent(Int.self, forKey: .sjavms_rolecategory)
        self.sjavms_name = try container.decodeIfPresent(String.self, forKey: .sjavms_name)
        self.sjavms_roletypeid = try container.decodeIfPresent(String.self, forKey: .sjavms_roletypeid)
        
        
    }
}









struct VolunteerOfEventDataResponseModel: Codable {
    let context: String?
    let value: [VolunteerOfEventDataModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([VolunteerOfEventDataModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct VolunteerOfEventDataModel : Codable {
    
    let msnfp_schedulestatus : Int?
    let sjavms_start : String?
    let sjavms_end : String?
    let sjavms_hours : Float?
    let _sjavms_volunteerevent_value : String?
    let _sjavms_volunteer_value : String?
    let msnfp_participationscheduleid : String?
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


