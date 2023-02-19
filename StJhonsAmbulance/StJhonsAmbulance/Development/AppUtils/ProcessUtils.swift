//
//  ProcessUtils.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/25/23.
//

import Foundation
import UIKit

class ProcessUtils {
    
    static let shared : ProcessUtils = ProcessUtils()
    
    private init() {
        
    }
    
    var userGroupsList : [LandingGroupsModel] = []
    var selectedUserGroup : LandingGroupsModel?
    var tabbarHeight : CGFloat?
    var groupListValue : String?
    var currentRole : String?
    var registerURL = "https://sjavolunteers.powerappsportals.com/en-US/volunteer-application/"
    var forgetURL = "https://sjavolunteers.powerappsportals.com/en-US/SignIn?returnUrl=/en-US/volunteer-application/"
    
    func getStatus(code:Int)->String?{
        switch code {
        case 335940000:
            return "Pending"
        case 335940001:
            return "Shift Hours Approved"
        case 335940002:
            return "No Show"
        case 335940003:
            return "Cancelled"
        case 844060000:
            return "Unpublished"
        case 802280002:
            return "Submitted"
        case 1:
            return "Active"
        case 0:
            return "Draft"
        case 8:
            return "Failed"
        case 2:
            return "Completed"
        case 3:
            return "Sent"
        case 4:
            return "Received"
        case 6:
            return "Pending Send"
        case 7:
            return "Sending"
        case 5:
            return "Canceled"
        default:
            return ""
        }
    }
    
    func getDay(code:Int)->String?{
        
        switch code {
        case 844060000:
            return "Monday"
        case 844060001:
            return "Tuesday"
        case 844060002:
            return "Wednesday"
        case 844060003:
            return "Thursday"
        case 844060004:
            return "Friday"
        case 844060005:
            return "Saturday"
        case 844060006:
            return "Sunday"
        default:
            return ""
        }
    }
    
    func getRoleType(code:Int)->String?{
        
        switch code {
        case 802280000:
            return "Volunteer"
        case 802280001:
            return "Cs Lead Group"
        default:
            return nil
        }
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
    
    
}
