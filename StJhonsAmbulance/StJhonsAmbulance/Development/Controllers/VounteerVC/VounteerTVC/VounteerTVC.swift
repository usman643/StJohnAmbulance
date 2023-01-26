//
//  VounteerTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 26/01/2023.
//

import UIKit

class VounteerTVC: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var mianView: UIView!
    
    @IBOutlet weak var dividerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }
    
    func decorateUI(){
        
        lblName.font = UIFont.MediumFont(12)
        lblRole.font = UIFont.MediumFont(12)
        lblCity.font = UIFont.MediumFont(12)
        lblState.font = UIFont.RegularFont(12)
        
        lblName.textColor = UIColor.textBlackColor
        lblRole.textColor = UIColor.textBlackColor
        lblCity.textColor = UIColor.textBlackColor
        lblState.textColor = UIColor.textBlackColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
