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
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var btnView: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func decorateUI(){
        
        
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.systemGray3.cgColor
        mainView.layer.shadowColor = UIColor.systemGray4.cgColor
        mainView.layer.shadowOpacity = 0.5
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 6
        
        mainView.layer.cornerRadius = 16
        statusView.layer.cornerRadius = 16
        statusView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        btnView.setTitleColor(UIColor.textWhiteColor, for: .normal)
        lblDate.textColor = UIColor.themeSecondryWhite
        lblDate.font =  UIFont.MediumFont(11)
        btnView.titleLabel?.font = UIFont.BoldFont(13)
        
        lblQualification.textColor = UIColor.themeSecondryWhite
        lblQualification.font = UIFont.BoldFont(13)
        lblCertificateId.textColor = UIColor.themeSecondryWhite
        lblCertificateId.font = UIFont.BoldFont(13)
        lblType.textColor = UIColor.themeSecondryWhite
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
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            issueDate = start
        }else{
            issueDate = ""
        }
        
        if let date = cellModel?.sjavms_expirydate {
            let expiry = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            expireDate = expiry
        }else{
            expireDate = ""
        }
        
        
        self.lblDate.text = "\(issueDate) - \(expireDate)"
        
        
        
    }
    
    
}
