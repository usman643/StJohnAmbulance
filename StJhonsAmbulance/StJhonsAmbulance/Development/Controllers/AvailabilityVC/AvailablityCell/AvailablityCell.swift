//
//  AvailablityCell.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 21/07/2023.
//

import UIKit

class AvailablityCell: UITableViewCell {
    
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblWorkingDays: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var btnView: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

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
        
        lblDateTime.textColor = UIColor.themeSecondryWhite

        btnView.setTitleColor(UIColor.textWhiteColor, for: .normal)
        
        lblDateTime.font =  UIFont.MediumFont(11)
        btnView.titleLabel?.font = UIFont.BoldFont(13)
        
        lblEvent.textColor = UIColor.themeSecondryWhite
        lblEvent.font = UIFont.RegularFont(13)
        lblWorkingDays.textColor = UIColor.themeSecondryWhite
        lblWorkingDays.font = UIFont.RegularFont(13)

    }
    
    func setContent(cellModel: AvailablityHourModel?){
        
        var startTime : String?
        var endTime : String?
        
        lblEvent.text = cellModel?.msnfp_availabilitytitle
        
        if let date = cellModel?.msnfp_effectivefrom {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy-MM-dd")
            startTime = start
        }else{
            startTime = ""
        }
        
        if let date = cellModel?.msnfp_effectiveto {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy-MM-dd")
            endTime = start
        }else{
            endTime = ""
        }
        
        lblDateTime.text = "\(startTime ?? "") - \(endTime ?? "")"
        
        var dayStr = ""
        if let days = cellModel?.msnfp_workingdays?.components(separatedBy: ","){
            
            for singleDay in days {
                var intDay = Int(singleDay) ?? 0
                let dayEng = ProcessUtils.shared.getDay(code: intDay as Int) ?? ""
                if singleDay == days.last {
                    dayStr += "\(dayEng)"
                }else{
                    dayStr += "\(dayEng),"
                }
            }
        }
        lblWorkingDays.text = dayStr
       
    }
    
}
