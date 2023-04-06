//
//  RequestModels.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 05/03/2023.
//

import Foundation


struct PostGroupMessageRequestModel : Codable {
    
    let subject : String
    let description : String
    let category : String
    let regardingobjectid:String
    
    enum CodingKeys: String, CodingKey {
        case subject
        case description
        case category
        case regardingobjectid = "regardingobjectid_msnfp_group@odata.bind"
    }
    
    
    func encodeModel()->[String:Any]?{
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(self)
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]{
                return json
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

struct PostAddAvailabilityRequestModel : Codable {
    
    let msnfp_availabilitytitle : String?
    let msnfp_effectivefrom : String?
    let msnfp_effectiveto : String?
    let msnfp_workingdays : String?
    let msnfp_contactIdBindData : String?
    
    enum CodingKeys: String, CodingKey {
        
        case msnfp_availabilitytitle
        case msnfp_effectivefrom
        case msnfp_effectiveto
        case msnfp_workingdays
        case msnfp_contactIdBindData = "msnfp_contactId@odata.bind"
        
        
    }
    func encodeModel()->[String:Any]?{
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(self)
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]{
                return json
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    
}
