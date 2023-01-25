//
//  ProcessUtils.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/25/23.
//

import Foundation

class ProcessUtils {
    
    static let shared : ProcessUtils = ProcessUtils()
    
    private init() {
        
    }
    
    var userGroupsList : [LandingGroupsModel] = []
    var selectedUserGroup : LandingGroupsModel?
    
}
