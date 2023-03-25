//
//  EventHourTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/03/2023.
//

import UIKit

class EventHourTVC: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func decorateUI(){
        lblName.textColor = UIColor.textBlackColor
        lblEvent.textColor = UIColor.textBlackColor
        lblDate.textColor = UIColor.textBlackColor
        lblHour.textColor = UIColor.textBlackColor
        lblStatus.textColor = UIColor.textBlackColor
        
        lblName.font = UIFont.RegularFont(11)
        lblEvent.font = UIFont.RegularFont(11)
        lblDate.font = UIFont.RegularFont(11)
        lblHour.font = UIFont.RegularFont(11)
        lblStatus.font = UIFont.RegularFont(11)
    }
}
