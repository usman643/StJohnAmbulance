//
//  VolunteerHourCell.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 21/07/2023.
//

import UIKit

class VolunteerHourCell: UITableViewCell {
    
    
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblProgram: UILabel!
    @IBOutlet weak var lblSchedule: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var btnView: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func decorateUI(){
        
        
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.systemGray5.cgColor
        mainView.layer.shadowColor = UIColor.systemGray2.cgColor
        mainView.layer.shadowOpacity = 0.4
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 8
        
        mainView.layer.cornerRadius = 16
        statusView.layer.cornerRadius = 16
        statusView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        
        lblDateTime.textColor = UIColor.themeSecondryWhite

        btnView.setTitleColor(UIColor.textWhiteColor, for: .normal)
        
        lblDateTime.font =  UIFont.MediumFont(11)
        btnView.titleLabel?.font = UIFont.BoldFont(13)
        
        lblEvent.textColor = UIColor.themeSecondryWhite
        lblEvent.font = UIFont.BoldFont(13)
        lblProgram.textColor = UIColor.themeSecondryWhite
        lblProgram.font = UIFont.BoldFont(13)
        lblSchedule.textColor = UIColor.themeSecondryWhite
        lblSchedule.font = UIFont.BoldFont(13)
        lblHours.textColor = UIColor.themeSecondryWhite
        lblHours.font = UIFont.BoldFont(13)
        
    }
    
    func setContent(cellModel: SideMenuHoursModel?, programName: String?){
        
        var startTime : String?
        var endTime : String?
//
        lblEvent.text = cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
        lblProgram.text = programName ?? ""
        lblSchedule.text = cellModel?.msnfp_engagementOpportunityScheduleId?.msnfp_shiftname ?? ""
        if let date = cellModel?.sjavms_start {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEE, MMM d, hh:mm a")
            startTime = start
        }else{
            startTime = ""
        }
        
        if let date = cellModel?.sjavms_end {
            let end = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            endTime = end
        }else{
            endTime = ""
        }
        
        lblDateTime.text = "\(startTime ?? "") - \(endTime ?? "")"
        
        lblHours.text = cellModel?.sjavms_hours?.getFormattedNumber()
        
        if let status = cellModel?.msnfp_schedulestatus {
            btnView .setTitle(ProcessUtils.shared.getStatus(code: status), for: .normal)
        }else{
            btnView .setTitle("", for: .normal)
        }
        
//
//
//
    }
    
    
}
