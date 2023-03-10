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
    
    
    @IBOutlet weak var txtStartDateTime: UITextField!
    @IBOutlet weak var txtEndDateTime: UITextField!
    @IBOutlet weak var txtdailyAttendies: UITextField!
    @IBOutlet weak var txtDonation: UITextField!
    
    @IBOutlet var ageRangeCheckBoxCollec: [UIButton]!
    @IBOutlet var availOnSiteCheckBoxCollec: [UIButton]!
    @IBAction func multiDayEventBtnPressed(_ sender: UIButton) {
        
        
    }
    @IBAction func ageRangeCheckBoxPressed(_ sender: UIButton) {
        self.ageRangeCheckBoxCollec[sender.tag].isSelected = !sender.isSelected
    }
    @IBAction func availOnSiteCheckBoxPressed(_ sender: UIButton) {
        self.availOnSiteCheckBoxCollec[sender.tag].isSelected = !sender.isSelected
    }
    
}
