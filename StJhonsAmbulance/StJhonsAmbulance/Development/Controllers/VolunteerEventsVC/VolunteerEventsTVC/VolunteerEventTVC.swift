//
//  VolunteerEventTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 07/02/2023.
//

import UIKit

class VolunteerEventTVC: UITableViewCell {
    
    
    @IBOutlet weak var seperatorView: UIView!
    
    @IBOutlet var allLabel: [UILabel]!
    
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblAction: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deocrateUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func deocrateUI(){
        for label in allLabel{
            label.font = UIFont.RegularFont(12)
            label.textColor = UIColor.textBlackColor
        }
    }
}
