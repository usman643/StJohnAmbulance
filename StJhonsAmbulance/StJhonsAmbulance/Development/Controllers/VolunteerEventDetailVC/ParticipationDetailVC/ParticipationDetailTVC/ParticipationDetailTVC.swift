//
//  ParticipationDetailTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 05/04/2023.
//

import UIKit

class ParticipationDetailTVC: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblCreate: UILabel!
    @IBOutlet weak var lblVolunteer: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var lblCompleted: UILabel!
    @IBOutlet weak var seperaterView: UIView!
    @IBOutlet weak var lblPending: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }
    
    func decorateUI(){
        
        lblCreate.textColor = UIColor.textBlackColor
        lblVolunteer.textColor = UIColor.textBlackColor
        lblEvent.textColor = UIColor.textBlackColor
        lblStart.textColor = UIColor.textBlackColor
        lblEnd.textColor = UIColor.textBlackColor
        lblCompleted.textColor = UIColor.textBlackColor
        lblPending.textColor = UIColor.textBlackColor
        
        lblCreate.font = UIFont.RegularFont(11)
        lblVolunteer.font = UIFont.RegularFont(11)
        lblEvent.font = UIFont.RegularFont(11)
        lblStart.font = UIFont.RegularFont(11)
        lblEnd.font = UIFont.RegularFont(11)
        lblCompleted.font = UIFont.RegularFont(11)
        lblPending.font = UIFont.RegularFont(11)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setContent(cellModel:OtherVolunteerParticipationModel?){
        
        if let participationtitle = cellModel?.msnfp_participationtitle{
            
            let arr = participationtitle.components(separatedBy: " - ")
            lblVolunteer.text = arr[0]
            lblEvent.text = arr[1]
            
        }
        
//        if let date = cellModel?.createdon {
//            
//            let dateStr = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
//            self.lblCreate.text = dateStr
//        }else{
//            self.lblCreate.text = ""
//        }
//        
//        
//        if let date = cellModel?.msnfp_startdate {
//            
//            let dateStr = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
//            self.lblStart.text = dateStr
//        }else{
//            self.lblStart.text = ""
//        }
//        
//        if let date = cellModel?.msnfp_enddate {
//            
//            let dateStr = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
//            self.lblEnd.text = dateStr
//        }else{
//            self.lblEnd.text = ""
//        }
//
//
//        lblCompleted.text = cellModel?.msnfp_hours?.getFormattedNumber() ?? ""
//        lblPending.text = cellModel?.sjavms_totalpendinghours?.getFormattedNumber() ?? ""
    }
    
}
