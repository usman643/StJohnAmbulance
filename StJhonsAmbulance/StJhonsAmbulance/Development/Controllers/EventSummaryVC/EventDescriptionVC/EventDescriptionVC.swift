//
//  EventDescriptionVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 24/03/2023.
//

import UIKit

class EventDescriptionVC: ENTALDBaseViewController {

    var eventId :String?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var lblSectionHeading: [UILabel]!
    @IBOutlet var lblHeadings: [UILabel]!
    @IBOutlet weak var btnAdhocEvent: UIButton!
    @IBOutlet weak var lblAdhoc: UILabel!
    @IBOutlet var btnViews: [UIView]!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnSelectContact: UIButton!
    @IBOutlet weak var btnSelectProgrm: UIButton!
    @IBOutlet weak var btnSelectStatus: UIButton!
    @IBOutlet weak var txtEventName: UITextField!
    
    @IBOutlet weak var txtDonation: NSLayoutConstraint!
    @IBOutlet weak var DetailDescriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
    }


    func decorateUI(){
        lblTitle.font = UIFont.BoldFont(22)
        btnSelectContact.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSelectContact.titleLabel?.font = UIFont.BoldFont(13)
        btnSelectProgrm.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSelectProgrm.titleLabel?.font = UIFont.BoldFont(13)
        btnSelectStatus.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSelectStatus.titleLabel?.font = UIFont.BoldFont(13)
        btnSubmit.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSubmit.titleLabel?.font = UIFont.BoldFont(13)
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        
        
        
        
        for label in lblSectionHeading{
            label.textColor = UIColor.themePrimaryColor
            label.font = UIFont.BoldFont(14)
        }
        for label in lblHeadings{
            label.textColor = UIColor.themePrimaryColor
            label.font = UIFont.BoldFont(13)
        }
        
        for vw in btnViews{
            vw.layer.cornerRadius = 5
        }
        
        
        
        
    }
    
    @IBAction func submitTapped(_ sender: Any) {
    }
    
}
