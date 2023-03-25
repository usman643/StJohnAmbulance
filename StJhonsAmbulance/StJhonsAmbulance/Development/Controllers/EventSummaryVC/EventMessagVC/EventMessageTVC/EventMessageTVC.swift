//
//  EventMessageTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/03/2023.
//

import UIKit

class EventMessageTVC: UITableViewCell {

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSent: UILabel!
    @IBOutlet weak var lblModified: UILabel!
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
        
        lblSubject.textColor = UIColor.textBlackColor
        lblDesc.textColor = UIColor.textBlackColor
        lblStatus.textColor = UIColor.textBlackColor
        lblSent.textColor = UIColor.textBlackColor
        lblModified.textColor = UIColor.textBlackColor
        
        lblSubject.font = UIFont.BoldFont(11)
        lblDesc.font = UIFont.BoldFont(11)
        lblStatus.font = UIFont.BoldFont(11)
        lblSent.font = UIFont.BoldFont(11)
        lblModified.font = UIFont.BoldFont(11)
        
    }
    
}
