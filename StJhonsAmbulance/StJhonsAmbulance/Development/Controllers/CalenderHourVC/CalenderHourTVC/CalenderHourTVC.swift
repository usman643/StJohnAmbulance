//
//  CalenderHourTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 21/05/2023.
//

import UIKit

class CalenderHourTVC: UITableViewCell {

    
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var hourHighLightView: UIView!
    @IBOutlet weak var hourSeperatorView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func decorateUI(){
        
        lblHour.font = UIFont.BoldFont(12)
        lblHour.textColor = UIColor.themeBlackColor
//        hourSeperatorView.backgroundColor = UIColor.themeBlackColor
//        hourHighLightView.backgroundColor = UIColor.lightGray
        
    }
    
    
    
}
