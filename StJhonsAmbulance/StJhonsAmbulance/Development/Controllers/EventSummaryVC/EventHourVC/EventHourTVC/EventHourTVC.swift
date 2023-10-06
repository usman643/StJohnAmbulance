//
//  EventHourTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/03/2023.
//

import UIKit

class EventHourTVC: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func decorateUI(){
        lblName.textColor = UIColor.textBlackColor
        lblEvent.textColor = UIColor.textBlackColor
        lblDate.textColor = UIColor.textBlackColor
        lblHour.textColor = UIColor.textBlackColor
        lblStatus.textColor = UIColor.textBlackColor
        
        lblName.font = UIFont.BoldFont(11)
        lblEvent.font = UIFont.BoldFont(11)
        lblDate.font = UIFont.BoldFont(11)
        lblHour.font = UIFont.BoldFont(11)
        lblStatus.font = UIFont.BoldFont(11)
    }
    
    func setContent(rowModel: VolunteerOfEventDataModel? , eventName: String?){
        
        lblName.text = rowModel?.sjavms_Volunteer?.fullname ?? ""
        lblEvent.text = eventName ?? ""
        lblHour.text = rowModel?.sjavms_hours?.getFormattedNumber()
        if let statusCode = rowModel?.msnfp_schedulestatus{
            lblStatus.text = ProcessUtils.shared.getStatus(code: statusCode)
        }

        if let date = rowModel?.sjavms_start {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
            lblDate.text = start
        }else{
            lblDate.text = ""
        }
        
    }
    
    
    
}
