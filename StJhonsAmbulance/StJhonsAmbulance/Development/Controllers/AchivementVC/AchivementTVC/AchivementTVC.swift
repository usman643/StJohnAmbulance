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
        lblName.textColor = UIColor.themePrimary
        lblName.font = UIFont.RegularFont(14)
        lblDate.textColor = UIColor.themePrimary
        lblDate.font = UIFont.RegularFont(14)
    }
    
}
