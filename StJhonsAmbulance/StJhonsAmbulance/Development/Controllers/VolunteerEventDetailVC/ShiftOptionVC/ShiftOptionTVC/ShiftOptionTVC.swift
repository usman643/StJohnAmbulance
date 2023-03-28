//
//  ShiftOptionTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 19/03/2023.
//

import UIKit

class ShiftOptionTVC: UITableViewCell {
    
    public var delegate: updateShiftOptionDelegate?

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblShift: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblNeeded: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var seperatorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.decorateUI()
    }
    
    func decorateUI(){
        lblShift.textColor = UIColor.textBlackColor
        lblStart.textColor = UIColor.textBlackColor
        lblEnd.textColor = UIColor.textBlackColor
        lblHours.textColor = UIColor.textBlackColor
        lblNeeded.textColor = UIColor.textBlackColor
        lblStatus.textColor = UIColor.textBlackColor
        
        lblShift.font = UIFont.RegularFont(11)
        lblStart.font = UIFont.RegularFont(11)
        lblEnd.font = UIFont.RegularFont(11)
        lblHours.font = UIFont.RegularFont(11)
        lblNeeded.font = UIFont.RegularFont(11)
        lblStatus.font = UIFont.RegularFont(11)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setContent(cellModel: VolunteerEventClickOptionModel?){
        
        
        
        lblShift.text = cellModel?.msnfp_engagementopportunityschedule ?? ""
        lblHours.text = "\(cellModel?.msnfp_hours ?? Float())"
        lblNeeded.text = "\(cellModel?.msnfp_maximum ?? NSNotFound)"
        if let status = ProcessUtils.shared.getStatus(code: cellModel?.msnfp_schedulestatus ?? NSNotFound){
            lblStatus.text = status
        }
//        lblStatus.text = "\(cellModel?.msnfp_schedulestatus ?? NSNotFound)"

        if let date = cellModel?.msnfp_effectivefrom {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            lblStart.text = start
        }else{
            lblStart.text = ""
        }
        
        if let date = cellModel?.msnfp_effectiveto {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            lblEnd.text = start
        }else{
            lblEnd.text = ""
        }
        if (cellModel?.event_selected ?? false){
            
            imgView.image = UIImage(systemName: "checkmark.square.fill")
        }else{
            imgView.image = UIImage(systemName: "square")
        }
    }
    
}
