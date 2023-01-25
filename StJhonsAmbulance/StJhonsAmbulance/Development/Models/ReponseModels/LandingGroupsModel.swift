//
//  LandingGroupsModel.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/25/23.
//

import Foundation

struct LandingResponseModel : Codable {
    let context: String?
    let value: [LandingGroupsModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([LandingGroupsModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}


struct LandingGroupsModel : Codable {
    let msnfp_groupmembershipid : String?
    let msnfp_groupId : LandingGroupIdsModel?
    let msnfp_contactId : LandingContactIdModel?
    let sjavms_RoleType : LandingRoleTypeModel?
    
}

struct LandingGroupIdsModel : Codable {
    let msnfp_groupname : String?
    let msnfp_groupid : String?
    
    func getGroupName()->String{
        return self.msnfp_groupname ?? ""
    }
}

struct LandingContactIdModel : Codable {
    let fullname : String?
    let contactid : String?
}

struct LandingRoleTypeModel : Codable {
    let sjavms_rolecategory : CLong?
    let sjavms_roletypeid : String?
    
    func getRoleType()->String?{
        let category = self.sjavms_rolecategory
        switch category {
        case 802280000:
            return "Volunteer"
        case 802280001:
            return "Cs Lead Group"
        default:
            return nil
        }
    }
}
