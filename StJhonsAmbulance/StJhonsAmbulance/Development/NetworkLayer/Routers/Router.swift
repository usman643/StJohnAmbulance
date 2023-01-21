//
//  Router.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/21/23.
//

import Foundation

enum HTTPMethodType : String {
    case post = "POST"
    case get = "GET"
}

protocol Router {
    var urlType: ENTALDBASEURLTYPE { get }
    var procedure: String { get } //endpoints
    var params: Parameters { get }
    var method : String { get }
    var version: String { get }
    var encoding:ENTALDEncodingType { get }
}
