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
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var documentImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }
    
    func decorateUI(){
        
//        documentImg.image = documentImg.image?.withRenderingMode(.alwaysTemplate)
//        documentImg.tintColor = UIColor.headerGreen
        lblName.textColor = UIColor.textDarkGreenWhite
        lblModifiedDate.textColor = UIColor.textDarkGreenWhite
//        lblAction.textColor = UIColor.textBlackColor
        
        lblName.font = UIFont.HeaderBlackFont(16)
        lblModifiedDate.font = UIFont.BoldFont(13)
//        lblAction.font = UIFont.BoldFont(12)
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.systemGray5.cgColor
        mainView.layer.shadowColor = UIColor.systemGray2.cgColor
        mainView.layer.shadowOpacity = 0.4
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 8
        mainView.layer.cornerRadius = 8
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setContent(cellModel:ContactDocumentResults?){

        lblName.text = cellModel?.Name ?? "Not Found"
        
        if let date = cellModel?.TimeLastModified {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEE, MMM d, hh:mm a")
            lblModifiedDate.text = start
        }else{
            lblModifiedDate.text = ""
        }
        
        

    }
    
}
