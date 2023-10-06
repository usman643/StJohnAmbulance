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
        
        lblTitle.font = UIFont.BoldFont(10)
        lblStart.font = UIFont.BoldFont(10)
        lblEnd.font = UIFont.BoldFont(10)
        lblEvent.font = UIFont.BoldFont(10)
        lblHour.font = UIFont.BoldFont(10)
        lblMin.font = UIFont.BoldFont(10)
        lblMax.font = UIFont.BoldFont(10)
        lblStatus.font = UIFont.BoldFont(10)
    }
    
    
    
    func setContent(cellModel: VolunteerEventClickOptionModel?){
        
        lblEvent.text = cellModel?.msnfp_engagementopportunityschedule ?? ""
        
        let tileEventArr = cellModel?.msnfp_engagementopportunityschedule?.components(separatedBy: " - ")
        if ((tileEventArr?.count ?? 0) > 1){
            lblEvent.text = "\(tileEventArr?[1] ?? "Not Found")"
            lblTitle.text = "\(tileEventArr?[0] ?? "Not Found")"
        }
        
        

        
        lblHour.text = "\(cellModel?.msnfp_hours ?? Float())"
        lblMin.text = "\(cellModel?.msnfp_minimum ?? 0)"
        lblMax.text = "\(cellModel?.msnfp_maximum ?? 0)"
        lblStatus.text = "\(cellModel?.statecode ?? 0)"

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
