//
//  DocumentResponseModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 18/04/2023.
//

import Foundation

struct  ContactDocumentResponseModel: Codable{
    let value : [ContactDocumentModel]?
    
}

struct ContactDocumentModel : Codable {
    
    let relativeurl : String?
    let sharepointdocumentlocationid : String?
    
    
}



struct contactDocumentResponseModelTwo : Codable {
    
    let d : ContactDocumentResultModel?
    
}

struct ContactDocumentResultModel : Codable {
    
    let results : [ContactDocumentResults]?
    
}
struct ContactDocumentResults : Codable {
    
    let CheckInComment : String?
    let CheckOutType : Int?
    let ContentTag : String?
    let CustomizedPageStatus : Int?
    let ETag : String?
    let Exists : Bool?
    let IrmEnabled : Bool?
    let Length : String?
    let Level : Int?
    let LinkingUri : String?
    let MajorVersion : Int?
    let MinorVersion : Int?
    let Name : String?
    let ServerRelativeUrl : String?
    let TimeCreated : String?
    let TimeLastModified : String?
    let Title : String?
    let UIVersion : Int?
    let UIVersionLabel : String?
    let UniqueId : String?
}

              
