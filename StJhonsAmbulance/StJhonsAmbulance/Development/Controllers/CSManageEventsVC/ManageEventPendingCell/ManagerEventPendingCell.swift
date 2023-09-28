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
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblProgram: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var btnDetail: UIButton!
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var lblparticipants: UILabel!
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
        lblProgram.textColor = UIColor.themeSecondryWhite
        
        lblLocation.textColor = UIColor.themeSecondryWhite
        
        lblDateTime.font =  UIFont.MediumFont(11)
        lblparticipants.font =  UIFont.MediumFont(11)
        btnView.titleLabel?.font = UIFont.BoldFont(13)
        lblTitle.font =  UIFont.BoldFont(14)
        lblProgram.font =  UIFont.BoldFont(13)
        
        lblLocation.font =  UIFont.RegularFont(11)
        
    }
    
}
