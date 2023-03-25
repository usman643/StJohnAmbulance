//
//  EventAuditTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/03/2023.
//

import UIKit

class EventAuditTVC: UITableViewCell {

    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblChangeDate: UILabel!
    @IBOutlet weak var lblChangeBy: UILabel!
    @IBOutlet weak var lblChangeEvent: UILabel!
    @IBOutlet weak var lblChangeField: UILabel!
    @IBOutlet weak var lblOldValue: UILabel!
    @IBOutlet weak var lblNewValue: UILabel!
    
    
    @IBOutlet weak var seperterView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func decorateUI(){
        lblChangeDate.textColor = UIColor.textBlackColor
        lblChangeBy.textColor = UIColor.textBlackColor
        lblChangeEvent.textColor = UIColor.textBlackColor
        lblChangeField.textColor = UIColor.textBlackColor
        lblOldValue.textColor = UIColor.textBlackColor
        lblNewValue.textColor = UIColor.textBlackColor
        
        lblChangeDate.font = UIFont.RegularFont(11)
        lblChangeBy.font = UIFont.RegularFont(11)
        lblChangeEvent.font = UIFont.RegularFont(11)
        lblChangeField.font = UIFont.RegularFont(11)
        lblOldValue.font = UIFont.RegularFont(11)
        lblNewValue.font = UIFont.RegularFont(11)
    }
    
}
