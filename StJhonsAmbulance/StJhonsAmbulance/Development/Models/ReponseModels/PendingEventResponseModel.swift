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
    let odataEtag : String?
    let sjavms_name : String?
    let sjavms_address1name : String?
    let sjavms_maxvolunteers : Int?
    let sjavms_eventstartdate : String?
    let statecode : Int?
    let _sjavms_program_value : String?
    let sjavms_eventrequestid : String?
    let sjavms_msnfp_group_sjavms_eventrequest : [PendingApprovalGroupEventRequestModel]?
    let sjavms_msnfp_group_sjavms_eventrequest_nextLink : String?
    
    
    enum CodingKeys: String, CodingKey {
        case odataEtag = "@odata.etag"
        case sjavms_name
        case sjavms_address1name
        case sjavms_maxvolunteers
        case sjavms_eventstartdate
        case statecode
        case _sjavms_program_value
        case sjavms_eventrequestid
        case sjavms_msnfp_group_sjavms_eventrequest
        case sjavms_msnfp_group_sjavms_eventrequest_nextLink = "sjavms_msnfp_group_sjavms_eventrequest@odata.nextLink"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.odataEtag = try container.decodeIfPresent(String.self, forKey: .odataEtag)
        self.sjavms_name = try container.decodeIfPresent(String.self, forKey: .sjavms_name)
        self.sjavms_address1name = try container.decodeIfPresent(String.self, forKey: .sjavms_address1name)
        self.sjavms_maxvolunteers = try container.decodeIfPresent(Int.self, forKey: .sjavms_maxvolunteers)
        self.sjavms_eventstartdate = try container.decodeIfPresent(String.self, forKey: .sjavms_eventstartdate)
        self.statecode = try container.decodeIfPresent(Int.self, forKey: .statecode)
        self._sjavms_program_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_program_value)
        self.sjavms_eventrequestid = try container.decodeIfPresent(String.self, forKey: .sjavms_eventrequestid)
        self.sjavms_msnfp_group_sjavms_eventrequest_nextLink = try container.decodeIfPresent(String.self, forKey: .sjavms_msnfp_group_sjavms_eventrequest_nextLink)
        self.sjavms_msnfp_group_sjavms_eventrequest = try container.decodeIfPresent([PendingApprovalGroupEventRequestModel].self, forKey: .sjavms_msnfp_group_sjavms_eventrequest)
    }
    
}
    

struct PendingApprovalGroupEventRequestModel :Codable {
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
    let msnfp_grouptype : CLong?
    let sjavms_unitnumber : String?
    let statuscode : Int?
//    let _owningteam_value : String?
    let _createdby_value : String?
    let _ownerid_value : String?
//    let timezoneruleversionnumber : String?

    
    enum CodingKeys: String, CodingKey {
        case odataEtag
//        case _sjavms_owningteam_value
        case _sjavms_program_value
        case modifiedon
        case _owninguser_value
        case _sjavms_groupid_value
        case sjavms_emergencymanagement
//        case overriddencreatedon
        case _sjavms_roletype_value
//        case importsequencenumber
//        case _modifiedonbehalfby_value
        case msnfp_groupname
        case msnfp_groupid
        case statecode
        case _sjavms_branch_value
        case versionnumber
//        case utcconversiontimezonecode
//        case _createdonbehalfby_value
//        case msnfp_description
        case _modifiedby_value
        case createdon
        case _owningbusinessunit_value
        case msnfp_grouptype
        case sjavms_unitnumber
        case statuscode
//        case _owningteam_value
        case _createdby_value
        case _ownerid_value
//        case timezoneruleversionnumber
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.odataEtag = try container.decodeIfPresent(String.self, forKey: .odataEtag)
//        self._sjavms_owningteam_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_owningteam_value)
        self._sjavms_program_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_program_value)
        self.modifiedon = try container.decodeIfPresent(String.self, forKey: .modifiedon)
        self._owninguser_value = try container.decodeIfPresent(String.self, forKey: ._owninguser_value)
        self._sjavms_groupid_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_groupid_value)
        self.sjavms_emergencymanagement = try container.decodeIfPresent(Bool.self, forKey: .sjavms_emergencymanagement)
//        self.overriddencreatedon = try container.decodeIfPresent(String.self, forKey: .overriddencreatedon)
        self._sjavms_roletype_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_roletype_value)
//        self.importsequencenumber = try container.decodeIfPresent(String.self, forKey: .importsequencenumber)
//        self._modifiedonbehalfby_value = try container.decodeIfPresent(String.self, forKey: ._modifiedonbehalfby_value)
        self.msnfp_groupname = try container.decodeIfPresent(String.self, forKey: .msnfp_groupname)
        self.msnfp_groupid = try container.decodeIfPresent(String.self, forKey: .msnfp_groupid)
        self.statecode = try container.decodeIfPresent(Int.self, forKey: .statecode)
        self._sjavms_branch_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_branch_value)
        self.versionnumber = try container.decodeIfPresent(Int.self, forKey: .versionnumber)
//        self.utcconversiontimezonecode = try container.decodeIfPresent(String.self, forKey: .utcconversiontimezonecode)
//        self._createdonbehalfby_value = try container.decodeIfPresent(String.self, forKey: ._createdonbehalfby_value)
//        self.msnfp_description = try container.decodeIfPresent(String.self, forKey: .msnfp_description)
        self._modifiedby_value = try container.decodeIfPresent(String.self, forKey: ._modifiedby_value)
        self.createdon = try container.decodeIfPresent(String.self, forKey: .createdon)
        self._owningbusinessunit_value = try container.decodeIfPresent(String.self, forKey: ._owningbusinessunit_value)
        self.msnfp_grouptype = try container.decodeIfPresent(CLong.self, forKey: .msnfp_grouptype)
        self.sjavms_unitnumber = try container.decodeIfPresent(String.self, forKey: .sjavms_unitnumber)
        self.statuscode = try container.decodeIfPresent(Int.self, forKey: .statuscode)
//        self._owningteam_value = try container.decodeIfPresent(String.self, forKey: ._owningteam_value)
        self._createdby_value = try container.decodeIfPresent(String.self, forKey: ._createdby_value)
        self._ownerid_value = try container.decodeIfPresent(String.self, forKey: ._ownerid_value)
//        self.timezoneruleversionnumber = try container.decodeIfPresent(String.self, forKey: .timezoneruleversionnumber)
    }
    
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
    let sjavms_msnfp_engagementopportunity_msnfp_group_nextLink : String?
    let sjavms_msnfp_engagementopportunity_msnfp_group : [UnpublishedEventsGroupModel]?
    
    enum CodingKeys: String,CodingKey {
        case odataEtag = "@odata.etag"
        case msnfp_engagementopportunitytitle
        case msnfp_location
        case msnfp_minimum
        case msnfp_startingdate
        case msnfp_engagementopportunitystatus
        case _sjavms_program_value
        case msnfp_engagementopportunityid
        case msnfp_maximum
        case sjavms_msnfp_engagementopportunity_msnfp_group
        case sjavms_msnfp_engagementopportunity_msnfp_group_nextLink = "sjavms_msnfp_engagementopportunity_msnfp_group@odata.nextLink"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.odataEtag = try container.decodeIfPresent(String.self, forKey: .odataEtag)
        self.msnfp_engagementopportunitytitle = try container.decodeIfPresent(String.self, forKey: .msnfp_engagementopportunitytitle)
        self.msnfp_location = try container.decodeIfPresent(String.self, forKey: .msnfp_location)
        self.msnfp_minimum = try container.decodeIfPresent(Int.self, forKey: .msnfp_minimum)
        self.msnfp_startingdate = try container.decodeIfPresent(String.self, forKey: .msnfp_startingdate)
        self.msnfp_engagementopportunitystatus = try container.decodeIfPresent(Int.self, forKey: .msnfp_engagementopportunitystatus)
        self._sjavms_program_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_program_value)
        self.msnfp_engagementopportunityid = try container.decodeIfPresent(String.self, forKey: .msnfp_engagementopportunityid)
        self.msnfp_maximum = try container.decodeIfPresent(Int.self, forKey: .msnfp_maximum)
        self.sjavms_msnfp_engagementopportunity_msnfp_group_nextLink = try container.decodeIfPresent(String.self, forKey: .sjavms_msnfp_engagementopportunity_msnfp_group_nextLink)
        self.sjavms_msnfp_engagementopportunity_msnfp_group = try container.decodeIfPresent([UnpublishedEventsGroupModel].self, forKey: .sjavms_msnfp_engagementopportunity_msnfp_group)
    }
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
    
    enum CodingKeys: String, CodingKey {
        case odataEtag = "@odata.etag"
//        case _sjavms_owningteam_value
        case _sjavms_program_value
        case modifiedon
        case _owninguser_value
        case _sjavms_groupid_value
        case sjavms_emergencymanagement
//        case overriddencreatedon
        case _sjavms_roletype_value
//        case importsequencenumber
//        case _modifiedonbehalfby_value
        case msnfp_groupname
        case msnfp_groupid
        case statecode
        case _sjavms_branch_value
        case versionnumber
//        case utcconversiontimezonecode
//        case _createdonbehalfby_value
//        case msnfp_description
        case _modifiedby_value
        case createdon
        case _owningbusinessunit_value
        case msnfp_grouptype
        case sjavms_unitnumber
        case statuscode
//        case _owningteam_value
        case _createdby_value
        case _ownerid_value
//        case timezoneruleversionnumber
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.odataEtag = try container.decodeIfPresent(String.self, forKey: .odataEtag)
//        self._sjavms_owningteam_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_owningteam_value)
        self._sjavms_program_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_program_value)
        self.modifiedon = try container.decodeIfPresent(String.self, forKey: .modifiedon)
        self._owninguser_value = try container.decodeIfPresent(String.self, forKey: ._owninguser_value)
        self._sjavms_groupid_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_groupid_value)
        self.sjavms_emergencymanagement = try container.decodeIfPresent(Bool.self, forKey: .sjavms_emergencymanagement)
//        self.overriddencreatedon = try container.decodeIfPresent(String.self, forKey: .overriddencreatedon)
        self._sjavms_roletype_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_roletype_value)
//        self.importsequencenumber = try container.decodeIfPresent(String.self, forKey: .importsequencenumber)
//        self._modifiedonbehalfby_value = try container.decodeIfPresent(String.self, forKey: ._modifiedonbehalfby_value)
        self.msnfp_groupname = try container.decodeIfPresent(String.self, forKey: .msnfp_groupname)
        self.msnfp_groupid = try container.decodeIfPresent(String.self, forKey: .msnfp_groupid)
        self.statecode = try container.decodeIfPresent(Int.self, forKey: .statecode)
        self._sjavms_branch_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_branch_value)
        self.versionnumber = try container.decodeIfPresent(Int.self, forKey: .versionnumber)
//        self.utcconversiontimezonecode = try container.decodeIfPresent(String.self, forKey: .utcconversiontimezonecode)
//        self._createdonbehalfby_value = try container.decodeIfPresent(String.self, forKey: ._createdonbehalfby_value)
//        self.msnfp_description = try container.decodeIfPresent(String.self, forKey: .msnfp_description)
        self._modifiedby_value = try container.decodeIfPresent(String.self, forKey: ._modifiedby_value)
        self.createdon = try container.decodeIfPresent(String.self, forKey: .createdon)
        self._owningbusinessunit_value = try container.decodeIfPresent(String.self, forKey: ._owningbusinessunit_value)
        self.msnfp_grouptype = try container.decodeIfPresent(Int.self, forKey: .msnfp_grouptype)
        self.sjavms_unitnumber = try container.decodeIfPresent(String.self, forKey: .sjavms_unitnumber)
        self.statuscode = try container.decodeIfPresent(Int.self, forKey: .statuscode)
//        self._owningteam_value = try container.decodeIfPresent(String.self, forKey: ._owningteam_value)
        self._createdby_value = try container.decodeIfPresent(String.self, forKey: ._createdby_value)
        self._ownerid_value = try container.decodeIfPresent(String.self, forKey: ._ownerid_value)
//        self.timezoneruleversionnumber = try container.decodeIfPresent(String.self, forKey: .timezoneruleversionnumber)
    }
    
}
