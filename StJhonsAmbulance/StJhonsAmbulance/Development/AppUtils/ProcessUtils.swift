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
    var programsData : [ProgramModel]?
    var contactInfo : UserIdentityModel?
    var days =  [844060000 : "Monday",844060001 : "Tuesday",844060002 : "Wednesday",844060003 : "Thursday",844060004 : "Friday",844060005 : "Saturday",844060006 : "Sunday"]
    var eventStatusArr = [
        844060000 : "Draft",
        844060002 : "Publish to Web",
        844060003 : "Privately Published",
        844060004 : "Closed",
        844060005 : "Cancelled"
    ]
    
    var genderData : [LanguageModel]?
    var prefferedPronounData : [LanguageModel]?
    var prefferedMethodContactData : [LanguageModel]?
    var prefferedLanguageData : [PrefferedLanguageModel]?
    var eventStatus : [ProgramStatusModel]?
    var optOutNotification = [0 : "No",
                              1 : "Yes"]
    
    var tabbarHeight : CGFloat?
    var groupListValue : String?
    var currentRole : String?
    var registerURL = "https://sjavolunteers.powerappsportals.com/en-US/volunteer-application/"
    var forgetURL = "https://sjavolunteers.powerappsportals.com/en-US/SignIn?returnUrl=/en-US/volunteer-application/"
    var changePassURL = "https://sjasandbox.b2clogin.com/sjasandbox.onmicrosoft.com/oauth2/v2.0/authorize?p=B2C_1_VolunteerEngagementpasswordreset_1&client_id=86d0acb3-3740-41ef-b0e2-cf2e9f77fdb7&nonce=defaultNonce&redirect_uri=https%3A%2F%2Foauth.pstmn.io%2Fv1%2Fcallback&scope=openid&response_type=id_token&prompt=login"
    
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
    
    func getLocationType(code:Int)->String?{
        
        switch code {
        case 844060000:
            return "On Location"
        case 844060001:
            return "Virtual"
        case 844060002:
            return "Both"
        case 844060003:
            return "None"
    
        default:
            return ""
        }
    }
    
    func getParticipantsStatus(code:Int)->String?{
        
        switch code {
        case 844060000:
            return "Needs Review"
        case 844060001:
            return "In Review"
        case 844060002:
            return "Approved"
        case 844060003:
            return "Dismissed"
        case 844060004:
            return "Cancelled"
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
    
    
    func getPendingShiftStatus () -> [ Int]{
        let dataArr = [335940001, 335940002,335940003]
        return dataArr
    }
    
//    func getEventSummaryStatusArray () -> [ProgramStatusModel]?{
//
//        var EventStatusArr = [
//            844060000 : "Draft",
//            844060002 : "Publish to Web",
//            844060003 : "Privately Published",
//            844060004 : "Closed",
//            844060005 : "Cancelled"
//        ]
//
//        for prm in EventStatusArr {
//            var program :ProgramStatusModel
//
//            program.status_id = prm.key
//            program.status_value = prm.value
//            eventStatus?.append(program )
//        }
//        return eventStatus
//    }
}

