//
//  ScheduleTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 07/02/2023.
//

import UIKit

class ScheduleTVC: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func decorateUI(){
        lblTitle.font = UIFont.BoldFont(16)
        lblSubTitle.font = UIFont.RegularFont(14)
        lblTime.font = UIFont.RegularFont(14)
        lblDate.font = UIFont.RegularFont(14)
        
        lblTitle.textColor = UIColor.themePrimaryColor
        lblSubTitle.textColor = UIColor.themeColorSecondry
        lblTime.textColor = UIColor.themeColorSecondry
        lblDate.textColor = UIColor.themeColorSecondry
        
    }
    
    
    func setContent(cellModel : ScheduleModelThree?){
        
        lblTitle.text = cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
        lblSubTitle.text = cellModel?.sjavms_VolunteerEvent?.msnfp_location ?? "locations"
        
        
        if (cellModel?.sjavms_start != "" && cellModel?.sjavms_start != nil ){
            let date = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblTime.text = date
            lblDate.text = startTime
        }else{
            lblTime.text = ""
            lblDate.text = ""
        }
        
    }
}
