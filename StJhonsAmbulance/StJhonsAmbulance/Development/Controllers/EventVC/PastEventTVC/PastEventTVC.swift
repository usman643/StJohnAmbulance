//
//  PastEventTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 28/01/2023.
//

import UIKit

class PastEventTVC: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDate: UILabel!

    @IBOutlet weak var seperaterView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deocrateUI()
    }
    
    func deocrateUI(){
        
        lblEvent.font = UIFont.BoldFont(11)
        lblLocation.font = UIFont.BoldFont(11)
        lblDate.font = UIFont.BoldFont(11)
        
        lblEvent.textColor = UIColor.textBlackColor
        lblLocation.textColor = UIColor.textBlackColor
        lblDate.textColor = UIColor.textBlackColor

    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
