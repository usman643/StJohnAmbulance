//
//  AdhocHourTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 15/02/2023.
//

import UIKit

class AdhocHourTVC: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblProgram: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func decorateUI(){
        lblTitle.textColor = UIColor.textBlackColor
        lblTitle.font = UIFont.BoldFont(12)
        lblProgram.textColor = UIColor.textBlackColor
        lblProgram.font = UIFont.BoldFont(12)
        lblHours.textColor = UIColor.textBlackColor
        lblHours.font = UIFont.BoldFont(12)
        lblStatus.textColor = UIColor.textBlackColor
        lblStatus.font = UIFont.BoldFont(12)
        
        
    }
    
    func setContent(cellModel: SideMenuHoursModel?, programName: String?){


        lblTitle.text = cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
        lblProgram.text = programName ?? ""

        lblHours.text = cellModel?.sjavms_hours?.getFormattedNumber()
        if let status = cellModel?.msnfp_schedulestatus {
            lblStatus.text = ProcessUtils.shared.getStatus(code: status)
        }else{
            lblTitle.text = ""
        }
    }
    
}
