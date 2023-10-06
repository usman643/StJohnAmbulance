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

    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTotalHours: UILabel!
    
    
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
        mainView.layer.borderColor = UIColor.systemGray3.cgColor
        mainView.layer.shadowColor = UIColor.systemGray4.cgColor
        mainView.layer.shadowOpacity = 0.5
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 6
        
        mainView.layer.cornerRadius = 16
        statusView.layer.cornerRadius = 16
        statusView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        
        lblDateTime.textColor = UIColor.themeSecondryWhite

        btnView.setTitleColor(UIColor.textWhiteColor, for: .normal)
        lblTitle.textColor = UIColor.themeSecondryWhite
        lblTotalHours.textColor = UIColor.themeSecondryWhite
        
        lblDateTime.font =  UIFont.MediumFont(11)
        btnView.titleLabel?.font = UIFont.BoldFont(13)
        lblTitle.font =  UIFont.BoldFont(14)
        lblTotalHours.font =  UIFont.BoldFont(13)
        
    }
    
    func setupContent(cellModel: LatestEventDataModel?){
        
        
//        self.gridData?[index].title = self.latestEventData?[0].sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle
       //                            if (self.latestEventData?[0].sjavms_start != nil && self.latestEventData?[0].sjavms_start != ""){
       //                                let startData = DateFormatManager.shared.formatDateStrToStr(date: self.latestEventData?[0].sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
       //                                self.gridData?[index].subTitle = startData
        
        
        let startTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEE, MMM d, hh:mm a")
        
        let endTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")

        lblDateTime.text = "\(startTime) - \(endTime)"
        
        lblTitle.text = "\(cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "")"
        
        lblTotalHours.text = "Location: \(cellModel?.sjavms_VolunteerEvent?.msnfp_location ?? "Not Found") "

    }
    
    
}
