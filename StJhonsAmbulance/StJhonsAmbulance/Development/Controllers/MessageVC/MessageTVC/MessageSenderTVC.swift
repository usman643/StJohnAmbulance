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
        
        
        //        mainView.layer.borderWidth = 0.5
        //        mainView.layer.borderColor = UIColor.systemGray3.cgColor
        //        mainView.layer.shadowColor = UIColor.systemGray4.cgColor
        //        mainView.layer.shadowOpacity = 0.8
        //        mainView.layer.shadowOffset = .zero
        //        mainView.layer.shadowRadius = 6
        //
        //        mainView.layer.cornerRadius = 12
    }
    
    
}
