//
//  ShiftOptionTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 19/03/2023.
//

import UIKit

class ShiftOptionTVC: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblShift: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblNeeded: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var seperatorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.decorateUI()
    }
    
    func decorateUI(){
        lblShift.textColor = UIColor.textBlackColor
        lblStart.textColor = UIColor.textBlackColor
        lblEnd.textColor = UIColor.textBlackColor
        lblHours.textColor = UIColor.textBlackColor
        lblNeeded.textColor = UIColor.textBlackColor
        lblStatus.textColor = UIColor.textBlackColor
        
        lblShift.font = UIFont.RegularFont(11)
        lblStart.font = UIFont.RegularFont(11)
        lblEnd.font = UIFont.RegularFont(11)
        lblHours.font = UIFont.RegularFont(11)
        lblNeeded.font = UIFont.RegularFont(11)
        lblStatus.font = UIFont.RegularFont(11)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setContent(cellModel: VolunteerEventClickOptionModel?){
        
        
        
        lblShift.text = cellModel?.msnfp_engagementopportunityschedule ?? ""
        lblHours.text = "\(cellModel?.msnfp_hours ?? Float())"
        lblNeeded.text = "\(cellModel?.msnfp_maximum ?? NSNotFound)"
        lblStatus.text = "\(cellModel?.statecode ?? NSNotFound)"

        if let date = cellModel?.msnfp_effectivefrom {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            lblStart.text = start
        }else{
            lblStart.text = ""
        }
        
        if let date = cellModel?.msnfp_effectiveto {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            lblEnd.text = start
        }else{
            lblEnd.text = ""
        }
    }
    
}
