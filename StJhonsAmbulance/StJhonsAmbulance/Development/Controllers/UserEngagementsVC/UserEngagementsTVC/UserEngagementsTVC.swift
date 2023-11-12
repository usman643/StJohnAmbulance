//
//  UserEngagementsTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 02/05/2023.
//

import UIKit

class UserEngagementsTVC: UITableViewCell {
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblProgramType: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var locationImg: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var statusView: UIView!
    
    @IBOutlet weak var btnDetail: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
        // Initialization code
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
        
        lblDate.textColor = UIColor.textDarkGreenWhite
        lblDate.font =  UIFont.BoldFont(13)
        
        lblEventName.textColor = UIColor.headerGreenWhite
        lblProgramType.textColor = UIColor.textDarkGreenWhite
        lblLocation.textColor = UIColor.textDarkGreenWhite
        lblDetail.textColor = UIColor.textDarkGreenWhite
        
        lblEventName.font = UIFont.HeaderBlackFont(16)
        lblProgramType.font = UIFont.BoldFont(13)
        lblLocation.font = UIFont.BoldFont(13)
        lblDetail.font = UIFont.BoldFont(13)
        
        locationImg.image = locationImg.image?.withRenderingMode(.alwaysTemplate)
        
        locationImg.tintColor = UIColor.textDarkGreen
        btnDetail.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnDetail.titleLabel?.font = UIFont.BoldFont(13)
        
        btnDetail.layer.cornerRadius = 8
        btnDetail.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        
    }
    func setContent (cellModel:ScheduleEngagementModel?){
        
        lblEventName.text = cellModel?.Title ?? "Not Found"
        lblProgramType.text = cellModel?.Program ?? "Not Found"
        
//        
        let startDate = cellModel?.StartDateFull?.replacingOccurrences(of: " GMT", with: "")
        let endDate = cellModel?.EndDateFull?.replacingOccurrences(of: " GMT", with: "")
//        let startDate = cellModel?.StartDateFull ?? ""
//        let endDate = cellModel?.EndDateFull ?? ""
        
        let start = DateFormatManager.shared.formatDateStrToStrWithoutZoneCountry(date: startDate ?? "", oldFormat: "E, d MMM yyyy HH:mm:ss", newFormat: "EEE, d MMM yyyy hh:mm a")
        let end = DateFormatManager.shared.formatDateStrToStrWithoutZoneCountry(date: endDate ?? "", oldFormat: "E, d MMM yyyy HH:mm:ss", newFormat: "EEE, d MMM yyyy hh:mm a")
        
        lblDate.text = "\(start) - \(end)"
//        lblDate.text = "\(cellModel?.StartDateString  ?? "Not Found" ) - \(cellModel?.EndDateString  ?? "Not Found" )"

        
        lblLocation.text = cellModel?.LocationTypeName ?? "Not Found"
        lblDetail.text = cellModel?.Desc ?? "Not Found"
    }
    
    
    
    @IBAction func userdetailTapped(_ sender: Any) {
        
        
    }
}
