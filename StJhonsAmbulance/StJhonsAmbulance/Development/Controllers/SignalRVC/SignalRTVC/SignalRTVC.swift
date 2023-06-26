//
//  SignalRTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/06/2023.
//

import UIKit

class SignalRTVC: UITableViewCell {

    @IBOutlet weak var lblMessage: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblMessage.font = UIFont.MediumFont(14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
