//
//  EventScheduleTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/03/2023.
//

import UIKit

class EventScheduleTVC: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var lblMin: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var seperaterView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func decorateUI(){
        lblTitle.textColor = UIColor.textBlackColor
        lblStart.textColor = UIColor.textBlackColor
        lblEnd.textColor = UIColor.textBlackColor
        lblEvent.textColor = UIColor.textBlackColor
        lblHour.textColor = UIColor.textBlackColor
        lblMin.textColor = UIColor.textBlackColor
        lblMax.textColor = UIColor.textBlackColor
        lblStatus.textColor = UIColor.textBlackColor
        
        lblTitle.font = UIFont.RegularFont(10)
        lblStart.font = UIFont.RegularFont(10)
        lblEnd.font = UIFont.RegularFont(10)
        lblEvent.font = UIFont.RegularFont(10)
        lblHour.font = UIFont.RegularFont(10)
        lblMin.font = UIFont.RegularFont(10)
        lblMax.font = UIFont.RegularFont(10)
        lblStatus.font = UIFont.RegularFont(10)
    }
    
    
    
    func setContent(cellModel: VolunteerEventClickOptionModel?){
        
        lblEvent.text = cellModel?.msnfp_engagementopportunityschedule ?? ""
        lblTitle.text = "\(cellModel?.msnfp_number ?? NSNotFound)"

        
        lblHour.text = "\(cellModel?.msnfp_hours ?? Float())"
        lblMin.text = "\(cellModel?.msnfp_minimum ?? NSNotFound)"
        lblMax.text = "\(cellModel?.msnfp_maximum ?? NSNotFound)"
        lblStatus.text = "\(cellModel?.statecode ?? NSNotFound)"

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
        
        
        
        
        
    }
    
}
