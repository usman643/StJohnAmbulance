//
//  AvailabilityTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 15/02/2023.
//

import UIKit

class AvailabilityTVC: UITableViewCell {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblEffectiveFrom: UILabel!
    @IBOutlet weak var lblEffectiveto: UILabel!
    @IBOutlet weak var lblWorkingDays: UILabel!
    @IBOutlet weak var seperaterView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        deocrateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func deocrateUI(){
        lblTitle.textColor = UIColor.textBlackColor
        lblTitle.font = UIFont.RegularFont(12)
        lblEffectiveFrom.textColor = UIColor.textBlackColor
        lblEffectiveFrom.font = UIFont.RegularFont(12)
        lblEffectiveto.textColor = UIColor.textBlackColor
        lblEffectiveto.font = UIFont.RegularFont(12)
        lblWorkingDays.textColor = UIColor.textBlackColor
        lblWorkingDays.font = UIFont.RegularFont(12)
        
        
    }
    
//    func setContent(cellModel: rowModel){
//        
//        lblTitle.text = cellModel.
//        lblEffectiveFrom.text = cellModel.
//        lblEffectiveto.text = cellModel.
//        lblWorkingDays.text = cellModel.
//        
//    }
    
}
