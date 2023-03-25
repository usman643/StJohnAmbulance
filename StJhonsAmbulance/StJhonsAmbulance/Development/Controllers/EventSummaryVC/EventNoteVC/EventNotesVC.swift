//
//  EventNotesVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/03/2023.
//

import UIKit

class EventNotesVC: ENTALDBaseViewController {

    var eventId :String?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var lblSectionTitle: [UILabel]!
    @IBOutlet var lblTextFieldHeadings: [UILabel]!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var btnStatusView: UIView!
    @IBOutlet weak var txtParticipantNum: UITextField!
    @IBOutlet weak var txtDonationReceived: UITextField!
    @IBOutlet weak var txtSurveyComment: UITextView!
    @IBOutlet weak var txtOtherComment: UITextView!
    @IBOutlet var lblAvailables: [UILabel]!
    @IBOutlet var btnAvailables: [UIButton]!
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       decorateUI()
    }

    func decorateUI(){
        lblTitle.font = UIFont.BoldFont(22)
        btnStatusView.layer.cornerRadius = 5
        btnStatus.titleLabel?.font = UIFont.RegularFont(14)
        btnSubmit.titleLabel?.font = UIFont.BoldFont(14)
        btnStatus.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSubmit.setTitleColor(UIColor.textWhiteColor, for: .normal)
        
        txtParticipantNum.font = UIFont.RegularFont(13)
        txtParticipantNum.textColor = UIColor.themeBlackText
        txtDonationReceived.font = UIFont.RegularFont(13)
        txtDonationReceived.textColor = UIColor.themeBlackText
        txtSurveyComment.font = UIFont.RegularFont(13)
        txtSurveyComment.textColor = UIColor.themeBlackText
        txtOtherComment.font = UIFont.RegularFont(13)
        txtOtherComment.textColor = UIColor.themeBlackText
        
        txtParticipantNum.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtParticipantNum.layer.borderWidth = 1
        txtDonationReceived.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtDonationReceived.layer.borderWidth = 1
        txtSurveyComment.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtSurveyComment.layer.borderWidth = 1
        txtOtherComment.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtOtherComment.layer.borderWidth = 1
        
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        
        for label in lblSectionTitle{
            label.font = UIFont.BoldFont(14)
            label.textColor = UIColor.themePrimaryWhite
        }

        for label in lblTextFieldHeadings{
            label.font = UIFont.BoldFont(13)
            label.textColor = UIColor.themePrimaryWhite
        }
        
        for label in lblAvailables{
            label.font = UIFont.RegularFont(13)
            label.textColor = UIColor.themePrimaryWhite
        }
        
        for btn in btnAvailables{
            btn.layer.cornerRadius = 2
            
        }
        
    }
   
    
    
    @IBAction func submitTapped(_ sender: Any) {
    }
    
    
}
