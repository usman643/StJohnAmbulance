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
//    let odataEtag : String?
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
//    enum CodingKeys: String ,CodingKey {
//        case odataEtag = "@odata.etag"
//        case _sjavms_owningteam_value
//        case _sjavms_program_value
//        case modifiedon
//        case _owninguser_value
//        case _sjavms_groupid_value
//        case sjavms_emergencymanagement
//        case overriddencreatedon
//        case _sjavms_roletype_value
//        case importsequencenumber
//        case _modifiedonbehalfby_value
//        case msnfp_groupname
//        case msnfp_groupid
//        case statecode
//        case _sjavms_branch_value
//        case versionnumber
//        case utcconversiontimezonecode
//        case _createdonbehalfby_value
//        case msnfp_description
//        case _modifiedby_value
//        case createdon
//        case _owningbusinessunit_value
//        case msnfp_grouptype
//        case sjavms_unitnumber
//        case statuscode
//        case _owningteam_value
//        case _createdby_value
//        case _ownerid_value
//        case timezoneruleversionnumber
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.odataEtag = try container.decodeIfPresent(String.self, forKey: .odataEtag)
//        self._sjavms_owningteam_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_owningteam_value)
//        self._sjavms_program_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_program_value)
//        self.modifiedon = try container.decodeIfPresent(String.self, forKey: .modifiedon)
//        self._owninguser_value = try container.decodeIfPresent(String.self, forKey: ._owninguser_value)
//        self._sjavms_groupid_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_groupid_value)
//        self.sjavms_emergencymanagement = try container.decodeIfPresent(String.self, forKey: .sjavms_emergencymanagement)
//        self.overriddencreatedon = try container.decodeIfPresent(String.self, forKey: .overriddencreatedon)
//        self._sjavms_roletype_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_roletype_value)
//        self.importsequencenumber = try container.decodeIfPresent(String.self, forKey: .importsequencenumber)
//        self._modifiedonbehalfby_value = try container.decodeIfPresent(String.self, forKey: ._modifiedonbehalfby_value)
//        self.msnfp_groupname = try container.decodeIfPresent(String.self, forKey: .msnfp_groupname)
//        self.msnfp_groupid = try container.decodeIfPresent(String.self, forKey: .msnfp_groupid)
//        self.statecode = try container.decodeIfPresent(String.self, forKey: .statecode)
//        self._sjavms_branch_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_branch_value)
//        self.versionnumber = try container.decodeIfPresent(String.self, forKey: .versionnumber)
//        self.utcconversiontimezonecode = try container.decodeIfPresent(String.self, forKey: .utcconversiontimezonecode)
//        self._createdonbehalfby_value = try container.decodeIfPresent(String.self, forKey: ._createdonbehalfby_value)
//        self.msnfp_description = try container.decodeIfPresent(String.self, forKey: .msnfp_description)
//        self._modifiedby_value = try container.decodeIfPresent(String.self, forKey: ._modifiedby_value)
//        self.createdon = try container.decodeIfPresent(String.self, forKey: .createdon)
//        self._owningbusinessunit_value = try container.decodeIfPresent(String.self, forKey: ._owningbusinessunit_value)
//        self.msnfp_grouptype = try container.decodeIfPresent(String.self, forKey: .msnfp_grouptype)
//        self.sjavms_unitnumber = try container.decodeIfPresent(String.self, forKey: .sjavms_unitnumber)
//        self.statuscode = try container.decodeIfPresent(String.self, forKey: .statuscode)
//        self._owningteam_value = try container.decodeIfPresent(String.self, forKey: ._owningteam_value)
//        self._createdby_value = try container.decodeIfPresent(String.self, forKey: ._createdby_value)
//        self._ownerid_value = try container.decodeIfPresent(String.self, forKey: ._ownerid_value)
//        self.timezoneruleversionnumber = try container.decodeIfPresent(String.self, forKey: .timezoneruleversionnumber)
//    }
//    
    
}
