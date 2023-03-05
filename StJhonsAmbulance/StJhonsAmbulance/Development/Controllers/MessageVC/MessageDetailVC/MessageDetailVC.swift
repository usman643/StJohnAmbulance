//
//  MessageDetailVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 03/03/2023.
//

import UIKit

class MessageDetailVC: ENTALDBaseViewController , UITextViewDelegate {

    
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblMessage: UILabel!

    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var txtSubject: ACFloatingTextfield!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var lblMessageError: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        decorateUI()
    }
    
    func decorateUI(){
        btnSubmit.themeColorButton()
        btnSubmit.titleLabel?.font = UIFont.BoldFont(16)
        txtSubject.disableFloatingLabel = true
        
        lblMessageError.textColor = UIColor.redPinkColor
        lblTitle.textColor = UIColor.themePrimaryWhite
        lblSubTitle.textColor = UIColor.themePrimaryWhite
        lblSubject.textColor = UIColor.themePrimaryWhite
        lblMessage.textColor = UIColor.themePrimaryWhite
        
        lblMessageError.font = UIFont.MediumFont(11)
        lblTitle.font = UIFont.BoldFont(24)
        lblSubTitle.font = UIFont.BoldFont(24)
        lblSubject.font = UIFont.BoldFont(16)
        lblMessage.font = UIFont.BoldFont(16)
        
        txtSubject.layer.borderColor = UIColor.themePrimaryColor.cgColor
        txtSubject.layer.borderWidth = 1
        
        txtMessage.layer.borderColor = UIColor.themePrimaryColor.cgColor
        txtMessage.layer.borderWidth = 1
        
        txtSubject.textColor = UIColor.textBlackColor
        txtMessage.textColor = UIColor.textBlackColor
        
        txtSubject.font = UIFont.RegularFont(14)
        txtMessage.font = UIFont.RegularFont(14)
        
        self.lblMessageError.isHidden = true
        self.lblMessageError.text = "Please Enter Message"
        self.txtSubject.placeholder = "Enter Subject Here"
        
        
        self.txtMessage.text = "Enter Subject Here"
        
    }
    
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        self.lblMessageError.isHidden = true
        
        if textView.text == "Enter Subject Here" {
            textView.text = ""
        }
    }
    
    @IBAction func submitTapped(_ sender: Any) {
       
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() else {return}
        
        guard let subject = self.txtSubject.text else {
            self.txtSubject.showErrorWithText(errorText: "Please Enter Subject")
            return
        }
        if subject == "" {
            self.txtSubject.showErrorWithText(errorText: "Please Enter Subject")
            return
        }
        
        
        guard let message = self.txtMessage.text else {
            self.lblMessageError.isHidden = false
            return
        }
        
        if (message == "" || message == "Enter Subject Here"){
            self.lblMessageError.isHidden = false
            return
        }
        
        let params : PostGroupMessageRequestModel = PostGroupMessageRequestModel(subject: subject, description: message, category: "portaleventmessage", regardingobjectid: "/msnfp_groups\(groupId)")
            
  
        
            DispatchQueue.main.async {
                LoadingView.show()
            }
            ENTALDLibraryAPI.shared.postGroupMessage(params: params) { result in
                DispatchQueue.main.async {
                    LoadingView.hide()
                }
                switch result {
                case .success(_):
                    self.callbackToController?(1, self)
                    self.dismiss(animated: true)
                    break
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
    
    
    
}
