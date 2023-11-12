//
//  InAppEventTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 19/07/2023.
//

import UIKit

class InAppEventTVC: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var userImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.HeaderBoldFont(16)
        lblTitle.textColor = UIColor.textBlackColor
        
        lblMessage.font = UIFont.MediumFont(12)
        lblMessage.textColor = UIColor.textGrayColor
        lblTime.font = UIFont.RegularFont(12)
        lblTime.textColor = UIColor.textGrayColor
        //        self.contentView.backgroundColor = UIColor.themeLight
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        self.contentView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
    }
    
}

