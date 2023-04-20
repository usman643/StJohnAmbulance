//
//  ContactDocumentsTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 20/04/2023.
//

import UIKit

class ContactDocumentsTVC: UITableViewCell {

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblModifiedDate: UILabel!
    @IBOutlet weak var lblAction: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }
    
    func decorateUI(){
        lblName.textColor = UIColor.textBlackColor
        lblModifiedDate.textColor = UIColor.textBlackColor
        lblAction.textColor = UIColor.textBlackColor
        
        lblName.font = UIFont.RegularFont(12)
        lblModifiedDate.font = UIFont.RegularFont(12)
        lblAction.font = UIFont.RegularFont(12)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
//    func setContent(cellModel:){
//
//
//
//    }
    
}
