//
//  ContactModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 15/02/2023.
//

import Foundation

struct ContactResponseModel: Codable {
    let value: [ContactDataModel]?
}

struct ContactDataModel : Codable{
    
    let msnfp_engagementopportunitytitle : String?
    let msnfp_engagementopportunityid : String?
    let sjavms_Contact : ContactModel?
}

struct ContactModel : Codable{
   
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
    let contactid : String?
    
}
