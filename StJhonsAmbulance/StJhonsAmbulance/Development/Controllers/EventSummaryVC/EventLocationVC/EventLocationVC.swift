//
//  EventLocationVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 24/03/2023.
//

import UIKit

class EventLocationVC: ENTALDBaseViewController {
    
    var eventId :String?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var lblSectionHeading: [UILabel]!
    @IBOutlet var lblTxtTitle: [UILabel]!
    @IBOutlet var allTxtFields: [UITextField]!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnStatusView: UIView!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var btnLocationType: UIButton!
    @IBOutlet weak var btnLocationTypeView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
    }

    func decorateUI(){
        
        lblTitle.font = UIFont.BoldFont(22)
        btnStatusView.layer.cornerRadius = 5
        btnLocationTypeView.layer.cornerRadius = 5
        btnStatus.titleLabel?.font = UIFont.RegularFont(13)
        btnStatus.setTitleColor(UIColor.themePrimaryWhite, for: .normal)
        btnLocationType.titleLabel?.font = UIFont.RegularFont(13)
        btnLocationType.setTitleColor(UIColor.themePrimaryWhite, for: .normal)
        
        for label in lblSectionHeading {
            
            label.font = UIFont.BoldFont(14)
            label.textColor = UIColor.themePrimaryWhite
        }
        
        for label in lblTxtTitle {
            
            label.font = UIFont.BoldFont(13 )
            label.textColor = UIColor.themePrimaryWhite
        }

        for txtfield in allTxtFields {
            
            txtfield.font = UIFont.RegularFont(12)
            txtfield.textColor = UIColor.themePrimaryWhite
        }
        
        for txtfield in allTxtFields {
            
            txtfield.font = UIFont.RegularFont(12)
            txtfield.textColor = UIColor.themePrimaryWhite
            txtfield.layer.borderWidth = 1
            txtfield.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        }
        
        
        
    }

    @IBAction func locationTypeTapped(_ sender: Any) {
    }
    
    @IBAction func statusTypeTapped(_ sender: Any) {
    }
    
}
