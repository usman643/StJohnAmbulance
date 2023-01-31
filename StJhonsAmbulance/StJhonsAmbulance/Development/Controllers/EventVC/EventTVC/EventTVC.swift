//
//  EventTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 27/01/2023.
//

import UIKit

class EventTVC: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var lblNeeded: UILabel!
    @IBOutlet weak var seperaterView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deocrateUI()
    }
    
    func deocrateUI(){
        
        lblEvent.font = UIFont.RegularFont(11)
        lblLocation.font = UIFont.RegularFont(11)
        lblStart.font = UIFont.RegularFont(11)
        lblEnd.font = UIFont.RegularFont(11)
        lblNeeded.font = UIFont.RegularFont(11)
        
        lblEvent.textColor = UIColor.textBlackColor
        lblLocation.textColor = UIColor.textBlackColor
        lblStart.textColor = UIColor.textBlackColor
        lblEnd.textColor = UIColor.textBlackColor
        lblNeeded.textColor = UIColor.textBlackColor
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
