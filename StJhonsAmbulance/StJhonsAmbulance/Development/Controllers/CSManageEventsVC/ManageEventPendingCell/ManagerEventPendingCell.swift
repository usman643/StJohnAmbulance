//
//  ManagerEventPendingCell.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 28/09/2023.
//

import UIKit

class ManagerEventPendingCell: UITableViewCell {
    
    public var delegate : EventSummaryDelegate?
    var eventdata : CurrentEventsModel?

 
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblProgram: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var btnDetail: UIButton!
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var dateImg: UIImageView!
    
    @IBOutlet weak var lblparticipants: UILabel!
    
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
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
        
        

        lblTitle.textColor = UIColor.themePrimaryWhite
        lblProgram.textColor = UIColor.themeBlackText
        lblLocation.textColor = UIColor.themeBlackText
        lblDateTime.textColor = UIColor.themeBlackText
        lblparticipants.textColor = UIColor.themeBlackText
        lblStatus.textColor = UIColor.textLightGrayColor
    
        lblDateTime.font =  UIFont.BoldFont(13)
        lblparticipants.font =  UIFont.BoldFont(13)
        lblTitle.font =  UIFont.BoldFont(18)
        lblProgram.font =  UIFont.BoldFont(13)
        lblLocation.font =  UIFont.BoldFont(13)
        lblStatus.font =  UIFont.BoldFont(12)
        
        userImg.image = userImg.image?.withRenderingMode(.alwaysTemplate)
        userImg.tintColor = UIColor.themePrimaryColor
        dateImg.image = dateImg.image?.withRenderingMode(.alwaysTemplate)
        dateImg.tintColor = UIColor.themePrimaryColor
    }
    
}
