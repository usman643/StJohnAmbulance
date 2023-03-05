//
//  MessagedetailAlertVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 03/03/2023.
//

import UIKit

class MessagedetailAlertVC: ENTALDBaseViewController {

    var messageData : MessageModel?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblSubjectTitle: UILabel!
    @IBOutlet weak var lblMessageTitle: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let message = self.dataModel as? MessageModel {
            self.messageData = message
            self.lblSubject.text =  self.messageData?.subject ?? ""
            self.lblMessage.text =  self.messageData?.description ?? ""
        }
        
       decorateUI()
    }

    func decorateUI(){
        
        lblTitle.textColor = UIColor.themePrimaryWhite
        lblSubTitle.textColor = UIColor.themePrimaryWhite
        lblSubject.textColor = UIColor.themePrimaryWhite
        lblMessage.textColor = UIColor.themePrimaryWhite
        lblSubjectTitle.textColor = UIColor.themePrimaryWhite
        lblMessageTitle.textColor = UIColor.themePrimaryWhite
        
        lblTitle.font = UIFont.BoldFont(24)
        lblSubTitle.font = UIFont.BoldFont(24)
        lblSubject.font = UIFont.RegularFont(14)
        lblMessage.font = UIFont.RegularFont(14)
        lblSubjectTitle.font = UIFont.BoldFont(16)
        lblMessageTitle.font = UIFont.BoldFont(16)

    }
    
    func setupData(){
        
        lblSubject.text = self.messageData?.subject ?? ""
        lblMessage.text = self.messageData?.description ?? ""
        
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }

}
