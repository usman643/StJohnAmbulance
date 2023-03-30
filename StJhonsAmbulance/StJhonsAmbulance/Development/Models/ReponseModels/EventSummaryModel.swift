//
//  EventSummaryModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/03/2023.
//

import Foundation


struct  EventSummaryResponseModel: Codable{
    let value : [EventSummaryModel]?
    
}

struct EventSummaryModel : Codable {
    
    let _sjavms_group_value : String?
    let sjavms_onsiteparking : Bool?
    let sjavms_tableschairsseating : Bool?
    let msnfp_engagementopportunityid : String?
    let sjavms_designatedvolunteerarea : Bool?
    let sjavms_cleandrinkingwater : Bool?
    let sjavms_othertreatments : String?
    let sjavms_designatedspaceforvolunteers : Bool?
    let sjavms_electricalpowersupply : Bool?
    let msnfp_stateprovince : String?
    let msnfp_shortdescription : String?
    let _sjavms_program_value : String?
    let sjavms_foodforvolunteers : Bool?
    let msnfp_filledshifts : Int?
    let statuscode : Int?
    let msnfp_location : String?
    let sjavms_age1860 : Bool?
    let msnfp_description : String?
    let msnfp_maximum : Int?
    let _sjavms_branch_value : String?
    let msnfp_endingdate : String?
    let sjavms_onsitefoodforvolunteers : Bool?
    let sjavms_age13under : Bool?
    let msnfp_appliedparticipants : Int?
    let sjavms_age60 : Bool?
    let sjavms_eventscheduleinformation : String?
    let msnfp_engagementopportunitystatus : Int?
    let sjavms_bathrooms : Bool?
    let _sjavms_contact_value : String?
    let msnfp_engagementopportunitytitle : String?
    let msnfp_completed : Int?
    let sjavms_onsitecleandrinkingwater : Bool?
    let _sjavms_council_value : String?
    let msnfp_street1 : String?
    let msnfp_street2 : String?
    let sjavms_age1417 : Bool?
    let msnfp_shifts : Bool?
    let sjavms_donationreceived : Float?
    let _msnfp_primarycontactid_value : String?
    let sjavms_willotherhealthcareagenciesbeonsite : Bool?
    let msnfp_number : Int?
    let sjavms_numberofparticipants : Int?
    let msnfp_cancelledshifts : Int?
    let sjavms_multidayevent : Bool?
    let sjavms_firstaidroomtent : Bool?
    let sjavms_emergencyservicescalled : Bool?
    let sjavms_sitemapifapplicable : Bool?
    let sjavms_onsitedesignatedvolunteerarea : Bool?
    let _sjavms_eventcoordinator_value : String?
    let sjavms_totalapproved : Int?
    let sjavms_onsitecellphonereception : Bool?
    let sjavms_telephone : Bool?
    let sjavms_onsitebathrooms : Bool?
    let sjavms_onsiteother : Bool?
    let sjavms_cellphonereception : Bool?
    let _sjavms_account_value : String?
    let msnfp_locationtype : Int?
    let sjavms_patientstreated : String?
    let sjavms_onsitefirstaidroomtent : Bool?
    let _sjavms_posteventsurvey_value : String?
    let msnfp_minimum : Int?
    let sjavms_onsitetelephone : Bool?
    let msnfp_city : String?
    let sjavms_parking : Bool?
    let sjavms_eventorganizerprovidedadequatesupport : Bool?
    let msnfp_multipledays : Bool?
    let msnfp_startingdate : String?
    let sjavms_donationintended : Float?
    let msnfp_street3 : String?
    let sjavms_othercomments : String?
    let sjavms_eventrequirements : String?
    let sjavms_surveycomments : String?
    let statecode : Int?
    let sjavms_adhocevent : Bool?
    let sjavms_shadedareaifoutside : Bool?
    let msnfp_zippostalcode : String?
    let sjavms_locationcontactname : String?
    let sjavms_maxparticipants : Int?
    let _transactioncurrencyid_value : String?
    
}



struct  AuditResponseModel: Codable{
    let value : [AuditModel]?
    
}

struct AuditModel : Codable {
    
    let objectid_formatted_value : String?
    let objectid_value : String?
    let userid_value_formatted_value : String?
    let userid_value : String?
    let versionnumber_formatted_value : String?
    let versionnumber : Int?
    let operation_formatted_value : String?
    let operation : Int?
    let createdon_formatted_value : String?
    let createdon : String?
    let auditid : String?
    let changedata : String?
    let attributemask : String?
    let action_formatted_value : String?
    let action : Int?
    let objecttypecode_formatted_value: String?
    let objecttypecode : String?
    let transactionid : String?
    let _regardingobjectid_value : String?
    let useradditionalinfo : String?
    let _callinguserid_value : String?

    
    enum CodingKeys: String , CodingKey {
        case objectid_formatted_value = "_objectid_value@OData.Community.Display.V1.FormattedValue"
        case objectid_value = "_objectid_value"
        case userid_value_formatted_value = "_userid_value@OData.Community.Display.V1.FormattedValue"
        case userid_value = "_userid_value"
        case versionnumber_formatted_value = "versionnumber@OData.Community.Display.V1.FormattedValue"
        case versionnumber = "versionnumber"
        case operation_formatted_value = "operation@OData.Community.Display.V1.FormattedValue"
        case operation = "operation"
        case createdon_formatted_value = "createdon@OData.Community.Display.V1.FormattedValue"
        case createdon = "createdon"
        case auditid = "auditid"
        case changedata = "changedata"
        case attributemask = "attributemask"
        case action_formatted_value = "action@OData.Community.Display.V1.FormattedValue"
        case action = "action"
        case objecttypecode_formatted_value = "objecttypecode@OData.Community.Display.V1.FormattedValue"
        case objecttypecode = "objecttypecode"
        case transactionid = "transactionid"
        case _regardingobjectid_value = "_regardingobjectid_value"
        case useradditionalinfo = "useradditionalinfo"
        case _callinguserid_value = "_callinguserid_value"

        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.objectid_formatted_value = try container.decodeIfPresent(String.self, forKey: .objectid_formatted_value)
        self.objectid_value = try container.decodeIfPresent(String.self, forKey: .objectid_value)
        self.userid_value_formatted_value = try container.decodeIfPresent(String.self, forKey: .userid_value_formatted_value)
        self.userid_value = try container.decodeIfPresent(String.self, forKey: .userid_value)
        self.versionnumber_formatted_value = try container.decodeIfPresent(String.self, forKey: .versionnumber_formatted_value)
        self.versionnumber = try container.decodeIfPresent(Int.self, forKey: .versionnumber)
        self.operation_formatted_value = try container.decodeIfPresent(String.self, forKey: .operation_formatted_value)
        self.operation = try container.decodeIfPresent(Int.self, forKey: .operation)
        self.createdon_formatted_value = try container.decodeIfPresent(String.self, forKey: .createdon_formatted_value)
        self.createdon = try container.decodeIfPresent(String.self, forKey: .createdon)
        self.auditid = try container.decodeIfPresent(String.self, forKey: .auditid)
        self.changedata = try container.decodeIfPresent(String.self, forKey: .changedata)
        self.attributemask = try container.decodeIfPresent(String.self, forKey: .attributemask)
        self.action_formatted_value = try container.decodeIfPresent(String.self, forKey: .action_formatted_value)
        self.action = try container.decodeIfPresent(Int.self, forKey: .action)
        self.objecttypecode_formatted_value = try container.decodeIfPresent(String.self, forKey: .objecttypecode_formatted_value)
        self.objecttypecode = try container.decodeIfPresent(String.self, forKey: .objecttypecode)
        self.transactionid = try container.decodeIfPresent(String.self, forKey: .transactionid)
        self._regardingobjectid_value = try container.decodeIfPresent(String.self, forKey: ._regardingobjectid_value)
        self.useradditionalinfo = try container.decodeIfPresent(String.self, forKey: .useradditionalinfo)
        self._callinguserid_value = try container.decodeIfPresent(String.self, forKey: ._callinguserid_value)

        
    }

}

struct ChangeAttributeModel : Decodable {
    var changedAttributes : [ChangeModel]
    
}
struct ChangeModel :Codable {
    var logicalName : String?
    var oldValue : String?
    var newValue : String?
}
