//
//  EventSummaryScreenTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 24/03/2023.
//

import UIKit

class EventSummaryScreenTVC: UITableViewCell {

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblVolunteen: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var seperaterView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func decorateUI(){
        lblVolunteen.textColor = UIColor.textBlackColor
        lblEvent.textColor = UIColor.textBlackColor
        lblStart.textColor = UIColor.textBlackColor
        lblHour.textColor = UIColor.textBlackColor
        lblStatus.textColor = UIColor.textBlackColor
        
        lblVolunteen.font = UIFont.BoldFont(11)
        lblEvent.font = UIFont.BoldFont(11)
        lblStart.font = UIFont.BoldFont(11)
        lblHour.font = UIFont.BoldFont(11)
        lblStatus.font = UIFont.BoldFont(11)
    }
    
    func setContent(rowModel : VolunteerOfEventDataModel? ,eventName : String?){
        
        
        lblVolunteen.text = rowModel?.sjavms_Volunteer?.fullname
        lblEvent.text = eventName ?? ""
        
        if let date = rowModel?.sjavms_start {
            
            let dateStr = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
            self.lblStart.text = dateStr
        }else{
            self.lblStart.text = ""
        }
        lblHour.text = rowModel?.sjavms_hours?.getFormattedNumber()
        
        if let status = ProcessUtils.shared.getStatus(code: rowModel?.msnfp_schedulestatus ?? NSNotFound) {
            lblStatus.text = status
        }
        
        
        
        
    }
    
}
