//
//  ENTALDAPIConst.swift
//  ENTALDO
//
//  Created by M.Usman on 25/04/2022.
//

import Foundation

public typealias Parameters = [String: Any]



// API HEADER keys
let Content_Type = "multipart/form-data"
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
struct ParameterKeys
{
    static let email = "email"
    static let password = "password"
}



