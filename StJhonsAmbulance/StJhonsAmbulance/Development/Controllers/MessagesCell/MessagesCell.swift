//
//  MessagesCell.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 26/06/2023.
//

import UIKit

class MessagesCell: UITableViewCell {

    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
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
        lblName.font = UIFont.BoldFont(13)
        lblName.textColor = UIColor.themeColorSecondry
        lblMessage.font = UIFont.BoldFont(12)
        lblMessage.textColor = UIColor.themeBlackText
        
        
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.systemGray3.cgColor
        mainView.layer.shadowColor = UIColor.systemGray4.cgColor
        mainView.layer.shadowOpacity = 0.8
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 6
        
        mainView.layer.cornerRadius = 12
    }
    
    
}
