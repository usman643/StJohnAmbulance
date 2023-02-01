//
//  PendingShiftResponseModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 31/01/2023.
//

import Foundation


struct PendingShiftResponseModelOne : Codable {
    let context: String?
    let value: [PendingShiftModelOne]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([PendingShiftModelOne].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
}

struct PendingShiftModelOne : Codable {
    
    let odataEtag : String?
    let msnfp_engagementopportunitytitle : String?
    let msnfp_engagementopportunitystatus : Int?
    let msnfp_needsreviewedparticipants : Int?
    let msnfp_minimum : Int?
    let msnfp_maximum : Int?
    let _sjavms_group_value : String?
    let msnfp_endingdate : String?
    let msnfp_cancelledparticipants : Int?
    let msnfp_appliedparticipants : Int?
    let msnfp_startingdate : String?
    let msnfp_engagementopportunityid : String?
    let sjavms_msnfp_engagementopportunity_msnfp_group : [PendingShiftVolunteerModelOne]?
    let sjavms_msnfp_engagementopportunity_msnfp_groupOdataNextLink : String?

    enum CodingKeys: String, CodingKey {
        
        case odataEtag = "@odata.etag"
        case msnfp_engagementopportunitytitle
        case msnfp_engagementopportunitystatus
        case msnfp_needsreviewedparticipants
        case msnfp_minimum
        case msnfp_maximum
        case _sjavms_group_value
        case msnfp_endingdate
        case msnfp_cancelledparticipants
        case msnfp_appliedparticipants
        case msnfp_startingdate
        case msnfp_engagementopportunityid
        case sjavms_msnfp_engagementopportunity_msnfp_group
        case sjavms_msnfp_engagementopportunity_msnfp_groupOdataNextLink = "sjavms_msnfp_engagementopportunity_msnfp_group@odata.nextLink"
        
        }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.odataEtag = try container.decodeIfPresent(String.self, forKey: .odataEtag)
        self.msnfp_engagementopportunitytitle = try container.decodeIfPresent(String.self, forKey: .msnfp_engagementopportunitytitle)
        self.msnfp_engagementopportunitystatus = try container.decodeIfPresent(Int.self, forKey: .msnfp_engagementopportunitystatus)
        self.msnfp_needsreviewedparticipants = try container.decodeIfPresent(Int.self, forKey: .msnfp_needsreviewedparticipants)
        self.msnfp_minimum = try container.decodeIfPresent(Int.self, forKey: .msnfp_minimum)
        self.msnfp_maximum = try container.decodeIfPresent(Int.self, forKey: .msnfp_maximum)
        self._sjavms_group_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_group_value)
        self.msnfp_endingdate = try container.decodeIfPresent(String.self, forKey: .msnfp_endingdate)
        self.msnfp_cancelledparticipants = try container.decodeIfPresent(Int.self, forKey: .msnfp_cancelledparticipants)
        self.msnfp_appliedparticipants = try container.decodeIfPresent(Int.self, forKey: .msnfp_appliedparticipants)
        self.msnfp_startingdate = try container.decodeIfPresent(String.self, forKey: .msnfp_startingdate)
        self.msnfp_engagementopportunityid = try container.decodeIfPresent(String.self, forKey: .msnfp_engagementopportunityid)
        self.sjavms_msnfp_engagementopportunity_msnfp_group = try container.decodeIfPresent([PendingShiftVolunteerModelOne].self, forKey: .sjavms_msnfp_engagementopportunity_msnfp_group)
        self.sjavms_msnfp_engagementopportunity_msnfp_groupOdataNextLink = try container.decodeIfPresent(String.self, forKey: .sjavms_msnfp_engagementopportunity_msnfp_groupOdataNextLink)
    }
}


struct PendingShiftVolunteerModelOne : Codable {
    
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



//==========================PendingShiftResponseModelTwo================================//


struct PendingShiftResponseModelTwo : Codable {
    let context: String?
    let value: [PendingShiftModelTwo]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([PendingShiftModelTwo].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct PendingShiftModelTwo : Codable {
    
    let odataEtag : String?
//    let msnfp_name : String?
    let createdon : String?
    let msnfp_participationscheduleid : String?
    let msnfp_schedulestatus : Int?
    let sjavms_start : String?
    let sjavms_hours : Float?
    let _sjavms_volunteerevent_value : String?
    let _sjavms_volunteer_value : String?
    let sjavms_Volunteer : PendingShiftVolunteerModelTwo?

    enum CodingKeys: String, CodingKey {
        
            case odataEtag = "@odata.etag"
//            case msnfp_name
            case createdon
            case msnfp_participationscheduleid
            case msnfp_schedulestatus
            case sjavms_start
            case sjavms_hours
            case _sjavms_volunteerevent_value
            case _sjavms_volunteer_value
            case sjavms_Volunteer
        }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.odataEtag = try container.decodeIfPresent(String.self, forKey: .odataEtag)
//        self.msnfp_name = try container.decodeIfPresent(String.self, forKey: .msnfp_name)
        self.createdon = try container.decodeIfPresent(String.self, forKey: .createdon)
        self.msnfp_participationscheduleid = try container.decodeIfPresent(String.self, forKey: .msnfp_participationscheduleid)
        self.msnfp_schedulestatus = try container.decodeIfPresent(Int.self, forKey: .msnfp_schedulestatus)
        self.sjavms_start = try container.decodeIfPresent(String.self, forKey: .sjavms_start)
        self.sjavms_hours = try container.decodeIfPresent(Float.self, forKey: .sjavms_hours)
        self._sjavms_volunteerevent_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_volunteerevent_value)
        self._sjavms_volunteer_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_volunteer_value)
        self.sjavms_Volunteer = try container.decodeIfPresent(PendingShiftVolunteerModelTwo.self, forKey: .sjavms_Volunteer)
        
    }
}


struct PendingShiftVolunteerModelTwo : Codable {
    let fullname : String?
    let contactid : String?
}

//========================PendingShiftResponseModelThree==========================//




struct PendingShiftResponseModelThree : Codable {
    let context: String?
    let value: [PendingShiftModelThree]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([PendingShiftModelThree].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct PendingShiftModelThree : Codable {
    
    let odataEtag : String?
    let msnfp_engagementopportunityschedule : String?
    let createdon : String?
//    let msnfp_totalhours : String?
//    let msnfp_startperiod : String?
//    let msnfp_hoursperday : String?
    let _msnfp_engagementopportunity_value : String?
//    let msnfp_endperiod : String?
    let msnfp_effectiveto : String?
    let msnfp_effectivefrom : String?
//    let msnfp_workingdays : String?
    let msnfp_engagementopportunityscheduleid : String?
    

    enum CodingKeys: String, CodingKey {
        
        case odataEtag = "@odata.etag"
        case msnfp_engagementopportunityschedule
        case createdon
//        case msnfp_totalhours
//        case msnfp_startperiod
//        case msnfp_hoursperday
        case _msnfp_engagementopportunity_value
//        case msnfp_endperiod
        case msnfp_effectiveto
        case msnfp_effectivefrom
//        case msnfp_workingdays
        case msnfp_engagementopportunityscheduleid
        
        
        }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.odataEtag = try container.decodeIfPresent(String.self, forKey: .odataEtag)
        self.msnfp_engagementopportunityschedule = try container.decodeIfPresent(String.self, forKey: .msnfp_engagementopportunityschedule)
        self.createdon = try container.decodeIfPresent(String.self, forKey: .createdon)
//        self.msnfp_totalhours = try container.decodeIfPresent(String.self, forKey: .msnfp_totalhours)
//        self.msnfp_startperiod = try container.decodeIfPresent(String.self, forKey: .msnfp_startperiod)
//        self.msnfp_hoursperday = try container.decodeIfPresent(String.self, forKey: .msnfp_hoursperday)
        self._msnfp_engagementopportunity_value = try container.decodeIfPresent(String.self, forKey: ._msnfp_engagementopportunity_value)
//        self.msnfp_endperiod = try container.decodeIfPresent(String.self, forKey: .msnfp_endperiod)
        self.msnfp_effectiveto = try container.decodeIfPresent(String.self, forKey: .msnfp_effectiveto)
        self.msnfp_effectivefrom = try container.decodeIfPresent(String.self, forKey: .msnfp_effectivefrom)
//        self.msnfp_workingdays = try container.decodeIfPresent(String.self, forKey: .msnfp_workingdays)
        self.msnfp_engagementopportunityscheduleid = try container.decodeIfPresent(String.self, forKey: .msnfp_engagementopportunityscheduleid)
        
    }
}
