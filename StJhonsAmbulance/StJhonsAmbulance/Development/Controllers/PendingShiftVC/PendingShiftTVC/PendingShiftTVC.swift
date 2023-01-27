//
//  PendingShiftTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 27/01/2023.
//

import UIKit

class PendingShiftTVC: UITableViewCell {

    
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblShift: UILabel!
    @IBOutlet weak var lblAction: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func decorateUI(){
        
        lblName.font = UIFont.RegularFont(10)
        lblName.font = UIFont.RegularFont(10)
        lblEvent.font = UIFont.RegularFont(10)
        lblDate.font = UIFont.RegularFont(10)
        lblHours.font = UIFont.RegularFont(10)
        lblShift.font = UIFont.RegularFont(8)
        lblAction.font = UIFont.RegularFont(10)
        
        lblName.textColor = UIColor.textBlackColor
        lblName.textColor = UIColor.textBlackColor
        lblEvent.textColor = UIColor.textBlackColor
        lblDate.textColor = UIColor.textBlackColor
        lblHours.textColor = UIColor.textBlackColor
        lblShift.textColor = UIColor.textBlackColor
        lblAction.textColor = UIColor.textBlackColor
    }
    
}
