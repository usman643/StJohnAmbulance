//
//  EventDetailInfoFormVC.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 3/6/23.
//

import UIKit

class EventDetailInfoFormVC: ENTALDBaseViewController {

    
    @IBOutlet weak var eventDecTxtView: UITextView!
    @IBOutlet weak var schecdualInfotxtView: UITextView!
    @IBOutlet weak var otherCommentTxtView: UITextView!
    
    @IBOutlet weak var schedualInfoVu: UIView!
    
    @IBOutlet weak var btnMultiDayEvent: UIButton!
    @IBOutlet weak var txtStartDateTime: UITextField!
    @IBOutlet weak var txtEndDateTime: UITextField!
    @IBOutlet weak var txtdailyAttendies: UITextField!
    @IBOutlet weak var txtDonation: UITextField!
    
    @IBOutlet var ageRangeCheckBoxCollec: [UIButton]!
    @IBOutlet var availOnSiteCheckBoxCollec: [UIButton]!
    
    var params : [String:Any] = [:]
    var delegate : CreateEventSegmentDelegate?
    var datePicker = UIDatePicker()
    var startEventDate : String?
    var endEventDate : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if #available(iOS 13.4, *) {
            datePicker.datePickerMode = .dateAndTime
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        self.txtStartDateTime.tag = 1001
        self.txtEndDateTime.tag = 1002
        self.txtStartDateTime.inputView = datePicker
        self.txtEndDateTime.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(onChangeDate(_:)), for: .valueChanged)
    }
    
    @objc func onChangeDate(_ sender: UIDatePicker){
        
        let date = datePicker.date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-mm-dd HH:MM"
        if self.txtStartDateTime.isFirstResponder {
            //start date
            if #available(iOS 15.0, *) {
                self.txtStartDateTime.text = dateFormater.string(from: date)
                self.startEventDate = date.ISO8601Format()
            } else {
                // Fallback on earlier versions
            }
        }else if self.txtEndDateTime.isFirstResponder {
            //End date
            if #available(iOS 15.0, *) {
                self.txtEndDateTime.text = dateFormater.string(from: date)
                self.endEventDate = date.ISO8601Format()
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    @IBAction func multiDayEventBtnPressed(_ sender: UIButton) {
        self.btnMultiDayEvent.isSelected = !sender.isSelected
        self.schedualInfoVu.isHidden = !sender.isSelected
        
    }
    @IBAction func ageRangeCheckBoxPressed(_ sender: UIButton) {
        self.ageRangeCheckBoxCollec[sender.tag].isSelected = !sender.isSelected
    }
    @IBAction func availOnSiteCheckBoxPressed(_ sender: UIButton) {
        self.availOnSiteCheckBoxCollec[sender.tag].isSelected = !sender.isSelected
    }
    
    
    func setGenInfoParams(params:[String:Any]){
        self.params = params
    }
    
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        self.setDetailedParams()
    }
    
    func setDetailedParams(){
        self.params["sjavms_eventdescription"] = self.eventDecTxtView.text ?? ""
        if let date = self.startEventDate {
            self.params["sjavms_eventstartdate"] = date
        }else{self.showErrorMessage(); return}
        
        if let date = self.endEventDate {
            self.params["sjavms_eventenddate"] = date
        }else{self.showErrorMessage(); return}
        self.params["sjavms_multidayevent"] = self.btnMultiDayEvent.isSelected
        
        if self.btnMultiDayEvent.isSelected {
            if let text = self.schecdualInfotxtView.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                self.params["sjavms_eventscheduleinformation"] = text
            }else{self.showErrorMessage(); return}
        }
        if let text = self.txtdailyAttendies.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            self.params["sjavms_maxparticipants"] = text
        }else{self.showErrorMessage(); return}
        
        self.params["sjavms_donationintended"] = 100 //self.txtDonation.text ?? ""
        self.params["sjavms_othercomments"] = self.otherCommentTxtView.text ?? ""
        self.params["sjavms_13under"] = self.ageRangeCheckBoxCollec[0].isSelected
        self.params["sjavms_1417"] = self.ageRangeCheckBoxCollec[1].isSelected
        self.params["sjavms_1860"] = self.ageRangeCheckBoxCollec[2].isSelected
        self.params["sjavms_60plus"] = self.ageRangeCheckBoxCollec[3].isSelected
        self.params["sjavms_firstaidroomtent"] = self.availOnSiteCheckBoxCollec[0].isSelected
        self.params["sjavms_bathrooms"] = self.availOnSiteCheckBoxCollec[1].isSelected
        self.params["sjavms_cleandrinkingwater"] = self.availOnSiteCheckBoxCollec[2].isSelected
        self.params["sjavms_shadedareaifoutside"] = self.availOnSiteCheckBoxCollec[3].isSelected
        self.params["sjavms_parking"] = self.availOnSiteCheckBoxCollec[4].isSelected
        self.params["sjavms_willotherhealthcareagenciesbeonsite"] = self.availOnSiteCheckBoxCollec[5].isSelected
        self.params["sjavms_designatedvolunteerarea"] = self.availOnSiteCheckBoxCollec[6].isSelected
        self.params["sjavms_tableschairsseating"] = self.availOnSiteCheckBoxCollec[7].isSelected
        self.params["sjavms_foodforvolunteers"] = self.availOnSiteCheckBoxCollec[8].isSelected
        self.params["sjavms_sitemapifapplicable"] = self.availOnSiteCheckBoxCollec[9].isSelected
        self.params["sjavms_cellphonereception"] = self.availOnSiteCheckBoxCollec[10].isSelected
        self.params["sjavms_electricalpowersupply"] = self.availOnSiteCheckBoxCollec[11].isSelected
        self.params["sjavms_telephone"] = self.availOnSiteCheckBoxCollec[12].isSelected
        self.params["statuscode"] = 802280002
        
        self.delegate?.onPressSubmit(params: self.params)
    }
    
    
    func showErrorMessage(){
        ENTALDAlertView.shared.showAPIAlertWithTitle(title: "Warning", message: "Please fill Required Fields", actionTitle: .KOK, completion: {status in
            self.navigationController?.popViewController(animated: true)
        })
    }
    
}
