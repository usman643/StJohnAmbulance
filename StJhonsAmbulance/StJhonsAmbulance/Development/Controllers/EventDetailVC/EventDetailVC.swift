//
//  EventDetailVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 07/02/2023.
//

import UIKit

class EventDetailVC: ENTALDBaseViewController {
    
    var contactInfo : [ContactDataModel]?
    var eventId = ""
    
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
    @IBOutlet weak var checkInbtnView: UIView!
    
    @IBOutlet weak var contactbtnView: UIView!
    var availableEvent: AvailableEventModel?
    var scheduleEvent: ScheduleModelThree?
    var pastEvent: VolunteerEventsModel?
    var latestEvent : LatestEventDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        decorateUI()
        registerCell()
    }
    
    func registerCell(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "EventDetailCVC", bundle: nil), forCellWithReuseIdentifier: "EventDetailCVC")
        
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
        btnContact.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnContact.layer.cornerRadius = 2
        btnContact.backgroundColor = UIColor.themeSecondry
        
        btnCheckIn.titleLabel?.font = UIFont.BoldFont(14)
        btnCheckIn.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnCheckIn.layer.cornerRadius = 2
        btnCheckIn.backgroundColor = UIColor.themeSecondry
        
        btnCancel.titleLabel?.font = UIFont.BoldFont(14)
        btnCancel.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnCancel.layer.cornerRadius = 2
        btnCancel.backgroundColor = UIColor.themeSecondry
        
        checkInBtnImg.image = checkInBtnImg.image?.withRenderingMode(.alwaysTemplate)
        checkInBtnImg.tintColor = UIColor.white
        if ( self.latestEvent?.sjavms_checkedin == true ){
            btnCheckIn.isEnabled = false
            btnCheckIn.setTitle("Checked In", for: .normal)
            checkInBtnImg.isHidden = true
            checkInBtnImg.isHidden = false
        }else{
            btnCheckIn.isEnabled = true
            btnCheckIn.setTitle("Check In", for: .normal)
            checkInBtnImg.isHidden = true
            checkInBtnImg.isHidden = false
            checkInBtnImg.tintColor = UIColor.white
        }
        
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
            self.eventId = availableEvent?.msnfp_engagementopportunityid ?? ""
            
        }else if ((scheduleEvent) != nil){
            
            let date = DateFormatManager.shared.formatDateStrToStr(date: scheduleEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: scheduleEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: scheduleEvent?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblEventName.text = scheduleEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle
            lblDate.text = "Date: \(date)"
            lblShift.text = "Shift: \(startTime) - \(endTime)"
            lblLocationDesc.text = scheduleEvent?.sjavms_VolunteerEvent?.msnfp_location
            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: scheduleEvent?.msnfp_schedulestatus ?? 0) ?? "")"
            self.eventId = scheduleEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunityid ?? ""
            
            
            
            
            
            
        }else if ((pastEvent) != nil){
            self.checkInbtnView.isHidden = true
            self.contactbtnView.isHidden = true
            let date = DateFormatManager.shared.formatDateStrToStr(date: pastEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: pastEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: pastEvent?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblEventName.text = pastEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle
            lblDate.text = "Date: \(date)"
            lblShift.text = "Shift: \(startTime) - \(endTime)"
            lblLocationDesc.text = pastEvent?.sjavms_VolunteerEvent?.msnfp_location
            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: pastEvent?.msnfp_schedulestatus ?? 0) ?? "")"
            self.eventId = pastEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunityid ?? ""
        }else if((latestEvent) != nil){
            
            let date = DateFormatManager.shared.formatDateStrToStr(date: latestEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: latestEvent?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: latestEvent?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            lblEventName.text = latestEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle
            lblDate.text = "Date: \(date)"
            lblShift.text = "Shift: \(startTime) - \(endTime)"
            lblLocationDesc.text = latestEvent?.sjavms_VolunteerEvent?.msnfp_location
            lblStatus.text = "Status: \(ProcessUtils.shared.getStatus(code: latestEvent?.msnfp_schedulestatus ?? 0) ?? "")"
            self.eventId = latestEvent?.sjavms_VolunteerEvent?.msnfp_engagementopportunityid ?? ""
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
        if (self.latestEvent?.sjavms_checkedin == false){
            updateCheckInData()
        }
        //            ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alter", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
        
        
        
    }
    
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func contactTapped(_ sender: Any) {
        self.getContact()
        //        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alter", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
    }
    
    fileprivate func updateCheckInData(){
        let params = [
            "sjavms_checkedin": true
        ]
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        
        
        ENTALDLibraryAPI.shared.updateVolunteerCheckIn(particitionId: self.latestEvent?.msnfp_participationscheduleid ?? "", params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                if let pastEvent = response.value {
                    
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                //                self.showEmptyView(tableVw: self.tableView)
                DispatchQueue.main.async {
                    //                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    func getContact(){
        
        
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle",
            ParameterKeys.expand : "sjavms_Contact($select=emailaddress1,address1_country,address1_line1,address1_line3,address1_city,lastname,firstname,fullname,address1_postalcode,telephone1,address1_stateorprovince,address1_line2)",
            ParameterKeys.filter : "(msnfp_engagementopportunityid eq \(self.eventId)) and (sjavms_Contact/contactid ne null)"
        ]
        
        self.getContactData(params: params)
        
    }
    
    fileprivate func getContactData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestContactInfo(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let contactData = response.value {
                    self.contactInfo = contactData
                    var messageStr = ""
                    if let str = self.contactInfo?[0].sjavms_Contact?.fullname{
                        messageStr += "Name: \(str)\n"
                    }
                    if let str = self.contactInfo?[0].sjavms_Contact?.telephone1{
                        messageStr += "Phone: \(str)\n"
                    }
                    if let str = self.contactInfo?[0].sjavms_Contact?.emailaddress1{
                        messageStr += "Email: \(str)\n"
                    }
                    
                    DispatchQueue.main.async {
                        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Organizer Contact Infomation", message: messageStr, actionTitle: .KOK, completion: {status in })
                    }
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

extension EventDetailVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventDetailCVC", for: indexPath) as! EventDetailCVC
        
        
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //
    //        let width =  (collectionView.frame.size.width / 2) - 8
    //
    //
    //        return collectionView.
    //    }
    
    
}
