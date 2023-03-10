//
//  GenderResponseModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 09/03/2023.
//

import Foundation

struct GenderResponseModel: Codable {
    let value: [GenderModel]?
}

struct GenderModel : Codable{
    
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

