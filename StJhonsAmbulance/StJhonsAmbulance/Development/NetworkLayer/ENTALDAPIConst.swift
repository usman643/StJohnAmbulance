//
//  ENTALDAPIConst.swift
//  ENTALDO
//
//  Created by M.Usman on 25/04/2022.
//

import Foundation

public typealias Parameters = [String: Any]



// API HEADER keys
let Content_Type = "application/json"
let Accept_Type = "application/json"
let Accept_Encoding = "gzip, deflate"

struct CCONSTANT {
    /// Encryption Params
    
    struct ENTALDEncryptionParams {
        static let HSS = "18b8c9ef473e2126c3c56ab0cb2b71cb"
        static let HSS_IV5 = "18b8c9ef473e2126"
        static let PROMO_HSS = "18b8c9ef473e2126c3c56ab0cb2b71cb"
        static let PROMO_HSS_IV5 = "18b8c9ef473e2126"
    }
}

/// Common API param keys
struct CommonAPIParamKeys
{
    static let deviceID = "__device_id"
    static let info = "__i"
    static let deviceLat = "__lat"
    static let deviceLng = "__lng"
    static let lat = "lat"
    static let lng = "lng"
    static let platform = "__platform"
    static let appVersion = "app_version"
    static let company = "company"
    static let currency  = "currency"
    static let deviceKey = "device_key"
    static let deviceModel = "device_model"
    static let deviceOS = "device_os"
    static let isPrivacyPolicyAccepted = "is_privacy_policy_accepted"
    static let isSocial = "is_social"
    static let isUserAgreementAccepted = "is_user_agreement_accepted"
    static let language = "language"
    static let osVersion = "os_version"
    static let sessionToken = "session_token"
    static let timeZone = "time_zone"
    static let userID = "user_id"
    static let locationID = "location_id"
}

struct API_CONSTANTS {
    
    struct END_POINTS {
        static let KConfigs = "configs"
        static let KCountries = "countries"
        static let KHome = "home"
    }
    
    
    struct PARAMS {
        static var COMMONPARAMS: [String : Any] {
  
            let params : [String : Any] =  [
                CommonAPIParamKeys.language : "en",
                CommonAPIParamKeys.locationID : "2"
            ]
   
            return params
        }
    }
}


