//
//  PendingShiftTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 27/01/2023.
//

import UIKit

class PendingShiftTVC: UITableViewCell {

    public var delegate: updatePendingShiftStatusDelegate?
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblShift: UILabel!
    @IBOutlet weak var lblAction: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var eventId:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func decorateUI(){
        
        lblName.font = UIFont.RegularFont(10)
        lblEvent.font = UIFont.RegularFont(10)
        lblDate.font = UIFont.RegularFont(10)
        lblHours.font = UIFont.RegularFont(10)
        lblShift.font = UIFont.RegularFont(8)
        lblAction.font = UIFont.RegularFont(10)
        
        lblName.textColor = UIColor.textBlackColor
        lblName.textColor = UIColor.textBlackColor
        lblEvent.textColor = UIColor.textBlackColor
        lblDate.textColor = UIColor.textBlackColor
        lblHours.textColor = UIColor.textBlackColor
        lblShift.textColor = UIColor.textBlackColor
        lblAction.textColor = UIColor.textBlackColor
    }
    
    func setCellData(rowModel : PendingShiftModelTwo?){
        lblName.text = rowModel?.sjavms_Volunteer?.fullname
        let hours = rowModel?.sjavms_hours
        let hoursStr = NSString(format: "%.2f", hours ?? Float())
        let startTime = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.event_starttime ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
        
        let endTime = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.event_endtime ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
        
        lblHours.text = String ("\(hoursStr)")
        lblEvent.text = rowModel?.event_name
        lblDate.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
        lblShift.text = "\(startTime) - \(endTime)"
        
        if (rowModel?.msnfp_schedulestatus != nil){
            lblAction.text = ProcessUtils.shared.getStatus(code: rowModel?.msnfp_schedulestatus ?? 00000)
        }
    
        if (rowModel?.event_selected ?? false){
            
            imgView.image = UIImage(systemName: "checkmark.square.fill")
        }else{
            imgView.image = UIImage(systemName: "square")
        }
        self.eventId = rowModel?.msnfp_participationscheduleid
    }
    
    
    @IBAction func updateStatusTapped(_ sender: Any) {
        
        delegate?.updateSiglePendingShiftStatus(eventId: self.eventId ?? "")
        
    }
    
}
