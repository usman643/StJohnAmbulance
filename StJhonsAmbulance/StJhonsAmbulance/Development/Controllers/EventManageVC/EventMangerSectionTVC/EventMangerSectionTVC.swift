//
//  EventMangerSectionTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 05/02/2023.
//

import UIKit

class EventMangerSectionTVC: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    func decorateUI(){
        lblDate.font = UIFont.BoldFont(16)
        lblTime.font = UIFont.BoldFont(16)
        
        lblDate.textColor = UIColor.orangeColor
        lblTime.textColor = UIColor.red
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
