//
//  SideMenuShiftTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 27/09/2023.
//

import UIKit

class SideMenuShiftTVC: UITableViewCell {

       @IBOutlet weak var icon: UIImageView!
       @IBOutlet weak var lblTitle: UILabel!
       
       
       override func awakeFromNib() {
           super.awakeFromNib()
           icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
           icon.tintColor  = UIColor.textWhiteColor
           lblTitle.font = UIFont.BoldFont(14)
           lblTitle.textColor = UIColor.textWhiteColor

       }

       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
           // Configure the view for the selected state
       }
       
   }
