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
        mainView.layer.borderColor = UIColor.systemGray3.cgColor
        mainView.layer.shadowColor = UIColor.systemGray4.cgColor
        mainView.layer.shadowOpacity = 0.5
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 6
        
        mainView.layer.cornerRadius = 8
        
        lblName.textColor = UIColor.themePrimary
        lblName.font = UIFont.BoldFont(16)
        lblDate.textColor = UIColor.themePrimary
        lblDate.font = UIFont.BoldFont(10)
        
        
    }
    
}
