//
//  AuthResponseModel.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/22/23.
//

import Foundation

struct PortalAuthModel : Codable {
    let access_token: String?
    let token_type:String?
    let expires_in:String?
    let refresh_token:String?
    let id_token:String?
}
