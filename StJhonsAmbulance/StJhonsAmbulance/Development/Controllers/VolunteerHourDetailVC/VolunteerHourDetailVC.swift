//
//  VolunteerHourDetailVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 08/04/2023.
//

import UIKit

class VolunteerHourDetailVC: ENTALDBaseViewController, UISearchTextFieldDelegate {

    var shiftData :  PendingShiftModelTwo?
    var datePicker = UIDatePicker()
    var startDateSelected : String?
    var startTimeSelected : String?
    var endDateSelected  : String?
    var endTimeSelected : String?
    
    @IBOutlet var allLabelTitles: [UILabel]!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblShift: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtstartDate: UITextField!
    @IBOutlet weak var txtstartTime: UITextField!
    @IBOutlet weak var txtendDate: UITextField!
    @IBOutlet weak var txtendTime: UITextField!
    @IBOutlet weak var txteventName: UITextField!
    @IBOutlet weak var txtprogramName: UITextField!
    @IBOutlet weak var txteventRequirement: UITextField!
    @IBOutlet weak var txtlocation: UITextField!
    @IBOutlet weak var txtstreetOne: UITextField!
    @IBOutlet weak var txtstreetTwo: UITextField!
    @IBOutlet weak var txtstreetThree: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.shiftData = self.dataModel as? PendingShiftModelTwo
        
        if #available(iOS 13.4, *) {
            datePicker.datePickerMode = .dateAndTime
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        self.txtstartDate.tag = 1001
        self.txtstartTime.tag = 1002
        self.txtendDate.tag = 1003
        self.txtendTime.tag = 1004
        self.txtstartDate.inputView = datePicker
        self.txtendDate.inputView = datePicker
        self.txtstartTime.inputView = datePicker
        self.txtendTime.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(onChangeDate(_:)), for: .valueChanged)

        decorateUI()
        setupData()
    }
    
    @objc func onChangeDate(_ sender: UIDatePicker){
        
        let date = datePicker.date
        let dateFormater = DateFormatter()
        let timeFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy/MM/dd"
        timeFormater.dateFormat = "HH:mm"

        if (self.txtstartDate.isFirstResponder || self.txtstartTime.isFirstResponder ){
            //start date
            
            if #available(iOS 15.0, *) {
                self.txtstartDate.text = dateFormater.string(from: date)
                self.txtstartTime.text = timeFormater.string(from: date)
                self.startDateSelected = date.ISO8601Format()
            } else {
                // Fallback on earlier versions
            }
        }else if (self.txtendDate.isFirstResponder || self.txtendTime.isFirstResponder){
            //End date
           
            if #available(iOS 15.0, *) {
                self.txtendDate.text = dateFormater.string(from: date)
                self.txtendTime.text = timeFormater.string(from: date)
                self.endDateSelected = date.ISO8601Format()
            } else {
                // Fallback on earlier versions
            }
        }
    }

    func decorateUI(){
        lblTitle.font = UIFont.BoldFont(22)
        lblTitle.textColor = UIColor.themePrimaryColor
        
        for label in allLabelTitles{
            label.font = UIFont.BoldFont(14)
            label.textColor = UIColor.textBlackColor
        }
        
        txtstartDate.font = UIFont.RegularFont(13)
        txtstartTime.font = UIFont.RegularFont(13)
        txtendDate.font = UIFont.RegularFont(13)
        txtendTime.font = UIFont.RegularFont(13)
        txteventName.font = UIFont.RegularFont(13)
        txtprogramName.font = UIFont.RegularFont(13)
        txteventRequirement.font = UIFont.RegularFont(13)
        txtlocation.font = UIFont.RegularFont(13)
        txtstreetOne.font = UIFont.RegularFont(13)
        txtstreetTwo.font = UIFont.RegularFont(13)
        txtstreetThree.font = UIFont.RegularFont(13)
        
        txtstartDate.textColor = UIColor.themePrimaryWhite
        txtstartTime.textColor = UIColor.themePrimaryWhite
        txtendDate.textColor = UIColor.themePrimaryWhite
        txtendTime.textColor = UIColor.themePrimaryWhite
        txteventName.textColor = UIColor.themePrimaryWhite
        txtprogramName.textColor = UIColor.themePrimaryWhite
        txteventRequirement.textColor = UIColor.themePrimaryWhite
        txtlocation.textColor = UIColor.themePrimaryWhite
        txtstreetOne.textColor = UIColor.themePrimaryWhite
        txtstreetTwo.textColor = UIColor.themePrimaryWhite
        txtstreetThree.textColor = UIColor.themePrimaryWhite
        
//        txtstartDate.isUserInteractionEnabled = false
//        txtstartTime.isUserInteractionEnabled = false
//        txtendDate.isUserInteractionEnabled = false
//        txtendTime.isUserInteractionEnabled = false
        txteventName.isUserInteractionEnabled = false
        txtprogramName.isUserInteractionEnabled = false
        txteventRequirement.isUserInteractionEnabled = false
        txtlocation.isUserInteractionEnabled = false
        txtstreetOne.isUserInteractionEnabled = false
        txtstreetTwo.isUserInteractionEnabled = false
        txtstreetThree.isUserInteractionEnabled = false
        
        txtstartDate.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtstartTime.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtendDate.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtendTime.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        txtstartDate.layer.borderWidth = 1
        txtstartTime.layer.borderWidth = 1
        txtendDate.layer.borderWidth = 1
        txtendTime.layer.borderWidth = 1
        
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        btnSubmit.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSubmit.titleLabel?.font = UIFont.BoldFont(14)
        
        lblEvent.textColor = UIColor.themePrimaryWhite
        lblShift.textColor = UIColor.themePrimaryWhite
        
        lblEvent.font = UIFont.RegularFont(13)
        lblShift.font = UIFont.RegularFont(13)
    }
    
    func setupData(){
        
        lblEvent.text = shiftData?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "Not Found"
        lblShift.text = shiftData?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "Not Found"
        
        if let date = shiftData?.sjavms_start {
            let startDate = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "HH:mm")
            
            txtstartDate.text = startDate
            txtstartTime.text = startTime
        }else{
            txtstartDate.text = "Not Found"
            txtstartTime.text = "Not Found"
        }
        
        if let date = shiftData?.sjavms_end {
            let startDate = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "HH:mm")
            
            txtendDate.text = startDate
            txtendTime.text = startTime
        }else{
            txtendDate.text = "Not Found"
            txtendTime.text = "Not Found"
        }
        
        txteventName.text = self.shiftData?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "Not Found"
        txtprogramName.text = self.shiftData?.event_name ?? "Not Found"
        txteventRequirement.text = self.shiftData?.sjavms_VolunteerEvent?.sjavms_eventrequirements ?? "Not Found"
        txtlocation.text = self.shiftData?.sjavms_VolunteerEvent?.msnfp_location ?? "Not Found"
        txtstreetOne.text = self.shiftData?.sjavms_VolunteerEvent?.msnfp_street1 ?? "Not Found"
        txtstreetTwo.text = self.shiftData?.sjavms_VolunteerEvent?.msnfp_street2 ?? "Not Found"
        txtstreetThree.text = self.shiftData?.sjavms_VolunteerEvent?.msnfp_street3 ?? "Not Found"
        
        
    }


    @IBAction func backTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitTapped(_ sender: Any) {

        self.updateShiftTime(params: [
            "sjavms_start": self.startDateSelected as? String ?? self.shiftData?.sjavms_start,
            "sjavms_end": self.endDateSelected as? String ?? self.shiftData?.sjavms_end
        ])
    }

    
    fileprivate func updateShiftTime(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
//        let eventId = self.eventData?.msnfp_engagementopportunityid ?? "Not Found"
        
        ENTALDLibraryAPI.shared.updateVolunteerShift(shiftId: self.shiftData?.msnfp_participationscheduleid ?? "", params: params) { result in
            
            
            switch result{
            case .success(value: let response):
                DispatchQueue.main.async {
                    LoadingView.hide()
                }
                if response.value != nil {
                    
                }
            case .error(let error, let errorResponse):
                DispatchQueue.main.async {
                    LoadingView.hide()
                }
                if error == .patchSuccess {
                    self.callbackToController?(1, self)
                    self.navigationController?.popViewController(animated: true)
                    break
                    
                }else{
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
    
    
}
