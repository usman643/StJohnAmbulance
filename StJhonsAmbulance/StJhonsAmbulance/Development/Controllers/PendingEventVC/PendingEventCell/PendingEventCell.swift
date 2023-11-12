//
//  PendingEventCell.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 23/07/2023.
//

import UIKit

class PendingEventCell: UITableViewCell {
    
    public var delegate: updatePendingEventStatusDelegate?
    var eventId : String?
    var eventData : CurrentEventsModel?
    var isFromUnpublish : Bool?

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var btnSelect: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        deocrateUI()
    }
    
    func deocrateUI(){
        
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.systemGray5.cgColor
        mainView.layer.shadowColor = UIColor.systemGray2.cgColor
        mainView.layer.shadowOpacity = 0.4
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 8
        mainView.layer.cornerRadius = 8
        
        lblName.font = UIFont.HeaderBlackFont(16)
        lblHour.font = UIFont.BoldFont(13)
        lblLocation.font = UIFont.BoldFont(13)
        lblStatus.font = UIFont.HeaderBoldFont(9)
        lblDate.font = UIFont.BoldFont(13)
        lbltime.font = UIFont.BoldFont(13)
        
        
        lblName.textColor = UIColor.headerGreenWhite
        lblLocation.textColor = UIColor.textDarkGreenWhite
        lblStatus.textColor = UIColor.hexString(hex: "A3A3A3")
        lblDate.textColor = UIColor.textDarkGreenWhite
        lbltime.textColor = UIColor.textDarkGreenWhite
        lblHour.textColor = UIColor.textDarkGreenWhite
      
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func changeStatusTapped(_ sender: Any) {
        if isFromUnpublish == true {
            delegate?.openViewSummaryScreen(eventdata: self.eventData!)
            return
        }
        if eventId != nil && eventId != ""{
            delegate?.updateSiglePendingEventStatus(eventId: self.eventId ?? "")
        }
        
    }
    
    
    func setCellData(rowModel : PendingShiftModelTwo?){

        lblName.text = rowModel?.sjavms_Volunteer?.fullname ?? ""
//        lblLocation.text = rowModel?.sjavms_VolunteerEvent?.msnfp_location ?? ""
        var location = "\(rowModel?.sjavms_Volunteer?.address1_postalcode ?? "") \(rowModel?.sjavms_Volunteer?.address1_city ?? "") \(rowModel?.sjavms_Volunteer?.address1_country ?? "")"
        
        lblLocation.text = rowModel?.event_name ?? ""

        lblDate.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEE, MMM d")
        
//            cell.btnStatus.setTitle(rowModel?.sjavms_msnfp_group_sjavms_eventrequest?[0].getStatus(), for: .normal)
        
//            cell.btn.setTitle("Approve Event", for: .normal)
        if (rowModel?.msnfp_schedulestatus != nil){
            lblStatus.text = ProcessUtils.shared.getStatus(code: rowModel?.msnfp_schedulestatus ?? 00000)
           
        }
        let hours = rowModel?.sjavms_hours ?? 0
        let startTime = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.event_starttime ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
        
        let endTime = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.event_endtime ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
        lbltime.text = "\(startTime) - \(endTime)"
        
        
        let floatValue: Float = hours

        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2

        if let formattedString = numberFormatter.string(from: NSNumber(value: floatValue)) {
            lblHour.text = "\(formattedString) Hours"
        }else{
            lblHour.isHidden = true
        }
        
        

        if (lblStatus.text == "Pending"){
            statusImg.image = UIImage(named: "hourglass Pending Yellow")
        }else if (lblStatus.text == "Cancelled"){
            statusImg.image = UIImage(named: "Cancelled Status")
        }else if (lblStatus.text == "Approved"){
            statusImg.image = UIImage(named: "check-double Green")
        }else{
            statusImg.isHidden = true
        }
        
        if (rowModel?.event_selected ?? false){
//            self.mainView.backgroundColor = UIColor.themeLight
            imgView.image = UIImage(systemName: "checkmark.square.fill")
        }else{
            imgView.image = UIImage(systemName: "square")
//            self.mainView.backgroundColor = UIColor.clear
        }
        
        
        
        
        
        
        
        
        
        
        
    }
    
}
