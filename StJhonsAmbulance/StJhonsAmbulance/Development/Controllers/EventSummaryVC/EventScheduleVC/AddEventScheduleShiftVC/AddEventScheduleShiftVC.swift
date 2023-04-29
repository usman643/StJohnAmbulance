//
//  AddEventScheduleShiftVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 29/04/2023.
//

import UIKit

class AddEventScheduleShiftVC:  ENTALDBaseViewController,UITextFieldDelegate {

    var eventId  : String?
    var datePicker = UIDatePicker()
    var startDateSelected : String?
    var endDateSelected  : String?
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var alltxtTitles: [UILabel]!
    @IBOutlet weak var txtScheduleTitle: UITextField!
    @IBOutlet weak var txtMinPaticipant: UITextField!
    @IBOutlet weak var txtMaxPaticipant: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtStartTime: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var txtEndTime: UITextField!
    
    
    @IBOutlet weak var btnCreate: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventId = self.dataModel as? String
        decorateUI()
        
    }

    func decorateUI(){
        lblTitle.font = UIFont.BoldFont(22)
        lblTitle.textColor = UIColor.themePrimaryColor
        
        txtScheduleTitle.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtMinPaticipant.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtMaxPaticipant.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtStartDate.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtStartTime.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtEndDate.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtEndTime.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        txtScheduleTitle.layer.borderWidth = 1
        txtMinPaticipant.layer.borderWidth = 1
        txtMaxPaticipant.layer.borderWidth = 1
        txtStartDate.layer.borderWidth = 1
        txtStartTime.layer.borderWidth = 1
        txtEndDate.layer.borderWidth = 1
        txtEndTime.layer.borderWidth = 1
        
        txtScheduleTitle.font = UIFont.RegularFont(14)
        txtMinPaticipant.font = UIFont.RegularFont(14)
        txtMaxPaticipant.font = UIFont.RegularFont(14)
        txtStartDate.font = UIFont.RegularFont(14)
        txtStartTime.font = UIFont.RegularFont(14)
        txtEndDate.font = UIFont.RegularFont(14)
        txtEndTime.font = UIFont.RegularFont(14)
        
        txtScheduleTitle.textColor = UIColor.textBlackColor
        txtMinPaticipant.textColor = UIColor.textBlackColor
        txtMaxPaticipant.textColor = UIColor.textBlackColor
        txtStartDate.textColor = UIColor.textBlackColor
        txtStartTime.textColor = UIColor.textBlackColor
        txtEndDate.textColor = UIColor.textBlackColor
        txtEndTime.textColor = UIColor.textBlackColor
        
        txtScheduleTitle.isUserInteractionEnabled = true
        txtMinPaticipant.isUserInteractionEnabled = true
        txtMaxPaticipant.isUserInteractionEnabled = true
        txtStartDate.isUserInteractionEnabled = true
        txtStartTime.isUserInteractionEnabled = true
        txtEndDate.isUserInteractionEnabled = true
        txtEndTime.isUserInteractionEnabled = true
        
        for label in alltxtTitles{
            label.textColor = UIColor.themePrimaryWhite
            label.font = UIFont.BoldFont(16)
        }
        
        btnCreate.titleLabel?.font = UIFont.BoldFont(16)
        btnCreate.layer.cornerRadius = btnCreate.frame.size.height/2
        btnCreate.setTitleColor(UIColor.textWhiteColor, for: .normal)
        
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
        self.datePicker.addTarget(self, action: #selector(onChangeDate(_:)), for: .valueChanged)
    
    }

    @IBAction func createShiftTapped(_ sender: Any) {
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    
    
    
    func createShift(){
        
        var params = [
            "msnfp_engagementOpportunity@odata.bind": "/msnfp_engagementopportunities(\(self.eventId))" as String,
            
            "msnfp_engagementopportunityschedule": "another shift" as String,

            "msnfp_minimum": Int(self.txtMinPaticipant.text ?? "0") ,
                "msnfp_maximum":  Int(self.txtMaxPaticipant.text ?? "0") ,
                "sjavms_therapydog": false as Bool


         ] as [String : Any]
         
         if self.startDateSelected != nil {
             params["msnfp_effectivefrom"] = (self.startDateSelected ?? "") as String
         }
         
         if self.endDateSelected != nil {
             params["msnfp_effectiveto"] = (self.endDateSelected ?? "") as String
         }
        
        
         DispatchQueue.main.async {
             LoadingView.show()
         }
 
         
         ENTALDLibraryAPI.shared.addScheduleShift(params: params) { result in
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
                     debugPrint("Shift added Successfully")
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
