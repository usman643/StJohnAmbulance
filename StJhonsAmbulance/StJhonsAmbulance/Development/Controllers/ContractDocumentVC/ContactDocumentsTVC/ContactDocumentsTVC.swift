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
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }
    
    func decorateUI(){
        lblName.textColor = UIColor.textBlackColor
        lblModifiedDate.textColor = UIColor.textBlackColor
        lblAction.textColor = UIColor.textBlackColor
        
        lblName.font = UIFont.BoldFont(12)
        lblModifiedDate.font = UIFont.BoldFont(12)
        lblAction.font = UIFont.BoldFont(12)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setContent(cellModel:ContactDocumentResults?){

        lblName.text = cellModel?.Name ?? "Not Found"
        
        if let date = cellModel?.TimeLastModified {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
            lblModifiedDate.text = start
        }else{
            lblModifiedDate.text = ""
        }
        
        lblAction.text = ""

    }
    
}
