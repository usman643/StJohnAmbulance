//
//  LanguageResponseModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 01/03/2023.
//

import Foundation

struct LanguageResponseModel: Codable {
    let value: [LanguageModel]?
}

struct LanguageModel : Codable{
    
    let value : String?
    let attributename : String?
    let versionnumber : Int?
    let langid : Int?
//    let objecttypecode : String?
    let attributevalue : Int?
    let stringmapid : String?
    let organizationid : String?
    let displayorder : Int?

}

struct PrefferedLanguageResponseModel: Codable {
    let value: [PrefferedLanguageModel]?
}

struct PrefferedLanguageModel : Codable{
    
    let adx_portallanguageid : String?
    let adx_name : String?
    let createdon : String?
    let adx_adx_portallanguage_adx_websitelanguage : [PortalLanguageModel]?
    
}

struct PortalLanguageModel : Codable {
    
    let modifiedon : String?
    let _owninguser_value : String?
    let _adx_websiteid_value : String?
    let _adx_publishingstate_value : String?
    let adx_websitelanguageid : String?
    let _adx_portallanguageid_value : String?
    let statecode : Int?
    let versionnumber : Int?
    let _modifiedby_value : String?
    let createdon : String?
    let _owningbusinessunit_value : String?
    let statuscode : Int?
    let _createdby_value : String?
    let _ownerid_value : String?
    let adx_name : String?
    
}
