//
//  ExternalQualificationCell.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 23/07/2023.
//

import UIKit

class ExternalQualificationCell: UITableViewCell {

    
    @IBOutlet weak var lblCertificateId: UILabel!
    @IBOutlet weak var lblQualification: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func decorateUI(){
        
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.systemGray5.cgColor
        mainView.layer.shadowColor = UIColor.systemGray2.cgColor
        mainView.layer.shadowOpacity = 0.4
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 8
        
        mainView.layer.cornerRadius = 8
        lblDate.textColor = UIColor.textDarkGreenWhite
        lblDate.font =  UIFont.BoldFont(13)
        
        lblQualification.textColor = UIColor.headerGreenWhite
        lblQualification.font = UIFont.HeaderBlackFont(16)
        lblCertificateId.textColor = UIColor.textDarkGreenWhite
        lblCertificateId.font = UIFont.BoldFont(13)
        lblType.textColor = UIColor.textDarkGreenWhite
        lblType.font = UIFont.BoldFont(13)
        
    }
    
    func setContent(cellModel: ExternalQualificationDataModel?){

        var issueDate = ""
        var expireDate = ""
        
        
        lblCertificateId.text = "\(cellModel?.sjavms_name ?? "")"
        lblQualification.text = cellModel?.sjavms_Qualification?.sjavms_type_value ?? ""
//        lblAction.text = cellModel
        
        lblType.text = cellModel?.sjavms_Qualification?.sjavms_name ?? ""
//        lblType.text = cellModel?.sjavms_Qualification?.sjavms_type_value ?? ""
        
        if let date = cellModel?.sjavms_issuedate {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy MMM dd")
            issueDate = start
        }else{
            issueDate = ""
        }
        
        if let date = cellModel?.sjavms_expirydate {
            let expiry = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy MMM dd")
            expireDate = expiry
        }else{
            expireDate = ""
        }
        
        
        self.lblDate.text = "\(issueDate) - \(expireDate)"
        
        
        
    }
    
    
}
