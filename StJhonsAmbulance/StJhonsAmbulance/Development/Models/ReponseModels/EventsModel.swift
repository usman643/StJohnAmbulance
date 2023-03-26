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
    let sjavms_maxparticipants : Int?
    let sjavms_msnfp_engagementopportunity_msnfp_group : CurrentEventGroupModel?
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

struct EventProgramResponseModel : Codable{
    let value : [EventProgramDataModel]?
    
}
struct EventProgramDataModel : Codable {
    let msnfp_groupid : String?
    let sjavms_Program : EventProgramModel?
}

struct EventProgramModel :Codable {
    let sjavms_name : String?
    let sjavms_programid : String?
}

struct EventBranchResponseModel : Codable{
    let value : [EventBranchModel]?
    
}

struct EventBranchModel : Codable {

    let sjavms_name : String?
    let _sjavms_council_value : String?
    let sjavms_branchid : String?
    
}

struct EventCouncilResponseModel : Codable{
    let value : [EventCouncilModel]?
    
}

struct EventCouncilModel : Codable {

    let sjavms_name : String?
    let _sjavms_council_value : String?
    let sjavms_branchid : String?
    
}

//=================== Clicked ====================

struct VolunteerEventClickShiftDetailResponseModel : Codable{
    let value : [VolunteerEventClickShiftDetailModel]?
    
}

struct VolunteerEventClickShiftDetailModel : Codable {
    
    let msnfp_location : String?
    let msnfp_engagementopportunitytitle : String?
    let msnfp_shortdescription : String?
    let msnfp_qualifications : String?
    let msnfp_startingdate : String?
    let msnfp_endingdate : String?
    let msnfp_locationname : String?
    let msnfp_shifts : Bool?
    let msnfp_locationcitystate : String?
    let msnfp_publicengagementopportunityid : String?
    
}

struct  VolunteerEventClickOptionResponseModel: Codable{
    let value : [VolunteerEventClickOptionModel]?
    
}

struct VolunteerEventClickOptionModel : Codable {
    
    let statecode : Int?
    let msnfp_effectivefrom : String?
    let msnfp_effectiveto : String?
    let msnfp_engagementopportunityscheduleid : String?
    let msnfp_hours : Float?
    let msnfp_number : Int?
    let msnfp_maximum : Int?
    let msnfp_minimum : Int?
    let msnfp_engagementopportunityschedule : String?
    
}


struct  VolunteerEventParticipationCheckResponseModel: Codable{
    let value : [VolunteerEventParticipationCheckModel]?
    
}

struct VolunteerEventParticipationCheckModel : Codable {
    
    let statecode : Int?
    let createdon : String?
    let msnfp_participationid : String?
    let _ownerid_value : String?
    let _msnfp_contactid_value : String?
    let modifiedon : String?
    let msnfp_hours : Float?
    let versionnumber : Int?
    let msnfp_status : Int?
    let timezoneruleversionnumber : Int?
    let statuscode : Int?
    let _modifiedby_value : String?
    let _modifiedonbehalfby_value : String?
    let sjavms_totalpendinghours : Float?
    let msnfp_participationtitle : String?
    let _createdby_value : String?
    let _owningbusinessunit_value : String?
    let _owninguser_value : String?
    let msnfp_enddate : String?
    let _msnfp_engagementopportunityid_value : String?
    let msnfp_startdate : String?
    
//    let msnfp_description : String?
//    let _owningteam_value : String?
//    let overriddencreatedon : String?
//    let _msnfp_volunteergroupid_value : String?
//    let importsequencenumber : String?
//    let _msnfp_participationtypeid_value : String?
//    let _createdonbehalfby_value : String?
//    let utcconversiontimezonecode : String?
    
}


struct  ParticipantsCountResponseModel: Codable{
    let value : [ParticipantsCountModel]?
    
}

struct ParticipantsCountModel : Codable {
    let msnfp_status : Int?
    let Participation : Int?
    
}



struct  OrgnizerEventResponseModel: Codable{
    let value : [OrgnizerEventModel]?
    
}

struct OrgnizerEventModel : Codable {
    
    let msnfp_engagementopportunitytitle : String?
    let msnfp_engagementopportunityid : String?
    let sjavms_Contact : OrgnizerContactModel?
    
}

struct OrgnizerContactModel : Codable {
    
    let emailaddress1 : String?
    let address1_country : String?
    let address1_line1 : String?
    let address1_line3 : String?
    let address1_city : String?
    let lastname : String?
    let firstname : String?
    let address1_postalcode : String?
    let telephone1 : String?
    let address1_stateorprovince : String?
    let address1_line2 : String?
    let adx_organizationname : String?
    let contactid : String?

    
}

