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
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func decorateUI(){
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.systemGray5.cgColor
        mainView.layer.shadowColor = UIColor.systemGray2.cgColor
        mainView.layer.shadowOpacity = 0.4
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 8
        
        mainView.layer.cornerRadius = 8
        
        lblName.textColor = UIColor.headerGreen
        lblName.font = UIFont.HeaderBlackFont(16)
        lblDate.textColor = UIColor.textDarkGreenWhite
        lblDate.font = UIFont.BoldFont(13)
        
        
    }
    
}
