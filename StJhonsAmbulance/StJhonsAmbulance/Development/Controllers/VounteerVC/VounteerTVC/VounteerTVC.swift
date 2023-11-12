//
//  VounteerTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 26/01/2023.
//

import UIKit

class VounteerTVC: UITableViewCell {

    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var mianView: UIView!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var roleImge: UIImageView!
    
    
    @IBOutlet weak var btnMsg: UIButton!
    @IBOutlet weak var btnDetail: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }
    
    func decorateUI(){
        roleImge.image = roleImge.image?.withRenderingMode(.alwaysTemplate)
        roleImge.tintColor = UIColor.themePrimaryColor
        lblName.font = UIFont.HeaderBoldFont(16)
        lblRole.font = UIFont.SemiBoldFont(12)
        lblAddress.font = UIFont.SemiBoldFont(12)

        lblName.textColor = UIColor.themePrimaryWhite
        lblRole.textColor = UIColor.themeBlackText
        lblAddress.textColor = UIColor.themeBlackText
        roleImge.image = roleImge.image?.withRenderingMode(.alwaysTemplate)
        roleImge.tintColor = UIColor.themePrimaryColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
