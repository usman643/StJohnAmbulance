//
//  PendingEventTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 28/01/2023.
//

import UIKit

class PendingEventTVC: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var seperaterView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deocrateUI()
    }
    
    func deocrateUI(){
        
        lblName.font = UIFont.RegularFont(11)
        lblLocation.font = UIFont.RegularFont(11)
        lblMax.font = UIFont.RegularFont(11)
        lblDate.font = UIFont.RegularFont(11)
        lblStatus.font = UIFont.RegularFont(11)
        
        lblName.textColor = UIColor.textBlackColor
        lblLocation.textColor = UIColor.textBlackColor
        lblMax.textColor = UIColor.textBlackColor
        lblDate.textColor = UIColor.textBlackColor
        lblStatus.textColor = UIColor.textBlackColor
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
