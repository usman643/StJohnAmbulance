//
//  NewGeneralFormVC.swift
//  StJhonsAmbulance
//
//  Created by Ali on 06/03/2023.
//

import UIKit

class GeneralInfoFormVC: ENTALDBaseViewController {
    
    @IBOutlet weak var generalInfoFormHeaderLbl: UILabel!
    @IBOutlet weak var appInfoSecTitleLbl: UIView!
    @IBOutlet weak var provinceLbl: UILabel!
    @IBOutlet weak var branchLbl: UILabel!
    @IBOutlet weak var typeOfServiceLbl: UILabel!
    @IBOutlet weak var eventOrganizerSecTitleLbl: UILabel!
    @IBOutlet weak var contactFirstNameLbl: UILabel!
    @IBOutlet weak var contactLastNameLbl: UILabel!
    @IBOutlet weak var eventNameLbl: UILabel!
    @IBOutlet weak var organizerNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var primaryPhoneLbl: UILabel!
    @IBOutlet weak var eventLocationAddressSecTitleLbl: UILabel!
    @IBOutlet weak var eventLocationNameLbl: UILabel!
    @IBOutlet weak var street1Lbl: UILabel!
    @IBOutlet weak var street2Lbl: UILabel!
    @IBOutlet weak var street3Lbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var provinceTextLbl: UILabel!
    @IBOutlet weak var postalCodeLbl: UILabel!

    @IBOutlet weak var contactFirstNameTF: UITextField!
    @IBOutlet weak var contactLastNameTF: UITextField!
    @IBOutlet weak var eventNameTF: UITextField!
    @IBOutlet weak var organizerNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var primaryPhoneTF: UITextField!
    @IBOutlet weak var eventLocationNameTF: UITextField!
    @IBOutlet weak var street1TF: UITextField!
    @IBOutlet weak var street2TF: UITextField!
    @IBOutlet weak var street3TF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var provinceTF: UITextField!
    @IBOutlet weak var postalCodeTF: UITextField!

    @IBOutlet weak var provinceBtn: UIButton!
    @IBOutlet weak var branchBtn: UIButton!
    @IBOutlet weak var typeOfServiceBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!

    @IBAction func provinceBtnPRessed(_ sender: UIButton) {
    }
    @IBAction func branchBtnPressed(_ sender: UIButton) {
    }
    @IBAction func typeOfServiceBtnPressed(_ sender: UIButton) {
    }
    @IBAction func nextBtnPressed(_ sender: UIButton) {
    }
}
