//
//  VolunteerDetailVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 03/03/2023.
//

import UIKit

class VolunteerDetailVC: ENTALDBaseViewController {
    
    var volunteerData : VolunteerModel?
    var isFromVolunteerScreen : Bool?
    
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNameTitle: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblGenderTitle: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblPrefferenNounTitle: UILabel!
    @IBOutlet weak var lblPrefferenNoun: UILabel!
    @IBOutlet weak var lblEmailTitle: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhoneTitle: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblAddressTitle: UILabel!
    @IBOutlet weak var lblAddresslineOne: UILabel!
    @IBOutlet weak var lblAddresslineTwo: UILabel!
    @IBOutlet weak var lblAddresslineThree: UILabel!
    @IBOutlet weak var lblAddresslineFour: UILabel!
    
    
    @IBOutlet weak var eventTimeView: UIView!
    
    @IBOutlet weak var lblEventTitle: UILabel!
    @IBOutlet weak var lblStartTitle: UILabel!
    @IBOutlet weak var lblEndTitle: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isFromVolunteerScreen ?? false{
            if let data = self.dataModel as? VolunteerModel {
                self.volunteerData = data
            }
            self.setupUI()
        }
        self.DecorateUI()
    }
    
    func DecorateUI(){
        
        lblTitle.textColor = UIColor.themePrimaryWhite
        lblNameTitle.textColor = UIColor.themePrimaryWhite
        lblName.textColor = UIColor.themePrimaryWhite
        lblGenderTitle.textColor = UIColor.themePrimaryWhite
        lblGender.textColor = UIColor.themePrimaryWhite
        lblPrefferenNounTitle.textColor = UIColor.themePrimaryWhite
        lblPrefferenNoun.textColor = UIColor.themePrimaryWhite
        lblEmailTitle.textColor = UIColor.themePrimaryWhite
        lblEmail.textColor = UIColor.themePrimaryWhite
        lblPhoneTitle.textColor = UIColor.themePrimaryWhite
        lblPhone.textColor = UIColor.themePrimaryWhite
        lblAddressTitle.textColor = UIColor.themePrimaryWhite
        lblAddresslineOne.textColor = UIColor.themePrimaryWhite
        lblAddresslineTwo.textColor = UIColor.themePrimaryWhite
        lblAddresslineThree.textColor = UIColor.themePrimaryWhite
        lblAddresslineFour.textColor = UIColor.themePrimaryWhite
        lblEventTitle.textColor = UIColor.themePrimaryWhite
        lblStartTitle.textColor = UIColor.themePrimaryWhite
        lblEndTitle.textColor = UIColor.themePrimaryWhite
        lblEvent.textColor = UIColor.themePrimaryWhite
        lblStart.textColor = UIColor.themePrimaryWhite
        lblEnd.textColor = UIColor.themePrimaryWhite
        
        lblTitle.font = UIFont.BoldFont(24)
        lblNameTitle.font = UIFont.BoldFont(16)
        lblName.font = UIFont.RegularFont(14)
        lblGenderTitle.font = UIFont.BoldFont(16)
        lblGender.font = UIFont.RegularFont(14)
        lblPrefferenNounTitle.font = UIFont.BoldFont(16)
        lblPrefferenNoun.font = UIFont.RegularFont(14)
        lblEmailTitle.font = UIFont.BoldFont(16)
        lblEmail.font = UIFont.RegularFont(14)
        lblPhoneTitle.font = UIFont.BoldFont(16)
        lblPhone.font = UIFont.RegularFont(14)
        lblAddressTitle.font = UIFont.BoldFont(16)
        lblAddresslineOne.font = UIFont.RegularFont(14)
        lblAddresslineTwo.font = UIFont.RegularFont(14)
        lblAddresslineThree.font = UIFont.RegularFont(14)
        lblAddresslineFour.font = UIFont.RegularFont(14)
        lblEventTitle.font = UIFont.BoldFont(16)
        lblStartTitle.font = UIFont.BoldFont(16)
        lblEndTitle.font = UIFont.BoldFont(16)
        lblEvent.font = UIFont.RegularFont(14)
        lblStart.font = UIFont.RegularFont(14)
        lblEnd.font = UIFont.RegularFont(14)
    }
    
    func setupUI(){
        
        
        
        lblName.text = self.volunteerData?.msnfp_contactId?.fullname ?? ""

        lblGender.text = ""
        
        lblPrefferenNoun.text = "____"
//        lblPrefferenNoun.text = self.volunteerData?.msnfp_contactId?.sjavms_preferredpronouns
        
        lblEmail.text = self.volunteerData?.msnfp_contactId?.emailaddress1 ?? ""
        
        lblPhone.text = self.volunteerData?.msnfp_contactId?.telephone1 ?? ""
        
        lblAddresslineOne.text = self.volunteerData?.msnfp_contactId?.address1_line1 ?? ""
        lblAddresslineTwo.text = self.volunteerData?.msnfp_contactId?.address1_city ?? ""
        lblAddresslineThree.text = self.volunteerData?.msnfp_contactId?.address1_stateorprovince ?? ""
        lblAddresslineFour.text = self.volunteerData?.msnfp_contactId?.address1_country ?? ""
        

        if isFromVolunteerScreen ?? false {
            
            lblEventTitle.isHidden = true
            lblStartTitle.isHidden = true
            lblEndTitle.isHidden = true
            lblEvent.isHidden = true
            lblStart.isHidden = true
            lblEnd.isHidden = true
            
        }
    }
    @IBAction func closeTapped(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
}