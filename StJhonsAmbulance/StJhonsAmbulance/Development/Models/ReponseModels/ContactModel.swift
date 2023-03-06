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
    let fullname : String?
    let address1_postalcode : String?
    let telephone1 : String?
    let address1_stateorprovince : String?
    let address1_line2 : String?
    let contactid : String?
    let sjavms_workingwvulnerablepeople : Bool?
    let sjavms_patientcare : Bool?
    let sjavms_palliativecare : Bool?
    let sjavms_cprorfirstaid : Bool?
    let sjavms_recreationalprogramming : Bool?
    let sjavms_customerservice : Bool?
    let sjavms_educationalprogramming : Bool?
    let sjavms_computer : Bool?
    let sjavms_volunteerleadership : Bool?
    let sjavms_otherskills : Bool?
    let sjavms_explainskillother : String?
    
}
