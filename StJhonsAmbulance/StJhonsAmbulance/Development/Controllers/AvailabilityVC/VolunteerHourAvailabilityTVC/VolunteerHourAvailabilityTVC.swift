//
//  VolunteerHourAvailabilityTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 15/02/2023.
//

import UIKit

class VolunteerHourAvailabilityTVC: UITableViewCell {

    
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblProgram: UILabel!
    @IBOutlet weak var lblSchedule: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var seperaterView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func decorateUI(){
        
        lblEvent.textColor = UIColor.textBlackColor
        lblEvent.font = UIFont.RegularFont(10)
        lblProgram.textColor = UIColor.textBlackColor
        lblProgram.font = UIFont.RegularFont(10)
        lblSchedule.textColor = UIColor.textBlackColor
        lblSchedule.font = UIFont.RegularFont(10)
        lblStart.textColor = UIColor.textBlackColor
        lblStart.font = UIFont.RegularFont(10)
        lblEnd.textColor = UIColor.textBlackColor
        lblEnd.font = UIFont.RegularFont(10)
        lblHours.textColor = UIColor.textBlackColor
        lblHours.font = UIFont.RegularFont(10)
        lblStatus.textColor = UIColor.textBlackColor
        lblStatus.font = UIFont.RegularFont(10)
        
    }
    
//    func setContent(cellModel: rowModel){
//        
//        lblEvent.text = cellModel.
//        lblProgram.text = cellModel.
//        lblSchedule.text = cellModel.
//        lblStart.text = cellModel.
//        lblEnd.text = cellModel.
//        lblHours.text = cellModel.
//        lblStatus.text = cellModel.
//        
//        
//        
//    }
    
    
}
