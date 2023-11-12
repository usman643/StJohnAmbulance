//
//  PendingApprovalScheduleVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 12/11/2023.
//

import UIKit

class PendingApprovalScheduleVC:  ENTALDBaseViewController {

        var eventData : PendingApprovalEventsModel?
        var scheduleEvent : [VolunteerEventClickOptionModel]?
        var summaryData : pendingApprovalSummaryModel?
        var selectedStatus : String?
        var datePicker = UIDatePicker()
        var startDateSelected : String?
        var endDateSelected  : String?
        
        @IBOutlet weak var lblTitle: UILabel!
        @IBOutlet var lblSectionTitle: [UILabel]!
        @IBOutlet var lblTextFieldTitles: [UILabel]!
        @IBOutlet weak var btnStatus: UIButton!
        @IBOutlet weak var btnStatusView: UIView!
        @IBOutlet var allTxtField: [UITextField]!
        @IBOutlet var lblAge: [UILabel]!
        @IBOutlet weak var lblMultidayEvent: UILabel!
        @IBOutlet weak var btnMultiday: UIButton!
        @IBOutlet weak var btnAgeOne: UIButton!
        @IBOutlet weak var btnAgeTwo: UIButton!
        @IBOutlet weak var btnAgeThree: UIButton!
        @IBOutlet weak var btnAgeFour: UIButton!
        
        @IBOutlet weak var txtStartDate: UITextField!
        @IBOutlet weak var txtStartTime: UITextField!
        @IBOutlet weak var txtEndDate: UITextField!
        @IBOutlet weak var txtEndTime: UITextField!
        @IBOutlet weak var minVolunteer: UITextField!
        @IBOutlet weak var maxDailyAttendance: UITextField!
        @IBOutlet weak var maxVolunteer: UITextField!
            
        @IBOutlet weak var btnSubmit: UIButton!
        override func viewDidLoad() {
            super.viewDidLoad()
            getSummaryData()
//            getEventOptions()
            decorateUI()
          
        }

        
        func decorateUI(){
            lblTitle.font = UIFont.BoldFont(22)
            btnStatusView.layer.cornerRadius = 5
            btnStatus.setTitleColor(UIColor.textWhiteColor, for: .normal)
            btnStatus.titleLabel?.font = UIFont.BoldFont(14)
            btnMultiday.layer.cornerRadius = 3
            lblMultidayEvent.font = UIFont.BoldFont(12)
            lblMultidayEvent.textColor = UIColor.themePrimaryWhite
            
            minVolunteer.keyboardType = .decimalPad
            maxVolunteer.keyboardType = .decimalPad
            maxDailyAttendance.keyboardType = .decimalPad
            
            for label in lblAge{
                label.font = UIFont.BoldFont(14)
                label.textColor = UIColor.themePrimaryWhite
            }
            
            for label in lblSectionTitle{
                label.font = UIFont.BoldFont(14)
                label.textColor = UIColor.themePrimaryWhite
            }
            for label in lblTextFieldTitles{
                label.font = UIFont.BoldFont(13)
                label.textColor = UIColor.themePrimaryWhite
            }

            for txtField in allTxtField{
                txtField.font = UIFont.BoldFont(13)
                txtField.layer.cornerRadius = 4
                txtField.textColor = UIColor.themePrimaryWhite
                txtField.layer.borderWidth = 1
                txtField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: txtField.frame.height))
                txtField.leftViewMode = .always
                txtField.rightViewMode = .always
            }
            
            btnAgeOne.layer.cornerRadius = 3
            btnAgeOne.backgroundColor = UIColor.viewLightGrayColor
            
            
            
            btnAgeTwo.layer.cornerRadius = 3
            btnAgeTwo.backgroundColor = UIColor.viewLightGrayColor
            
            btnAgeThree.layer.cornerRadius = 3
            btnAgeThree.backgroundColor = UIColor.viewLightGrayColor
            
            btnAgeFour.layer.cornerRadius = 3
            btnAgeFour.backgroundColor = UIColor.viewLightGrayColor
            if #available(iOS 13.4, *) {
                datePicker.datePickerMode = .dateAndTime
                datePicker.preferredDatePickerStyle = .wheels
            } else {
                // Fallback on earlier versions
            }
            self.txtStartDate.inputView = datePicker
            self.txtStartTime.inputView = datePicker
            self.txtEndDate.inputView = datePicker
            self.txtEndTime.inputView = datePicker
            datePicker.addTarget(self, action: #selector(onChangeDate(_:)), for: .valueChanged)
            
        }
        
        func setupData(){
            
            if let date = self.summaryData?.sjavms_eventstartdate {
                let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
                txtStartDate.text = start
            }else{
                txtStartDate.text = ""
            }
            
            if let date = self.summaryData?.sjavms_eventstartdate {
                let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
                txtStartTime.text = start
            }else{
                txtStartTime.text = ""
            }
            
            if let date = self.summaryData?.sjavms_eventenddate{
                let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
                txtEndDate.text = start
            }else{
                txtEndDate.text = ""
            }
            
            if let date = self.summaryData?.sjavms_eventenddate {
                let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
                txtEndTime.text = start
            }else{
                txtEndTime.text = ""
            }
//            minVolunteer.text = "\(self.summaryData?.msnfp_minimum ?? 0)"
            maxDailyAttendance.text = "\(self.summaryData?.sjavms_maxparticipants ?? 0)"
            maxVolunteer.text = "\(self.summaryData?.sjavms_maxvolunteers ?? 0)"
            self.setBtn(btn: btnMultiday, value: self.summaryData?.sjavms_multidayevent ?? false)
            self.setBtn(btn: btnAgeOne, value: self.summaryData?.sjavms_13under ?? false)
            self.setBtn(btn: btnAgeTwo, value: self.summaryData?.sjavms_1417 ?? false)
            self.setBtn(btn: btnAgeThree, value: self.summaryData?.sjavms_1860 ?? false)
            self.setBtn(btn: btnAgeFour, value: self.summaryData?.sjavms_60plus ?? false)
            
            let status = ProcessUtils.shared.eventStatusArr[self.summaryData?.statuscode ?? 0]
            self.btnStatus.setTitle(status, for: .normal)
            
        }
        
        @objc func onChangeDate(_ sender: UIDatePicker){
            
            
            let date = datePicker.date
            let dateFormater = DateFormatter()
            let timeFormater = DateFormatter()
            dateFormater.dateFormat = "yyyy/MM/dd"
            timeFormater.dateFormat = "hh:mm a"

            if (self.txtStartDate.isFirstResponder || self.txtStartTime.isFirstResponder ){
                //start date
                
                if #available(iOS 15.0, *) {
                    
                    self.txtStartDate.text = dateFormater.string(from: date)
                    self.txtStartTime.text = timeFormater.string(from: date)
                    self.startDateSelected = date.ISO8601Format()
                } else {
                    // Fallback on earlier versions
                }
            }else if (self.txtEndDate.isFirstResponder || self.txtEndTime.isFirstResponder){
                //End date
               
                if #available(iOS 15.0, *) {
                    
                    self.txtEndDate.text = dateFormater.string(from: date)
                    self.txtEndTime.text = timeFormater.string(from: date)
                    self.endDateSelected = date.ISO8601Format()
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
        @IBAction func eventStatusUpdate(_ sender: Any) {
            self.showGroupsPicker()
        }
        
        func setBtn(btn: UIButton , value : Bool){
            
            if (value == true) {
                btn.setImage(UIImage(named: "ic_check"), for: .normal)
                btn.backgroundColor = UIColor.clear
                btn.isSelected = true
            }else{
                btn.setImage(UIImage(named: ""), for: .normal)
                btn.backgroundColor = UIColor.viewLightGrayColor
                btn.isSelected = false
            }
            
        }
        
        
        @IBAction func multiDayEventTapped(_ sender: UIButton) {
            if self.btnMultiday.isSelected == false  {
                self.btnMultiday.setImage(UIImage(named: "ic_check"), for: .normal)
                self.btnMultiday.backgroundColor = UIColor.clear
            }else{
                self.btnMultiday.setImage(UIImage(named: ""), for: .normal)
                self.btnMultiday.backgroundColor = UIColor.viewLightGrayColor
            }
            
            self.btnMultiday.isSelected = !sender.isSelected
        }
        
        
        @IBAction func age1Tapped(_ sender: UIButton) {
            
            if self.btnAgeOne.isSelected == false  {
                self.btnAgeOne.setImage(UIImage(named: "ic_check"), for: .normal)
                self.btnAgeOne.backgroundColor = UIColor.clear
            }else{
                self.btnAgeOne.setImage(UIImage(named: ""), for: .normal)
                self.btnAgeOne.backgroundColor = UIColor.viewLightGrayColor
            }
            
            self.btnAgeOne.isSelected = !sender.isSelected
            
        }

        @IBAction func age2Tapped(_ sender: UIButton) {
            if self.btnAgeTwo.isSelected == false  {
                self.btnAgeTwo.setImage(UIImage(named: "ic_check"), for: .normal)
                self.btnAgeTwo.backgroundColor = UIColor.clear
            }else{
                self.btnAgeTwo.setImage(UIImage(named: ""), for: .normal)
                self.btnAgeTwo.backgroundColor = UIColor.viewLightGrayColor
            }
            
            self.btnAgeTwo.isSelected = !sender.isSelected
        }
        
        @IBAction func age3Tapped(_ sender: UIButton) {
            if self.btnAgeThree.isSelected == false  {
                self.btnAgeThree.setImage(UIImage(named: "ic_check"), for: .normal)
                self.btnAgeThree.backgroundColor = UIColor.clear
            }else{
                self.btnAgeThree.setImage(UIImage(named: ""), for: .normal)
                self.btnAgeThree.backgroundColor = UIColor.viewLightGrayColor
            }
            
            self.btnAgeThree.isSelected = !sender.isSelected
        }
        
        @IBAction func age4Tapped(_ sender: UIButton) {
            if self.btnAgeFour.isSelected == false  {
                self.btnAgeFour.setImage(UIImage(named: "ic_check"), for: .normal)
                self.btnAgeFour.backgroundColor = UIColor.clear
            }else{
                self.btnAgeFour.setImage(UIImage(named: ""), for: .normal)
                self.btnAgeFour.backgroundColor = UIColor.viewLightGrayColor
            }
            
            self.btnAgeFour.isSelected = !sender.isSelected
        }
        
        
        @IBAction func submitTapped(_ sender: Any) {
            updatedata()
        }
        func showEmptyView(tableVw : UITableView){
            DispatchQueue.main.async {
                let view = EmptyView.instanceFromNib()
                view.frame = tableVw.frame
                tableVw.addSubview(view)
            }
        }

        fileprivate func getSummaryData(){
            
            guard let eventId = self.eventData?.sjavms_eventrequestid else {return}
                let params : [String:Any] = [
                    ParameterKeys.select : "sjavms_name,sjavms_address1name,sjavms_maxvolunteers,sjavms_eventstartdate,statecode,_sjavms_program_value,sjavms_eventrequestid,sjavms_willotherhealthcareagenciesbeonsite,sjavms_volunteerrequeststatus,sjavms_telephone,sjavms_tableschairsseating,statuscode,sjavms_sitemapifapplicable,sjavms_shadedareaifoutside,sja_securityonsite,sjavms_phone,sjavms_parking,sjavms_othercomments,sjavms_organization,sjavms_multidayevent,sjavms_maxparticipants,sjavms_lastname,sja_iceonsite,sjavms_foodforvolunteers,sjavms_firstname,sjavms_firstaidroomtent,sjavms_eventenddate,sjavms_eventdescription,sjavms_eventaudience,sjavms_email,sjavms_electricalpowersupply,sjavms_donationintended,sjavms_designatedvolunteerarea,sjavms_declinereason,sjavms_declinedetails,_sjavms_council_value,sjavms_coordinatorphone,sjavms_coordinatorlastname,sjavms_coordinatorfirstname,sjavms_coordinatoremail,sjavms_cleandrinkingwater,sjavms_cellphonereception,_sjavms_branch_value,sjavms_bathrooms,sjavms_address1stateprovince,sjavms_address1zippostalcode,sjavms_address1line3,sjavms_address1line2,sjavms_address1line1,sjavms_address1city,_sjavms_account_value,sjavms_13under,sjavms_1417,sjavms_1860,sjavms_60plus",
                    ParameterKeys.filter : "(sjavms_eventrequestid eq \(eventId))",
                    ]
                    self.getSummary(params:params)
        }
        
        fileprivate func getSummary(params: [String:Any]){
            DispatchQueue.main.async {
                LoadingView.show()
            }
            
            ENTALDLibraryAPI.shared.getPendingApprovalEventSummary(params: params){ result in
                DispatchQueue.main.async {
                    LoadingView.hide()
                }
                switch result{
                case .success(value: let response):
                    
                    if let summaryData = response.value {
                        if summaryData.count > 0{
                            self.summaryData = summaryData[0]
                            DispatchQueue.main.async {
                                self.setupData()
                            }
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
        
        func showGroupsPicker(){
            
            ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.eventStatus, dataObj: ProcessUtils.shared.eventStatusArr) { params, controller in
                self.selectedStatus  = params as? String
                var status = ProcessUtils.shared.eventStatusArr.filter({$0.value == params as? String}).first?.key
                self.updateEventStatus(statusValue : status ?? NSNotFound)
            }
        }
        
        func updateEventStatus(statusValue:Int){
            
                DispatchQueue.main.async {
                    LoadingView.show()
                }
                var params:[String:Any] = [:]
                
                
                    params["msnfp_engagementopportunitystatus"] = statusValue as Int
                    
            ENTALDLibraryAPI.shared.updateEventStatus(eventid: self.eventData?.sjavms_eventrequestid ?? "", params: params){ result in
                    DispatchQueue.main.async {
                        LoadingView.hide()
                    }
                    switch result{
                    case .success(value: _):
                        break
                    case .error(let error, let errorResponse):
                        if error == .patchSuccess {
                            ENTALDAlertView.shared.showContactAlertWithTitle(title: "Event Status Update Successfully", message: "", actionTitle: .KOK, completion: { status in })
                            self.btnStatus.setTitle(self.selectedStatus, for: .normal)
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
        
        fileprivate func updatedata(){

           var params = [
            
            
               
            "msnfp_multipledays" : btnMultiday.isSelected ? true : false as Bool,
            "sjavms_13under" : btnAgeOne.isSelected ? true : false as Bool,
            "sjavms_1417" : btnAgeTwo.isSelected ? true : false as Bool,
            "sjavms_1860" : btnAgeThree.isSelected ? true : false as Bool,
            "sjavms_60plus" : btnAgeFour.isSelected ? true : false as Bool,
            "msnfp_minimum" : Int(minVolunteer.text ?? "") ?? 0 as Int,
            "sjavms_maxvolunteers" : Int(maxVolunteer.text ?? "") ?? 0 as Int,
            "sjavms_maxparticipants" : Int(maxDailyAttendance.text ?? "") ?? 0 as Int,

            ] as [String : Any]
            
            if self.startDateSelected != nil {
                params["msnfp_startingdate"] = (self.startDateSelected ?? "") as String
            }
            
            if self.endDateSelected != nil {
                params["msnfp_locationtype"] = (self.endDateSelected ?? "") as String
            }
            
            DispatchQueue.main.async {
                LoadingView.show()
            }
            let eventId = self.eventData?.sjavms_eventrequestid ?? ""
            
            ENTALDLibraryAPI.shared.updateSummaryData(eventId: eventId, params: params) { result in
                DispatchQueue.main.async {
                    LoadingView.hide()
                }
                
                switch result{
                case .success(value: _):
                    DispatchQueue.main.async {
                        LoadingView.hide()
                    }
                    
                case .error(let error, let errorResponse):
                    if error == .patchSuccess {
                        debugPrint("Successfully Updated")
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

