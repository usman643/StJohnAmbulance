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
        mainView.layer.borderColor = UIColor.systemGray3.cgColor
        mainView.layer.shadowColor = UIColor.systemGray4.cgColor
        mainView.layer.shadowOpacity = 0.5
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 6
        
        mainView.layer.cornerRadius = 16
        statusView.layer.cornerRadius = 16
        statusView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        btnStatus.setTitleColor(UIColor.textWhiteColor, for: .normal)
        lblDate.textColor = UIColor.themeSecondryWhite
        lblDate.font =  UIFont.MediumFont(11)
        btnStatus.titleLabel?.font = UIFont.BoldFont(13)
        
        
        
        lblName.font = UIFont.BoldFont(14)
        lblEvent.font = UIFont.RegularFont(13)
        lblHours.font = UIFont.RegularFont(13)
        lblShift.font = UIFont.RegularFont(13)
        
        
        lblName.textColor = UIColor.themePrimaryWhite
        lblName.textColor = UIColor.themePrimaryWhite
        lblEvent.textColor = UIColor.themePrimaryWhite
        lblDate.textColor = UIColor.themePrimaryWhite
        lblHours.textColor = UIColor.themePrimaryWhite
        lblShift.textColor = UIColor.themePrimaryWhite
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
