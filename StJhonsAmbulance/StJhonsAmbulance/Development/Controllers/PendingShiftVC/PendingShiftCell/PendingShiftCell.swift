//
//  PendingShiftCell.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 23/07/2023.
//

import UIKit

class PendingShiftCell: UITableViewCell {
    public var delegate: updatePendingShiftStatusDelegate?
    
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblShift: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var btnStatus: UIButton!

    
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
        
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.systemGray5.cgColor
        mainView.layer.shadowColor = UIColor.systemGray2.cgColor
        mainView.layer.shadowOpacity = 0.4
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 8
        
        mainView.layer.cornerRadius = 8
        statusView.layer.cornerRadius = 8
        statusView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        statusView.backgroundColor = UIColor.themePrimary
        btnStatus.setTitleColor(UIColor.textLightGrayColor, for: .normal)
        lblDate.textColor = UIColor.themeSecondryWhite
        lblDate.font =  UIFont.MediumFont(11)
        btnStatus.titleLabel?.font = UIFont.BoldFont(13)
        
        
        
        lblName.font = UIFont.BoldFont(16)
        lblEvent.font = UIFont.BoldFont(13)
        lblHours.font = UIFont.BoldFont(13)
        lblShift.font = UIFont.BoldFont(13)
        
        
        lblName.textColor = UIColor.themePrimaryWhite
        lblEvent.textColor = UIColor.headerGreen
        lblDate.textColor = UIColor.headerGreen
        lblHours.textColor = UIColor.headerGreen
        lblShift.textColor = UIColor.headerGreen
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
            btnStatus.setTitle(ProcessUtils.shared.getStatus(code: rowModel?.msnfp_schedulestatus ?? 00000), for: .normal)
           
        }
    
        if (rowModel?.event_selected ?? false){
            self.mainView.backgroundColor = UIColor.themeLight
//            imgView.image = UIImage(systemName: "checkmark.square.fill")
        }else{
//            imgView.image = UIImage(systemName: "square")
            self.mainView.backgroundColor = UIColor.clear
        }
        
        
        
//        self.eventId = rowModel?.msnfp_participationscheduleid
    }
    
    
    @IBAction func updateStatusTapped(_ sender: Any) {
        
        delegate?.updateSiglePendingShiftStatus(eventId: self.eventId ?? "")
        
    }
    
}
