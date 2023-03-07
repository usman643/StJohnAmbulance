//
//  EventsModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 31/01/2023.
//

import Foundation

struct CurrentEventsResponseModel : Codable{
    let context: String?
    let value: [CurrentEventsModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([CurrentEventsModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct CurrentEventsModel: Codable {
    
    let msnfp_engagementopportunitytitle : String?
    let msnfp_startingdate : String?
    let msnfp_location : String?
    let msnfp_engagementopportunitystatus : Int?
    let _sjavms_program_value : String?
    let msnfp_engagementopportunityid : String?
    let msnfp_endingdate : String?
    let msnfp_maximum : Int?
    let msnfp_minimum : Int?
    let _sjavms_contact_value : String?
    let sjavms_msnfp_engagementopportunity_msnfp_group : CurrentEventGroupModel?
    
}


struct CurrentEventGroupModel : Codable {

//    let _sjavms_owningteam_value : String?
//    let _sjavms_program_value : String?
//    let modifiedon : String?
//    let _owninguser_value : String?
//    let _sjavms_groupid_value : String?
//    let sjavms_emergencymanagement : String?
//    let overriddencreatedon : String?
//    let _sjavms_roletype_value : String?
//    let importsequencenumber : String?
//    let _modifiedonbehalfby_value : String?
//    let msnfp_groupname : String?
//    let msnfp_groupid : String?
//    let statecode : String?
//    let _sjavms_branch_value : String?
//    let versionnumber : String?
//    let utcconversiontimezonecode : String?
//    let _createdonbehalfby_value : String?
//    let msnfp_description : String?
//    let _modifiedby_value : String?
//    let createdon : String?
//    let _owningbusinessunit_value : String?
//    let msnfp_grouptype : String?
//    let sjavms_unitnumber : String?
//    let statuscode : String?
//    let _owningteam_value : String?
//    let _createdby_value : String?
//    let _ownerid_value : String?
//    let timezoneruleversionnumber : String?
//    

    
}
