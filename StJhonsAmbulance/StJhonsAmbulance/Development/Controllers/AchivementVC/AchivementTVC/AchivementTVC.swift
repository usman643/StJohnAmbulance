//
//  AchivementTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 15/03/2023.
//

import UIKit

class AchivementTVC: UITableViewCell {
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblNameTitle: UILabel!
    @IBOutlet weak var lblDateTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.decorateUI()
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
        
        lblName.textColor = UIColor.themePrimary
        lblName.font = UIFont.RegularFont(14)
        lblDate.textColor = UIColor.themePrimary
        lblDate.font = UIFont.RegularFont(14)
        
        lblNameTitle.font = UIFont.BoldFont(14)
        lblDateTitle.font = UIFont.BoldFont(14)
        lblNameTitle.textColor = UIColor.themePrimary
        lblDateTitle.textColor = UIColor.themePrimary
        
    }
    
}
