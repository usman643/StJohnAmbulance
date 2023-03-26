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
