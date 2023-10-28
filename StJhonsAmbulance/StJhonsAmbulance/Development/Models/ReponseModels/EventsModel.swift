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
    let address1_line1 : String?
    let msnfp_location : String?
    let msnfp_engagementopportunitystatus : Int?
    let _sjavms_program_value : String?
    let msnfp_engagementopportunityid : String?
    let msnfp_endingdate : String?
    let msnfp_maximum : Int?
    let msnfp_minimum : Int?
    let _sjavms_contact_value : String?
    let sjavms_maxparticipants : Int?
    let sjavms_checkedin : Bool?
    let sjavms_program_value : String?
    var time_difference : Int?
    let msnfp_description : String?
    let msnfp_shortdescription : String?
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
            return ""
        }
    }
    
    enum CodingKeys: String , CodingKey {
        case msnfp_engagementopportunitytitle
        case msnfp_startingdate
        case address1_line1
        case msnfp_location
        case msnfp_engagementopportunitystatus
        case _sjavms_program_value
        case msnfp_engagementopportunityid
        case msnfp_endingdate
        case msnfp_maximum
        case msnfp_minimum
        case _sjavms_contact_value
        case sjavms_maxparticipants
        case sjavms_checkedin
        case sjavms_program_value = "_sjavms_program_value@OData.Community.Display.V1.FormattedValue"
        case time_difference
        case msnfp_description
        case msnfp_shortdescription
        case sjavms_msnfp_engagementopportunity_msnfp_group
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
    let msnfp_status : Int?
    
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
    var event_selected : Bool?
    let msnfp_participationid : String?
    let statuscode : Int?
    let msnfp_engagementopportunityschedule : String?
//    var msnfp_participationscheduleid : String?
//    var msnfp_schedulestatus : Int?
    
    
    let createdon : String?
    let msnfp_totalhours : Float?
    let msnfp_startperiod : Float?
    let msnfp_hoursperday : Float?
    let _msnfp_engagementopportunity_value : String?
    let msnfp_endperiod : String?
    let msnfp_workingdays : String?
    var msnfp_ParticipationSchedule_engagementOpp : [ParticipationScheduleEngagementOppModel]?
    
     func filterdata() -> [ParticipationScheduleEngagementOppModel]?{

        let conId = UserDefaults.standard.contactIdToken ?? ""
        var msnfp_ParticipationSchedule_engagementOppFilter : [ParticipationScheduleEngagementOppModel]? = []
        
        msnfp_ParticipationSchedule_engagementOppFilter = msnfp_ParticipationSchedule_engagementOpp?.filter({
            
            if($0._sjavms_volunteer_value == conId){
                return true
            }
            return false
        })
        return msnfp_ParticipationSchedule_engagementOppFilter
    }
   
    
    
}
 

struct ParticipationScheduleEngagementOppModel: Codable {
    
    let msnfp_participationscheduleid : String?
    let _msnfp_participationid_value : String?
    let _sjavms_volunteer_value : String?
    let msnfp_name : String?
    let msnfp_schedulestatus : Int?
    let _msnfp_engagementopportunityscheduleid_value : String?
    var participation_selected : Bool?
    
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



struct OtherVolunteerParticipationResponseModel : Codable{
  
    let value : [OtherVolunteerParticipationModel]?
}

struct OtherVolunteerParticipationModel : Codable {
    
    let createdonData: String?
    let createdon : String?
    let _msnfp_engagementopportunityid_valueData : String?
    let _msnfp_engagementopportunityid_value : String?
    let _msnfp_contactid_valueData : String?
    let _msnfp_contactid_value : String?
//    let sjavms_totalpendinghours : Float?
//    let sjavms_totalpendinghoursData : String?
    let msnfp_hoursData : String?
    let msnfp_hours : Float?
    let msnfp_participationid : String?
    let msnfp_participationtitle : String?
    let msnfp_startdateData : String?
    let msnfp_startdate : String?
    let msnfp_enddateData : String?
    let msnfp_enddate : String?
    var volunteerName : String?
    var eventName : String?
    
    enum CodingKeys: String, CodingKey {
        case createdonData = "createdon@OData.Community.Display.V1.FormattedValue"
        case createdon
        case _msnfp_engagementopportunityid_valueData = "_msnfp_engagementopportunityid_value@OData.Community.Display.V1.FormattedValue"
        case _msnfp_engagementopportunityid_value
        case _msnfp_contactid_valueData = "_msnfp_contactid_value@OData.Community.Display.V1.FormattedValue"
        case _msnfp_contactid_value
//        case sjavms_totalpendinghours
//        case sjavms_totalpendinghoursData = "sjavms_totalpendinghours@OData.Community.Display.V1.FormattedValue"
        case msnfp_hoursData = "msnfp_hours@OData.Community.Display.V1.FormattedValue"
        case msnfp_hours
        case msnfp_participationid
        case msnfp_participationtitle
        case msnfp_startdateData = "msnfp_startdate@OData.Community.Display.V1.FormattedValue"
        case msnfp_startdate
        case msnfp_enddateData = "msnfp_enddate@OData.Community.Display.V1.FormattedValue"
        case msnfp_enddate
        case volunteerName
        case eventName
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.createdonData = try container.decodeIfPresent(String.self, forKey: .createdonData)
        self.createdon = try container.decodeIfPresent(String.self, forKey: .createdon)
        self._msnfp_engagementopportunityid_valueData = try container.decodeIfPresent(String.self, forKey: ._msnfp_engagementopportunityid_valueData)
        self._msnfp_engagementopportunityid_value = try container.decodeIfPresent(String.self, forKey: ._msnfp_engagementopportunityid_value)
        self._msnfp_contactid_valueData = try container.decodeIfPresent(String.self, forKey: ._msnfp_contactid_valueData)
        self._msnfp_contactid_value = try container.decodeIfPresent(String.self, forKey: ._msnfp_contactid_value)
//        self.sjavms_totalpendinghours = try container.decode(Float.self, forKey: .sjavms_totalpendinghours)
//        self.sjavms_totalpendinghoursData = try container.decode(String.self, forKey: .sjavms_totalpendinghoursData)
        self.msnfp_hoursData = try container.decodeIfPresent(String.self, forKey: .msnfp_hoursData)
        self.msnfp_hours = try container.decodeIfPresent(Float.self, forKey: .msnfp_hours)
        self.msnfp_participationid = try container.decodeIfPresent(String.self, forKey: .msnfp_participationid)
        self.msnfp_participationtitle = try container.decodeIfPresent(String.self, forKey: .msnfp_participationtitle)
        self.msnfp_startdateData = try container.decodeIfPresent(String.self, forKey: .msnfp_startdateData)
        self.msnfp_startdate = try container.decodeIfPresent(String.self, forKey: .msnfp_startdate)
        self.msnfp_enddateData = try container.decodeIfPresent(String.self, forKey: .msnfp_enddateData)
        self.msnfp_enddate = try container.decodeIfPresent(String.self, forKey: .msnfp_enddate)
        self.volunteerName = try container.decodeIfPresent(String.self, forKey: .volunteerName)
        self.eventName = try container.decodeIfPresent(String.self, forKey: .eventName)
    }

    
}
