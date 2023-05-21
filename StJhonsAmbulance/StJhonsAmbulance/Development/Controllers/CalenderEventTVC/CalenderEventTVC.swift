//
//  CalenderEventTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 15/05/2023.
//

import UIKit

class CalenderEventTVC: UITableViewCell {
    
    @IBOutlet weak var lblEventName: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    
    @IBOutlet weak var locationImg: UIImageView!
    @IBOutlet weak var mainView: UIView!
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
        btnDetail.layer.cornerRadius = btnDetail.frame.size.height/2
        btnDetail.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnDetail.titleLabel?.font = UIFont.BoldFont(12)
        
        lblEventName.font = UIFont.BoldFont(14)
        
        lblDate.font = UIFont.RegularFont(12)
        lblLocation.font = UIFont.RegularFont(12)
        
        lblEventName.textColor = UIColor.themeBlackText
        
        lblDate.textColor = UIColor.themePrimaryWhite
        lblLocation.textColor = UIColor.themePrimaryWhite
        
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.systemGray3.cgColor
        mainView.layer.shadowColor = UIColor.systemGray4.cgColor
        mainView.layer.shadowOpacity = 0.8
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 6
        
        locationImg.image = locationImg.image?.withRenderingMode(.alwaysTemplate)
        locationImg.tintColor = UIColor.themePrimaryColor
    }
    
    func setContent (cellModel:ScheduleEngagementModel?){
        
        lblEventName.text = cellModel?.Title ?? "Not Found"
        
        lblDate.text = "\(cellModel?.StartDate  ?? "Not Found" ) - \(cellModel?.EndDate  ?? "Not Found" )"
        lblLocation.text = cellModel?.LocationTitle ?? "Not Found"
        
        
    }
    
    
    
    @IBAction func userdetailTapped(_ sender: Any) {
        
        
    }
    
    
    
    
    
    
}
