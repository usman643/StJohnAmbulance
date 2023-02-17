//
//  VolunteerEventTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 07/02/2023.
//

import UIKit

class VolunteerEventTVC: UITableViewCell {
    
    
    @IBOutlet weak var seperatorView: UIView!
    
    @IBOutlet var allLabel: [UILabel]!
    
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblAction: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deocrateUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func deocrateUI(){
        for label in allLabel{
            label.font = UIFont.RegularFont(10)
            label.textColor = UIColor.textBlackColor
        }
    }
    
    func setContent(cellModel: VolunteerEventsModel?){
       
        self.lblEvent.text = cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
        self.lblLocation.text = cellModel?.sjavms_VolunteerEvent?.msnfp_location ?? ""
        self.lblAction.text = ProcessUtils.shared.getStatus(code: cellModel?.msnfp_schedulestatus ?? 0) 
        
        if (cellModel?.sjavms_start != "" && cellModel?.sjavms_start != nil ){
            let date = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblDate.text = date
            lblStart.text = startTime
        }else{
            lblDate.text = ""
            lblStart.text = ""
        }
        
        if (cellModel?.sjavms_end != "" && cellModel?.sjavms_end != nil ){
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            lblEnd.text = endTime
        }else{
            lblEnd.text = ""
        }
    }
    
    func setContent(cellModel: ScheduleModelThree?){
       
        self.lblEvent.text = cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
        self.lblLocation.text = cellModel?.sjavms_VolunteerEvent?.msnfp_location ?? ""
        self.lblAction.text = ProcessUtils.shared.getStatus(code: cellModel?.msnfp_schedulestatus ?? 0)
        
        if (cellModel?.sjavms_start != "" && cellModel?.sjavms_start != nil ){
            let date = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblDate.text = date
            lblStart.text = startTime
        }else{
            lblDate.text = ""
            lblStart.text = ""
        }
        
        if (cellModel?.sjavms_end != "" && cellModel?.sjavms_end != nil ){
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            lblEnd.text = endTime
        }else{
            lblEnd.text = ""
        }
    }
    
    func setContent(cellModel: AvailableEventModel?){
       
        self.lblEvent.text = cellModel?.msnfp_engagementopportunitytitle ?? ""
        self.lblLocation.text = cellModel?.msnfp_location ?? ""
        self.lblAction.text = ProcessUtils.shared.getStatus(code: cellModel?.msnfp_engagementopportunitystatus ?? 0)
        
        if (cellModel?.msnfp_startingdate != "" && cellModel?.msnfp_startingdate != nil ){
            let date = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblDate.text = date
            lblStart.text = startTime
        }else{
            lblDate.text = ""
            lblStart.text = ""
        }
        
        if (cellModel?.msnfp_endingdate != "" && cellModel?.msnfp_endingdate != nil ){
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            lblEnd.text = endTime
        }else{
            lblEnd.text = ""
        }
    }
    
    
}
