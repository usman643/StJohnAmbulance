//
//  SideMenuTVC.swift
//  WIT Edu
//
//  Created by Umair Yousaf on 14/08/2022.
//

import UIKit

class SideMenuTVC: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor  = UIColor.black
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
