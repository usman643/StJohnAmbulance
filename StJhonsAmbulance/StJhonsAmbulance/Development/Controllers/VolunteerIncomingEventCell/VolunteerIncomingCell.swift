//
//  VolunteerIncomingCell.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 04/07/2023.
//

import UIKit

class VolunteerIncomingCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var lblDateTime: UILabel!

    @IBOutlet weak var btnDetail: UIButton!
    @IBOutlet weak var btnCheckIn: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblProgram: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var seperatorView: UIView!
    
    @IBOutlet weak var lblCheckIn: UILabel!
    @IBOutlet weak var checkinView: UIView!
    
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
        statusView.backgroundColor = UIColor.headerTitleColor
        checkinView.backgroundColor = UIColor.headerTitleColor
        checkinView.layer.cornerRadius = 8
        checkinView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        
        lblDateTime.textColor = UIColor.themePrimaryWhite
        btnDetail.setTitleColor(UIColor.white, for: .normal)
        btnCheckIn.setTitleColor(UIColor.white, for: .normal)
        lblCheckIn.textColor = UIColor.white
        lblTitle.textColor = UIColor.headerGreenWhite
        lblProgram.textColor = UIColor.themePrimaryWhite
        
        lblLocation.textColor = UIColor.themePrimaryWhite
        
        lblDateTime.font =  UIFont.BoldFont(13)
        btnDetail.titleLabel?.font = UIFont.BoldFont(13)
        btnCheckIn.titleLabel?.font = UIFont.HeavyFont(9)
        lblCheckIn.font = UIFont.HeavyFont(9)
        lblTitle.font =  UIFont.HeaderBlackFont(16)
        lblProgram.font =  UIFont.BoldFont(13)
        
        lblLocation.font =  UIFont.BoldFont(13)
        
        
        
    }
    
    func setupContent(cellModel: AvailableEventModel?){
        
        
//        self.gridData?[index].title = self.latestEventData?[0].sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle
       //                            if (self.latestEventData?[0].sjavms_start != nil && self.latestEventData?[0].sjavms_start != ""){
       //                                let startData = DateFormatManager.shared.formatDateStrToStr(date: self.latestEventData?[0].sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
       //                                self.gridData?[index].subTitle = startData
        
        
        let startTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEE, MMM d, hh:mm a")
        
        let endTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")

        lblDateTime.text = "\(startTime) - \(endTime)"
        
        lblTitle.text = "\(cellModel?.msnfp_engagementopportunitytitle ?? "")"
        
        lblLocation.text = "\(cellModel?.msnfp_location ?? "Not Found") "
        
//        lblProgram.text = cellModel?.sjavms_msnfp_engagementopportunity_msnfp_group?[0].sjaProgram ?? "..."
        lblProgram.text = cellModel?.sjavms_program_value ?? "..."
        
        let eventDate = DateFormatManager.shared.getDateFromString(date: cellModel?.msnfp_startingdate) ?? Date()
        let currentDate = DateFormatManager.shared.getCurrentDate()
        let calendar = Calendar.current

        let components = calendar.dateComponents([.minute, .second], from: currentDate, to: eventDate)
        if ((components.minute ?? 31) <= 30 && (components.minute ?? 31) >= -30){
//                    cell.btnCheckIn.isEnabled = true
            self.checkinView.isHidden = false
            self.statusView.isHidden = true
        }else{
//                    cell.btnCheckIn.isEnabled = false
            self.checkinView.isHidden = true
            self.statusView.isHidden = false
        }

    }
    
}
