//
//  MessageSenderTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 20/10/2023.
//

import UIKit

class MessageSenderTVC: UITableViewCell {
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var messageView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func decorateUI(){
        userImage.layer.cornerRadius = userImage.frame.size.height/2
        lblTime.font = UIFont.BoldFont(10)
        lblTime.textColor = UIColor.textGrayColor
        lblMessage.font = UIFont.BoldFont(12)
        lblMessage.textColor = UIColor.textWhiteColor
  
        messageView.layer.shadowColor = UIColor.systemGray2.cgColor
        messageView.layer.shadowOpacity = 0.4
        messageView.layer.shadowOffset = .zero
        messageView.layer.shadowRadius = 8
        
    }
    
    
}
