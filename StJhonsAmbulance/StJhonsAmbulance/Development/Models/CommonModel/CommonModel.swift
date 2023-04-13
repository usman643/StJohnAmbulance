//
//  CommonModel.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 24/01/2023.
//

import Foundation
import UIKit

struct DashBoardGridModel {
    
    var title : String?
    var subTitle : String?
    var bgColor : UIColor?
    var icon : String?
    var key : String?
    var order : Int?
}

struct DashBoardGridOrderResponseModel : Codable{
    let value : [DashBoardGridOrderModel]?
}

struct DashBoardGridOrderModel : Codable{
    
    let statecode : Int?
    let sjavms_messages : Int?
    let sjavms_events : Int?
    let sjavms_checkin : Int?
    let sjavms_hours : Int?
    let sjavms_name : Int?
    let sjavms_myschedule : Int?
    let sjavms_dayofevent : Int?
    let sjavms_pendingevents : Int?
    let sjavms_csgrouplead : Bool?
    let _sjavms_user_value : String?
    let sjavms_volunteers : Int?
    let sjavms_youthcamp : Int?
    let sjavms_pendingshifts : Int?
    let sjavms_dashboard_orderid : String?
    
    
    func encodeModel()->[String:Any]?{
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(self)
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]{
                return json
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

