//
//  VolunterEventTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 22/06/2023.
//

import UIKit

class VolunterEventTVC: UITableViewCell {
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTotalHours: UILabel!
    
    @IBOutlet weak var statusImage: UIImageView!
    
    @IBOutlet weak var seperatorView: UIView!
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
        statusView.layer.cornerRadius = 8
        statusView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        statusView.backgroundColor = UIColor.headerGreen
        
        lblDateTime.textColor = UIColor.textDarkGreenWhite
        lblStatus.textColor = UIColor.textDarkGreenWhite
        lblTitle.textColor = UIColor.headerGreenWhite
        lblTotalHours.textColor = UIColor.textDarkGreenWhite
        
        lblDateTime.font =  UIFont.BoldFont(13)
        lblStatus.font =  UIFont.BoldFont(13)
        lblTitle.font =  UIFont.HeaderBlackFont(16)
        lblTotalHours.font =  UIFont.BoldFont(13)
        
    }
    
    func setupContent(cellModel: PendingShiftModelTwo?){
        
        let date = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
        let startTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEE, MMM d, hh:mm a")
        let endTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'(Z'", newFormat: "hh:mm a")
        lblDateTime.text = "\(startTime) - \(endTime)"
        lblStatus.text = ProcessUtils.shared.getStatus(code: cellModel?.msnfp_schedulestatus ?? 0)
        lblTitle.text = "\(cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "")"
        lblTotalHours.text = "\(cellModel?.sjavms_hours?.getFormattedNumber() ?? "") Hours"
        
        if (lblStatus.text == "Pending"){
            statusImage.image = UIImage(named: "hourglass Pending Yellow")
        }else if (lblStatus.text == "Cancelled"){
            statusImage.image = UIImage(named: "Cancelled Status")
        }else if (lblStatus.text == "No Show"){
            statusImage.image = UIImage(named: "eyeClose")
        }else if (lblStatus.text == "Approved"){
            statusImage.image = UIImage(named: "check-double Green")
        }else{
            statusImage.isHidden = true
        }
        
        
        
        
        
    }
    
    
    
    
}
