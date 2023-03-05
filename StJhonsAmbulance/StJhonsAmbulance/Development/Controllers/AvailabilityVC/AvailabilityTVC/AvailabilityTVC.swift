//
//  AvailabilityTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 15/02/2023.
//

import UIKit

class AvailabilityTVC: UITableViewCell {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblEffectiveFrom: UILabel!
    @IBOutlet weak var lblEffectiveto: UILabel!
    @IBOutlet weak var lblWorkingDays: UILabel!
    @IBOutlet weak var seperaterView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        deocrateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func deocrateUI(){
        lblTitle.textColor = UIColor.textBlackColor
        lblTitle.font = UIFont.RegularFont(12)
        lblEffectiveFrom.textColor = UIColor.textBlackColor
        lblEffectiveFrom.font = UIFont.RegularFont(12)
        lblEffectiveto.textColor = UIColor.textBlackColor
        lblEffectiveto.font = UIFont.RegularFont(12)
        lblWorkingDays.textColor = UIColor.textBlackColor
        lblWorkingDays.font = UIFont.RegularFont(12)
        
        
    }
    
    func setContent(cellModel: AvailablityHourModel?){
        
        lblTitle.text = cellModel?.msnfp_availabilitytitle
        
        if let date = cellModel?.msnfp_effectivefrom {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            lblEffectiveFrom.text = start
        }else{
            lblEffectiveFrom.text = ""
        }
        
        if let date = cellModel?.msnfp_effectiveto {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            lblEffectiveto.text = start
        }else{
            lblEffectiveto.text = ""
        }
        var dayStr = ""
        if let days = cellModel?.msnfp_workingdays?.components(separatedBy: ","){
            
            for singleDay in days {
                var intDay = Int(singleDay) ?? 0
                let dayEng = ProcessUtils.shared.getDay(code: intDay as Int) ?? ""
                if singleDay == days.last {
                    dayStr += "\(dayEng)"
                }else{
                    dayStr += "\(dayEng),"
                }
            }
        }
        lblWorkingDays.text = dayStr
       
    }
    
}
