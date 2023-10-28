//
//  EventDetailTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 29/09/2023.
//

import UIKit

class EventDetailTVC: UITableViewCell {
    
    public var delegate : updateVolunteerCheckInDelegate?
    var cellModel : VolunteerOfEventDataModel?
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnCheckIn: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.BoldFont(16)
        lblTitle.textColor = UIColor.textBlackColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func switchButton(_ sender: Any) {
        
        
        if ( cellModel?.sjavms_checkedin == true){
            cellModel?.sjavms_checkedin = false as! Bool
            
            let params = [
                "sjavms_checkedin": false
            ]
//            self.updateCheckInData(participationId: rowModel?[indexPath.row].msnfp_participationscheduleid ?? "", params: params)
            delegate?.updateVolunteerCheckIn(participationId: cellModel?.msnfp_participationscheduleid ?? "", param: params)
        }else{
            
            cellModel?.sjavms_checkedin = true
            let params = [
                "sjavms_checkedin": true as! Bool
            ]
//            self.updateCheckInData(participationId: rowModel?[indexPath.row].msnfp_participationscheduleid ?? "", params: params)
            delegate?.updateVolunteerCheckIn(participationId: cellModel?.msnfp_participationscheduleid ?? "", param: params)
        }
        
//        delegate?.updateVolunteerCheckIn(participationId: cellModel?.msnfp_participationscheduleid, param: params)
        
    }
    
}
