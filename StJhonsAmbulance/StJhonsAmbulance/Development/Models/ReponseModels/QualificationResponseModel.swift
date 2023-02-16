//
//  QualificationResponseModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 16/02/2023.
//

import Foundation


struct ExternalQualificationResponseModel: Codable {
    let value: [ExternalQualificationDataModel]?
}

struct ExternalQualificationDataModel : Codable{
    
    let sjavms_name : String?
    let _sjavms_qualification_value : String?
    let sjavms_issuedate : String?
    let sjavms_expirydate : String?
    let sjavms_verifiedqualificationid : String?
    let sjavms_Qualification : ExternalQualificationModel?
    
}

struct ExternalQualificationModel : Codable{
    let sjavms_type : Int?
    let sjavms_vmsqualificationid : String?
    
}



struct SJAQualificationResponseModel: Codable {
    let value: [SJAQualificationDataModel]?
}

struct SJAQualificationDataModel : Codable {
    
    let bdo_qualificationtype : Int?
    let bdo_expirationdate : String?
    let bdo_effectivedate : String?
    let _bdo_qualificationsid_value : String?
    let bdo_qualificationgainedid : String?
    
}

