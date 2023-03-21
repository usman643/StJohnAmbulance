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
    var sjavms_Qualification : ExternalQualificationModel?
    
}

struct ExternalQualificationModel : Codable{
    let sjavms_type : Int?
    let sjavms_name : String?
    let sjavms_vmsqualificationid : String?
    var sjavms_type_value : String?
}



struct SJAQualificationResponseModel: Codable {
    let value: [SJAQualificationDataModel]?
}

struct SJAQualificationDataModel : Codable {
    
    let bdo_qualificationtype : Int?
    var bdo_type_value : String?
    let bdo_expirationdate : String?
    let bdo_effectivedate : String?
    let _bdo_qualificationsid_value : String?
    let bdo_qualificationgainedid : String?
    let bdo_qualificationsid : QualificationsIdModel?
    
}

struct QualificationsIdModel : Codable {
    let bdo_name : String?
    let bdo_qualificationsid : String?
}




struct SJAQualificationTypeResponseModel: Codable {
    let value: [SJAQualificationTypeDataModel]?
}

struct SJAQualificationTypeDataModel : Codable {
    
    let value : String?
    let attributename : String?
    let versionnumber : Int?
    let langid : Int?
    let objecttypecode : String?
    let attributevalue : Int?
    let stringmapid : String?
    let organizationid : String?
    let displayorder : Int?
    
}
