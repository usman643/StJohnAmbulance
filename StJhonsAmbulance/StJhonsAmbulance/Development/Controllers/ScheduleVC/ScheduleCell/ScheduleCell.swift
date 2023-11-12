//
//  ScheduleCell.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 04/07/2023.
//

import UIKit

class ScheduleCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var locationImg: UIImageView!
    
    @IBOutlet weak var btnMainView: UIView!
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var lblLocation: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func decorateUI(){
        
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.systemGray5.cgColor
        mainView.layer.shadowColor = UIColor.systemGray2.cgColor
        mainView.layer.shadowOpacity = 0.4
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 8
        
        mainView.layer.cornerRadius = 8
        btnMainView.layer.cornerRadius = 8
        btnMainView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        btnMainView.backgroundColor = UIColor.headerGreen
        
        lblDate.textColor = UIColor.textDarkGreenWhite
        lblLocation.textColor = UIColor.textDarkGreenWhite
        
        
        lblTitle.textColor = UIColor.headerGreenWhite
        lblSubTitle.textColor = UIColor.textDarkGreenWhite
        
        lblDate.font =  UIFont.BoldFont(13)
        lblLocation.font =  UIFont.BoldFont(13)
        
        lblTitle.font =  UIFont.HeaderBlackFont(16)
        lblSubTitle.font =  UIFont.BoldFont(13)
        
        locationImg.image = locationImg.image?.withRenderingMode(.alwaysTemplate)
        
        locationImg.tintColor = UIColor.themeBlackText
        btnView.setTitleColor(UIColor.themeBlackText, for: .normal)
        btnView.titleLabel?.font = UIFont.BoldFont(12)
        
    }
    
    
    func setContent(cellModel : ScheduleModelThree?){
    
        lblTitle.text = "\(cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "")"
        if let programValue = cellModel?.sjavms_VolunteerEvent?.program{
            lblSubTitle.text = "\(programValue)"
        }else{
            lblSubTitle.text = ""
        }
        
//        ProcessUtils.shared.eventStatusArr[cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitystatus?.msnfp_engagementopportunitystatus ?? ""]
        lblLocation.text = "\(cellModel?.sjavms_VolunteerEvent?.msnfp_location ?? "Not Found") "
        if (cellModel?.sjavms_start != "" && cellModel?.sjavms_start != nil ){
            
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEE, MMM d, hh:mm a")
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
                        lblDate.text = "\(startTime) - \(endTime)"
                        
                    }else{
                        lblDate.text = "Not Found"
                        
                    }
    }
    
}
