//
//  PendingEventResponseModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 02/02/2023.
//

import Foundation

struct PendingApprovalEventsResponseModel : Codable{
    let context: String?
    let value: [PendingApprovalEventsModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([PendingApprovalEventsModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct PendingApprovalEventsModel: Codable {

    let sjavms_name : String?
    let sjavms_address1name : String?
    let sjavms_maxvolunteers : Int?
    let sjavms_eventstartdate : String?
    let statecode : Int?
    let _sjavms_program_value : String?
    let sjavms_eventrequestid : String?
    let sjavms_msnfp_group_sjavms_eventrequest : [PendingApprovalGroupEventRequestModel]?
   
    
}
    

struct PendingApprovalGroupEventRequestModel :Codable {

//    let _sjavms_owningteam_value : String?
    let _sjavms_program_value : String?
    let modifiedon : String?
    let _owninguser_value : String?
    let _sjavms_groupid_value : String?
    let sjavms_emergencymanagement : Bool?
//    let overriddencreatedon : String?
    let _sjavms_roletype_value : String?
//    let importsequencenumber : String?
//    let _modifiedonbehalfby_value : String?
    let msnfp_groupname : String?
    let msnfp_groupid : String?
    let statecode : Int?
    let _sjavms_branch_value : String?
    let versionnumber : Int?
//    let utcconversiontimezonecode : String?
//    let _createdonbehalfby_value : String?
//    let msnfp_description : String?
    let _modifiedby_value : String?
    let createdon : String?
    let _owningbusinessunit_value : String?
    let msnfp_grouptype : CLong?
    let sjavms_unitnumber : String?
    let statuscode : Int?
//    let _owningteam_value : String?
    let _createdby_value : String?
    let _ownerid_value : String?
//    let timezoneruleversionnumber : String?

    
    func getStatus()->String?{
        let status = self.msnfp_grouptype
        switch status {
        case 335940000:
            return "Pending"
        case 335940001:
            return "Shift Hours Approved"
        case 335940002:
            return "No Show"
        case 335940003:
            return "Cancelled"
        case 844060000:
            return "Unpublished"
        case 844060001:
            return "Active"
        case 802280002:
            return "Submitted"
        default:
            return nil
        }
    }
    
}


















// ======================================Unpublished Event============================================ //
















struct UnpublishedEventsResponseModel : Codable{
    let context: String?
    let value: [UnpublishedEventsModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([UnpublishedEventsModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct UnpublishedEventsModel: Codable {
    let odataEtag : String?
    let msnfp_engagementopportunitytitle : String?
    let msnfp_location : String?
    let msnfp_minimum : Int?
    let msnfp_startingdate : String?
    let msnfp_engagementopportunitystatus : Int?
    let _sjavms_program_value : String?
    let msnfp_engagementopportunityid : String?
    let msnfp_maximum : Int?
    let sjavms_msnfp_engagementopportunity_msnfp_group : [UnpublishedEventsGroupModel]?
    
  
    func getStatus()->String?{
        let status = self.msnfp_engagementopportunitystatus
        switch status {
        case 335940000:
            return "Pending"
        case 335940001:
            return "Shift Hours Approved"
        case 335940002:
            return "No Show"
        case 335940003:
            return "Cancelled"
        case 844060000:
            return "Unpublished"
        case 844060001:
            return "Active"
        case 802280002:
            return "Submitted"
        default:
            return nil
        }
    }
}
    

struct UnpublishedEventsGroupModel : Codable {
    
    let odataEtag : String?
//    let _sjavms_owningteam_value : String?
    let _sjavms_program_value : String?
    let modifiedon : String?
    let _owninguser_value : String?
    let _sjavms_groupid_value : String?
    let sjavms_emergencymanagement : Bool?
//    let overriddencreatedon : String?
    let _sjavms_roletype_value : String?
//    let importsequencenumber : String?
//    let _modifiedonbehalfby_value : String?
    let msnfp_groupname : String?
    let msnfp_groupid : String?
    let statecode : Int?
    let _sjavms_branch_value : String?
    let versionnumber : Int?
//    let utcconversiontimezonecode : String?
//    let _createdonbehalfby_value : String?
//    let msnfp_description : String?
    let _modifiedby_value : String?
    let createdon : String?
    let _owningbusinessunit_value : String?
    let msnfp_grouptype : Int?
    let sjavms_unitnumber : String?
    let statuscode : Int?
//    let _owningteam_value : String?
    let _createdby_value : String?
    let _ownerid_value : String?
//    let timezoneruleversionnumber : String?
    
    
}

