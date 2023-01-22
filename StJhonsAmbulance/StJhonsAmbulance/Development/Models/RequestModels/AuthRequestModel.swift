//
//  AuthRequestModel.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/22/23.
//

import Foundation

struct PortalAuthRequest : Codable {
    let username : String?
    let password: String?
    let grant_type : String?
    let scope : String?
    let client_id : String?
    let response_type : String?
    
    init(username: String?, password: String?, grant_type: String?, scope: String?, client_id: String?, response_type: String?) {
        self.username = username
        self.password = password
        self.grant_type = grant_type
        self.scope = scope
        self.client_id = client_id
        self.response_type = response_type
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
