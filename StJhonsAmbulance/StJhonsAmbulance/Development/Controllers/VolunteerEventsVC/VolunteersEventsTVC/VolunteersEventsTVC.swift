//
//  VolunteersEventsTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 18/07/2023.
//

import UIKit

class VolunteersEventsTVC: UITableViewCell {
    
    var cellType = ""
    public var delegate: VolunteerEventDetailDelegate?
    var indx :Int?
    var eventId :String?
    var availableEventdata : AvailableEventModel?
    var scheduleEventdata : ScheduleModelThree?

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblProgram: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var btnDetail: UIButton!
    
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
        
        lblDateTime.textColor = UIColor.themeBlackText
        
        btnView.setTitleColor(UIColor.themeBlackText, for: .normal)
        lblTitle.textColor = UIColor.themePrimaryWhite
        lblProgram.textColor = UIColor.themeBlackText
        
        lblLocation.textColor = UIColor.themeBlackText
        
        lblDateTime.font =  UIFont.BoldFont(12)
        btnView.titleLabel?.font = UIFont.BoldFont(13)
        lblTitle.font =  UIFont.BoldFont(18)
        lblProgram.font =  UIFont.BoldFont(13)
        
        lblLocation.font =  UIFont.BoldFont(12)
        
    }
    
    func setupContent(cellModel: CurrentEventsModel?){
        
//        let startTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEE, MMM d, hh:mm a")
//
//        let endTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
//
//        lblDateTime.text = "\(startTime) - \(endTime)"
//
//        lblTitle.text = "\(cellModel?.msnfp_engagementopportunitytitle ?? "")"
//
//        lblTotalHours.text = "Needed: \(cellModel?.msnfp_minimum ?? 0)"
//        lblLocation.text = "Location: \(cellModel?.msnfp_location ?? "")"
//
//        if (cellModel?.msnfp_engagementopportunitystatus) != nil {
//            btnDetail.setTitle("\(cellModel?.getStatus() ?? "")" , for: .normal)
//
//        }

    }
    
    
    func setContent(cellModel: VolunteerEventsModel?){
        
        let startTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEE, MMM d, hh:mm a")
        
        let endTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
       
        lblDateTime.text = "\(startTime) - \(endTime)"
        
        self.lblTitle.text = cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "..."
        self.lblLocation.text = cellModel?.sjavms_VolunteerEvent?.msnfp_location ?? "..."
        
//        if let statusStr = cellModel?.msnfp_schedulestatus{
//
//            self.btnDetail.setTitle("\(ProcessUtils.shared.getStatus(code:statusStr) ?? "")", for: .normal)
//        }else{
//            btnView.isHidden = true
//        }
        
//        lblProgram.text = cellModel?.sjavms_msnfp_engagementopportunity_msnfp_group?[0].sjaProgram ?? "Program"
        lblProgram.text = cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "Program"

    }
    
    func setContent(cellModel: ScheduleModelThree?,  indx : Int){
        
        self.cellType = "schedule"
        let startTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEE, MMM d, hh:mm a")
        
        let endTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
       
        lblDateTime.text = "\(startTime) - \(endTime)"
        
        self.lblTitle.text = cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "..."
        self.lblLocation.text = cellModel?.sjavms_VolunteerEvent?.msnfp_location ?? "..."
        
//        if let statusStr = cellModel?.msnfp_schedulestatus{
//
//            self.btnDetail.setTitle("\(ProcessUtils.shared.getStatus(code:statusStr) ?? "")", for: .normal)
//        }else{
//            btnView.isHidden = true
//        }
        self.scheduleEventdata = cellModel
        
//        lblProgram.text = cellModel?.sjavms_msnfp_engagementopportunity_msnfp_group?[0].sjaProgram ?? "..."
        lblProgram.text = cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "..."
  
    }
    
    func setContent(cellModel: AvailableEventModel?, indx : Int){
        
        self.cellType = "available"
        let startTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEE, MMM d, hh:mm a")
        
        let endTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
       
        lblDateTime.text = "\(startTime) - \(endTime)"
        
        self.lblTitle.text = cellModel?.msnfp_engagementopportunitytitle ?? "..."
        self.lblLocation.text = cellModel?.msnfp_location ?? "..."
        
//        self.btnView.isHidden = true
        
//        self.btnDetail.setTitle("View", for: .normal)
        

        self.availableEventdata = cellModel
        
        lblProgram.text = cellModel?.sjavms_msnfp_engagementopportunity_msnfp_group?[0].sjaProgram ?? "..."
        
//        self.eventId = cellModel?.msnfp_engagementopportunityid ?? ""
//
//        self.lblEvent.text = cellModel?.msnfp_engagementopportunitytitle ?? ""
//        self.lblLocation.text = cellModel?.msnfp_location ?? ""
////        self.lblAction.text = ProcessUtils.shared.getStatus(code: cellModel?.msnfp_engagementopportunitystatus ?? 0)
//        self.lblAction.text = ""
//        btnAction.setImage(UIImage(named: "ic_plus"), for: .normal)
//        self.cellType = "available"
//
//        if (cellModel?.msnfp_startingdate != "" && cellModel?.msnfp_startingdate != nil ){
//            let date = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
//            let startTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
//
//            lblDate.text = date
//            lblStart.text = startTime
//        }else{
//            lblDate.text = ""
//            lblStart.text = ""
//        }
//
//        if (cellModel?.msnfp_endingdate != "" && cellModel?.msnfp_endingdate != nil ){
//            let endTime = DateFormatManager.shared.formatDateStrToStr(date: cellModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
//            lblEnd.text = endTime
//        }else{
//            lblEnd.text = ""
//        }
    }
    
    
    @IBAction func actionBtnTapped(_ sender: Any) {
        
        if (self.cellType == "schedule" ){

            delegate?.openScheduleEventDetailScreen(rowModel: self.scheduleEventdata )
        }else if (self.cellType == "available"){
            
            delegate?.openAvailableEventDetailScreen(rowModel: self.availableEventdata)
        }
    }
    
    
    
    
    
    
}
