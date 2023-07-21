//
//  AdhocHourCell.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 21/07/2023.
//

import UIKit

class AdhocHourCell: UITableViewCell {
    
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblProgram: UILabel!
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
        mainView.layer.borderColor = UIColor.systemGray3.cgColor
        mainView.layer.shadowColor = UIColor.systemGray4.cgColor
        mainView.layer.shadowOpacity = 0.5
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 6
        
        mainView.layer.cornerRadius = 16
        statusView.layer.cornerRadius = 16
        statusView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]

        btnView.setTitleColor(UIColor.textWhiteColor, for: .normal)
        
        btnView.titleLabel?.font = UIFont.BoldFont(13)
        
        lblEvent.textColor = UIColor.themeSecondryWhite
        lblEvent.font = UIFont.RegularFont(13)
        lblProgram.textColor = UIColor.themeSecondryWhite
        lblProgram.font = UIFont.RegularFont(13)

        lblHours.textColor = UIColor.themeSecondryWhite
        lblHours.font = UIFont.RegularFont(13)
        
    }
    
    func setContent(cellModel: SideMenuHoursModel?, programName: String?){

        lblEvent.text = cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
        lblProgram.text = programName ?? ""

        lblHours.text = cellModel?.sjavms_hours?.getFormattedNumber()
        
        
        if let status = cellModel?.msnfp_schedulestatus {
            btnView.setTitle(ProcessUtils.shared.getStatus(code: status), for: .normal)
            
        }else{
            btnView.setTitle((""), for: .normal)
        }
    }
    
}
