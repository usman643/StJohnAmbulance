//
//  EventSummaryScreenTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 24/03/2023.
//

import UIKit

class EventSummaryScreenTVC: UITableViewCell {

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblVolunteen: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var seperaterView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func decorateUI(){
        lblVolunteen.textColor = UIColor.textBlackColor
        lblEvent.textColor = UIColor.textBlackColor
        lblStart.textColor = UIColor.textBlackColor
        lblHour.textColor = UIColor.textBlackColor
        lblStatus.textColor = UIColor.textBlackColor
        
        lblVolunteen.font = UIFont.RegularFont(11)
        lblEvent.font = UIFont.RegularFont(11)
        lblStart.font = UIFont.RegularFont(11)
        lblHour.font = UIFont.RegularFont(11)
        lblStatus.font = UIFont.RegularFont(11)
    }
    
}
