//
//  PendingShiftResponseModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 31/01/2023.
//

import Foundation

struct PendingShiftResponseModel : Codable {
    let context: String?
    let value: [PendingShiftModel]?
    
    enum CodingKeys: String, CodingKey {
        case context = "@odata.context"
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.value = try container.decodeIfPresent([PendingShiftModel].self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct PendingShiftModel : Codable {
    
    let odataEtag : String?
//    let msnfp_name : String?
    let createdon : String?
    let msnfp_participationscheduleid : String?
    let msnfp_schedulestatus : Int?
    let sjavms_start : String?
    let sjavms_hours : Float?
    let _sjavms_volunteerevent_value : String?
    let _sjavms_volunteer_value : String?
    let sjavms_Volunteer : PendingShiftVolunteerModel?

    enum CodingKeys: String, CodingKey {
        
            case odataEtag = "@odata.etag"
//            case msnfp_name
            case createdon
            case msnfp_participationscheduleid
            case msnfp_schedulestatus
            case sjavms_start
            case sjavms_hours
            case _sjavms_volunteerevent_value
            case _sjavms_volunteer_value
            case sjavms_Volunteer
        }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.odataEtag = try container.decodeIfPresent(String.self, forKey: .odataEtag)
//        self.msnfp_name = try container.decodeIfPresent(String.self, forKey: .msnfp_name)
        self.createdon = try container.decodeIfPresent(String.self, forKey: .createdon)
        self.msnfp_participationscheduleid = try container.decodeIfPresent(String.self, forKey: .msnfp_participationscheduleid)
        self.msnfp_schedulestatus = try container.decodeIfPresent(Int.self, forKey: .msnfp_schedulestatus)
        self.sjavms_start = try container.decodeIfPresent(String.self, forKey: .sjavms_start)
        self.sjavms_hours = try container.decodeIfPresent(Float.self, forKey: .sjavms_hours)
        self._sjavms_volunteerevent_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_volunteerevent_value)
        self._sjavms_volunteer_value = try container.decodeIfPresent(String.self, forKey: ._sjavms_volunteer_value)
        self.sjavms_Volunteer = try container.decodeIfPresent(PendingShiftVolunteerModel.self, forKey: .sjavms_Volunteer)
        
    }
}


struct PendingShiftVolunteerModel : Codable {
    let fullname : String?
    let contactid : String?

}
