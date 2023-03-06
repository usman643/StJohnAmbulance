//
//  ExternalQualificationTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 16/02/2023.
//

import UIKit

class ExternalQualificationTVC: UITableViewCell {

    
    @IBOutlet weak var lblCertificateId: UILabel!
    @IBOutlet weak var lblQualification: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblIssue: UILabel!
    @IBOutlet weak var lblExpire: UILabel!
    @IBOutlet weak var lblAction: UILabel!
    @IBOutlet weak var seperaterView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func decorateUI(){
        lblCertificateId.textColor = UIColor.themeBlackText
        lblCertificateId.font = UIFont.RegularFont(10)
        lblQualification.textColor = UIColor.themeBlackText
        lblQualification.font = UIFont.RegularFont(10)
        lblType.textColor = UIColor.themeBlackText
        lblType.font = UIFont.RegularFont(10)
        lblIssue.textColor = UIColor.themeBlackText
        lblIssue.font = UIFont.RegularFont(10)
        lblExpire.textColor = UIColor.themeBlackText
        lblExpire.font = UIFont.RegularFont(10)
        lblAction.textColor = UIColor.themeBlackText
        lblAction.font = UIFont.RegularFont(10)
        
    }
    
    func setContent(cellModel: ExternalQualificationDataModel?){

        lblCertificateId.text = "\(cellModel?.sjavms_Qualification?.sjavms_type ?? NSNotFound)"
        lblQualification.text = cellModel?.sjavms_Qualification?.sjavms_name ?? ""
//        lblAction.text = cellModel
        
        lblType.text = cellModel?.sjavms_Qualification?.sjavms_type_value ?? ""
        
        if let date = cellModel?.sjavms_issuedate {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            lblIssue.text = start
        }else{
            lblIssue.text = ""
        }
        
        if let date = cellModel?.sjavms_expirydate {
            let expiry = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            lblExpire.text = expiry
        }else{
            lblExpire.text = ""
        }
        
        
        
    }
    
    
}
