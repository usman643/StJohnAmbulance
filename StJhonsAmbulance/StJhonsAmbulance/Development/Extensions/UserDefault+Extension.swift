//
//  UserDefault+Extension.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/22/23.
//

import Foundation

fileprivate let keyAuthToken = "key_auth_token"
fileprivate let contactId = "key_contact_id"
fileprivate let keyUserIdentity = "key_user_identity"

extension UserDefaults {
    
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
}
