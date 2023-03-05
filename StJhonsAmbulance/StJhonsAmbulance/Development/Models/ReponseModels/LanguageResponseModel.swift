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
    let objecttypecode : String?
    let attributevalue : Int?
    let stringmapid : String?
    let organizationid : String?
    let displayorder : Int?
    
    
    
}






