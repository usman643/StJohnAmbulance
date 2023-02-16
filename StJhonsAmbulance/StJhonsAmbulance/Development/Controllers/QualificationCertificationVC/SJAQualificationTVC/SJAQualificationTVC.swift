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
        lblType.textColor = UIColor.textBlackColor
        lblType.font = UIFont.RegularFont(10)
        lblEffectiveFrom.textColor = UIColor.textBlackColor
        lblEffectiveFrom.font = UIFont.RegularFont(10)
        lblExpiration.textColor = UIColor.textBlackColor
        lblExpiration.font = UIFont.RegularFont(10)
        
    }
    
        func setContent(cellModel: SJAQualificationDataModel?){
    
//            lblQualification.text = cellModel
//            lblType.text = cellModel
//            lblEffectiveFrom.text = cellModel
//            lblExpiration.text = cellModel
        }
    
    
}
