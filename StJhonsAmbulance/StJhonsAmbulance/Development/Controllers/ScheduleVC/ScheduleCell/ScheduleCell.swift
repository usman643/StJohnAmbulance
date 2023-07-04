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
        btnMainView.layer.cornerRadius = 16
        btnMainView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        
        lblDate.textColor = UIColor.themeSecondry
        
        lblTitle.textColor = UIColor.themeSecondry
        lblSubTitle.textColor = UIColor.themeSecondry
        
        lblDate.font =  UIFont.MediumFont(11)
        
        lblTitle.font =  UIFont.BoldFont(14)
        lblSubTitle.font =  UIFont.RegularFont(13)
        
        locationImg.image = locationImg.image?.withRenderingMode(.alwaysTemplate)
        
        locationImg.tintColor = UIColor.themeColorSecondry
        btnView.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnView.titleLabel?.font = UIFont.BoldFont(12)
        
    }
    
    
    func setContent(cellModel : ScheduleModelThree?){
    
        lblTitle.text = "Title: \(cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "")"
        lblSubTitle.text = "Location: \(cellModel?.sjavms_VolunteerEvent?.msnfp_location ?? "Not Found") "
        if (cellModel?.sjavms_start != "" && cellModel?.sjavms_start != nil ){
            
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEE, MMM d, hh:mm a")
            
                        lblDate.text = startTime
                        
                    }else{
                        lblDate.text = "Not Found"
                        
                    }
    }
    
}
