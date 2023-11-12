//
//  UserDefault+Extension.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/22/23.
//

import Foundation
import UIKit

fileprivate let keyAuthToken = "key_auth_token"
fileprivate let contactId = "key_contact_id"
fileprivate let keyUserIdentity = "key_user_identity"
fileprivate let keyDarkMode = "key_dark_mode"
fileprivate let tokenTime = "tokenTime"
fileprivate let keyStaySignedIn = "key_stay_signed_in"
fileprivate let keyTokenExpireTime = "key_token_expire_time"

extension UserDefaults {
    
    var isDarkMode: Bool {
        get {
            return bool(forKey: keyDarkMode)
        }
        set {
            set(newValue, forKey: keyDarkMode)
        }
    }
    
    var isSystemPrefernceTheme: Bool {
        get {
            return bool(forKey: keyDarkMode)
        }
        set {
            set(newValue, forKey: keyDarkMode)
        }
    }
    
    var authToken: String? {
        get {
            return string(forKey: keyAuthToken)
        }
        set {
            set(newValue, forKey: keyAuthToken)
        }
    }
    
    
    var contactIdToken: String? {
        get {
            return string(forKey: contactId)
        }
        set {
            set(newValue, forKey: contactId)
        }
    }
    
    var userInfo : UserIdentityModel? {
        get{
            do {
                if let object = object(forKey: keyUserIdentity) as? Data{
                    let status = try JSONDecoder().decode(UserIdentityModel.self, from: object)
                    return status
                }
            } catch { print(error) }
            return nil
        }
        
        set{
            if let newValue = newValue{
                do {
                    let encodeData = try JSONEncoder().encode(newValue)
                    set(encodeData, forKey: keyUserIdentity)
                    // synchronize is not needed
                } catch { print(error) }
            }else{
                removeObject(forKey: keyUserIdentity)
            }
            
        }
    }
    
    var staySignedIn: Bool {
        get {
            return bool(forKey: keyStaySignedIn)
        }
        set {
            set(newValue, forKey: keyStaySignedIn)
        }
    }
    
    var tokenExpireTime: String? {
        get {
            return string(forKey: keyTokenExpireTime)
        }
        set {
            set(newValue, forKey: keyTokenExpireTime)
        }
    }
    
    func signOut(){
        removeObject(forKey: keyAuthToken)
        removeObject(forKey: contactId)
        removeObject(forKey: keyUserIdentity)
        removeObject(forKey: keyStaySignedIn)
        removeObject(forKey: keyTokenExpireTime)
        ENTALDAppConfig.shared.showAppLaunch()
    }
}
