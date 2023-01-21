//
//  ENTALDCountriesModel.swift
//  Aldar-Entertainer
//
//  Created by M.Usman on 12/05/2022.
//

import Foundation

struct ENTALDCountryModel : Codable {
    var short_name : String?
    var name : String?
    var msisdn_cc : String?
    var show_msisdn_cc : Int?
    var show_cities : Int?
    var cities : [ENTALDCityModel]?
}

struct ENTALDCityModel : Codable {
    var name : String?
    var city_id : Int?
}
