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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.BoldFont(14)
        lblTitle.textColor = UIColor.themePrimaryWhite
        
        lblMessage.font = UIFont.RegularFont(12)
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

