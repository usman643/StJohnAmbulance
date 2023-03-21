//
//  SJAQualificationTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 16/02/2023.
//

import UIKit

class SJAQualificationTVC: UITableViewCell {

    @IBOutlet weak var lblQualification: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblEffectiveFrom: UILabel!
    @IBOutlet weak var lblExpiration: UILabel!
    @IBOutlet weak var seperaterView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func decorateUI(){
        
        lblQualification.textColor = UIColor.textBlackColor
        lblQualification.font = UIFont.RegularFont(10)
        lblType.textColor = UIColor.themeBlackText
        lblType.font = UIFont.RegularFont(10)
        lblEffectiveFrom.textColor = UIColor.themeBlackText
        lblEffectiveFrom.font = UIFont.RegularFont(10)
        lblExpiration.textColor = UIColor.themeBlackText
        lblExpiration.font = UIFont.RegularFont(10)
        
    }
    
        func setContent(cellModel: SJAQualificationDataModel?){

            lblType.text = cellModel?.bdo_type_value ?? "..."
            lblQualification.text = cellModel?.bdo_qualificationsid?.bdo_name
            if let date = cellModel?.bdo_effectivedate {
                let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
                lblEffectiveFrom.text = start
            }else{
                lblEffectiveFrom.text = ""
            }
            
            if let date = cellModel?.bdo_expirationdate {
                let expiry = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
                lblExpiration.text = expiry
            }else{
                lblExpiration.text = ""
            }
            
        }
    
    
}
