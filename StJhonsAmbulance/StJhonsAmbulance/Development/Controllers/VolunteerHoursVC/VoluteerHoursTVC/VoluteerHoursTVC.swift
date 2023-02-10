//
//  VoluteerHoursTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 07/02/2023.
//

import UIKit

class VoluteerHoursTVC: UITableViewCell {

    @IBOutlet weak var seperatorView: UIView!

    @IBOutlet var allLabel: [UILabel]!
    
    
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func decorateUI(){
        for label in allLabel{
            label.font = UIFont.RegularFont(11)
            label.textColor = UIColor.textBlackColor
        }
        
    }
    
    func setContent(cellModel: PendingShiftModelTwo?){
        lblEvent.text = cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
        let date = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
        let startTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
        let endTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
        
        lblDate.text = date
        lblStart.text = startTime
        lblEnd.text = endTime
        lblTotal.text = cellModel?.sjavms_hours?.getFormattedNumber()
        lblStatus.text = ProcessUtils.shared.getStatus(code: cellModel?.msnfp_schedulestatus ?? 0) 
        
    }
}

