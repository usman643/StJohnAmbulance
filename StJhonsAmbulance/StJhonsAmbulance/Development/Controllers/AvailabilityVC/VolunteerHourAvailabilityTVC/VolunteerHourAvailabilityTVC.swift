//
//  VolunteerHourAvailabilityTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 15/02/2023.
//

import UIKit

class VolunteerHourAvailabilityTVC: UITableViewCell {

    
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblProgram: UILabel!
    @IBOutlet weak var lblSchedule: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var seperaterView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func decorateUI(){
        
        lblEvent.textColor = UIColor.textBlackColor
        lblEvent.font = UIFont.RegularFont(10)
        lblProgram.textColor = UIColor.textBlackColor
        lblProgram.font = UIFont.RegularFont(10)
        lblSchedule.textColor = UIColor.textBlackColor
        lblSchedule.font = UIFont.RegularFont(10)
        lblStart.textColor = UIColor.textBlackColor
        lblStart.font = UIFont.RegularFont(10)
        lblEnd.textColor = UIColor.textBlackColor
        lblEnd.font = UIFont.RegularFont(10)
        lblHours.textColor = UIColor.textBlackColor
        lblHours.font = UIFont.RegularFont(10)
        lblStatus.textColor = UIColor.textBlackColor
        lblStatus.font = UIFont.RegularFont(10)
        
    }
    
    func setContent(cellModel: SideMenuHoursModel?, programName: String?){
//        
        lblEvent.text = cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
        lblProgram.text = programName ?? ""
        lblSchedule.text = cellModel?.msnfp_engagementOpportunityScheduleId?.msnfp_shiftname ?? ""
        if let date = cellModel?.sjavms_start {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            lblStart.text = start
        }else{
            lblStart.text = ""
        }
        
        if let date = cellModel?.sjavms_end {
            let end = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            lblEnd.text = end
        }else{
            lblEnd.text = ""
        }
        
        lblHours.text = cellModel?.sjavms_hours?.getFormattedNumber()
        
        if let status = cellModel?.msnfp_schedulestatus {
            lblStatus.text = ProcessUtils.shared.getStatus(code: status)
        }else{
            lblStatus.text = ""
        }
        
//        
//        
//        
    }
    
    
}
