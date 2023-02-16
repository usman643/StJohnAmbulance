//
//  EventDetailVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 07/02/2023.
//

import UIKit

class EventDetailVC: ENTALDBaseViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var contactBtnImg: UIImageView!
    @IBOutlet weak var btnContact: UIButton!
    
    @IBOutlet weak var btnCheckIn: UIButton!
    @IBOutlet weak var checkInBtnImg: UIImageView!
    
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblShift: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblLocationDesc: UILabel!
    
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblDetailDesc: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var btnCancel: UIButton!
    
    var availableEvent: AvailableEventModel?
    var scheduleEvent: ScheduleModelThree?
    var pastEvent: VolunteerEventsModel?
    var latestEvent : LatestEventDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        decorateUI()
    }

    func decorateUI(){
        lblEventName.font = UIFont.BoldFont(16)
        lblLocation.font = UIFont.BoldFont(16)
        lblDetail.font = UIFont.BoldFont(16)
        
        lblEventName.textColor = UIColor.themePrimaryWhite
        lblLocation.textColor = UIColor.themePrimaryWhite
        lblDetail.textColor = UIColor.themePrimaryWhite
        
        lblDate.font = UIFont.RegularFont(14)
        lblShift.font = UIFont.RegularFont(14)
        lblStatus.font = UIFont.RegularFont(14)
        lblLocationDesc.font = UIFont.RegularFont(14)
        
        lblDate.textColor = UIColor.textGrayColor
        lblShift.textColor = UIColor.textGrayColor
        lblStatus.textColor = UIColor.textGrayColor
        lblLocationDesc.textColor = UIColor.textGrayColor
        
        btnContact.titleLabel?.font = UIFont.BoldFont(14)
        btnContact.setTitleColor(UIColor.themeWhiteText, for: .normal)
        btnContact.layer.cornerRadius = 2
        btnContact.backgroundColor = UIColor.themePrimaryWhite
        
        btnCheckIn.titleLabel?.font = UIFont.BoldFont(14)
        btnCheckIn.setTitleColor(UIColor.themeWhiteText, for: .normal)
        btnCheckIn.layer.cornerRadius = 2
        btnCheckIn.backgroundColor = UIColor.themePrimaryWhite
        
        btnCancel.titleLabel?.font = UIFont.BoldFont(14)
        btnCancel.setTitleColor(UIColor.themeWhiteText, for: .normal)
        btnCancel.layer.cornerRadius = 2
        btnCancel.backgroundColor = UIColor.themePrimaryWhite
        
        checkInBtnImg.image = checkInBtnImg.image?.withRenderingMode(.alwaysTemplate)
        checkInBtnImg.tintColor = UIColor.white

        
    }
    
    func setupData(){
        if ((availableEvent) != nil){
          
            let date = DateFormatManager.shared.formatDateStrToStr(date: availableEvent?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
                let startTime = DateFormatManager.shared.formatDateStrToStr(date: availableEvent?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")

            let endTime = DateFormatManager.shared.formatDateStrToStr(date: availableEvent?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblEventName.text = availableEvent?.msnfp_engagementopportunitytitle
            lblDate.text = "Date: \(date)"
            lblShift.text = "Shift: \(startTime) - \(endTime)"
            lblLocationDesc.text = availableEvent?.msnfp_location
            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: availableEvent?.msnfp_engagementopportunitystatus ?? 0) ?? "")"
            
            
        }else if ((scheduleEvent) != nil){
            
            let date = DateFormatManager.shared.formatDateStrToStr(date: scheduleEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: scheduleEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")

        let endTime = DateFormatManager.shared.formatDateStrToStr(date: scheduleEvent?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
        lblEventName.text = scheduleEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle
        lblDate.text = "Date: \(date)"
        lblShift.text = "Shift: \(startTime) - \(endTime)"
        lblLocationDesc.text = scheduleEvent?.sjavms_VolunteerEvent?.msnfp_location
        lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: scheduleEvent?.msnfp_schedulestatus ?? 0) ?? "")"
            
        }else if ((pastEvent) != nil){
            
            let date = DateFormatManager.shared.formatDateStrToStr(date: pastEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: pastEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
        let endTime = DateFormatManager.shared.formatDateStrToStr(date: pastEvent?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
        lblEventName.text = pastEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle
        lblDate.text = "Date: \(date)"
        lblShift.text = "Shift: \(startTime) - \(endTime)"
        lblLocationDesc.text = pastEvent?.sjavms_VolunteerEvent?.msnfp_location
        lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: pastEvent?.msnfp_schedulestatus ?? 0) ?? "")"
            
        }else if((latestEvent) != nil){
            
            let date = DateFormatManager.shared.formatDateStrToStr(date: latestEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: latestEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
        let endTime = DateFormatManager.shared.formatDateStrToStr(date: latestEvent?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
        lblEventName.text = latestEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle
        lblDate.text = "Date: \(date)"
        lblShift.text = "Shift: \(startTime) - \(endTime)"
        lblLocationDesc.text = latestEvent?.sjavms_VolunteerEvent?.msnfp_location
        lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: latestEvent?.msnfp_schedulestatus ?? 0) ?? "")"
        }
        
    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func checkInTapped(_ sender: Any) {
            ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alter", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
    }
    
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func contactTapped(_ sender: Any) {
        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alter", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
    }
}
