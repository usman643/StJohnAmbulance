//
//  Router.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/21/23.
//
import Foundation

protocol Router {
    var urlType: ENTALDBASEURLTYPE { get }
    var procedure: String { get } //endpoints
    var params: Parameters { get }
    var method : String { get }
    var version: String { get }
    var encoding:ENTALDEncodingType { get }
}
