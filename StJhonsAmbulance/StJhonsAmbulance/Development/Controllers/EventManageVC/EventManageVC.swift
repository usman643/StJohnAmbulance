//
//  EventManageVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 05/02/2023.
//

import UIKit

class EventManageVC: ENTALDBaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblProgramType: UILabel!
    @IBOutlet weak var btnProgram: UIButton!
    @IBOutlet weak var btnContact: UIButton!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearchClose: UIButton!
    @IBOutlet weak var btnAddVolunteer: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        decorateUI()
    }

    func decorateUI(){
        
        btnBack.tintColor = .white
        
        lblEventName.font = UIFont.BoldFont(24)
        lblDate.font = UIFont.BoldFont(18)
        lblLocation.font = UIFont.BoldFont(18)
        lblProgramType.font = UIFont.BoldFont(18)
        lblTitle.font = UIFont.BoldFont(24)
        
        lblEventName.textColor = UIColor.textWhiteColor
        lblDate.textColor = UIColor.textWhiteColor
        lblLocation.textColor = UIColor.textWhiteColor
        lblProgramType.textColor = UIColor.red
        lblTitle.textColor = UIColor.darkBlueColor
        
        btnContact.titleLabel?.font = UIFont.BoldFont(16)
        btnProgram.titleLabel?.font = UIFont.BoldFont(16)
        btnAddVolunteer.titleLabel?.font = UIFont.BoldFont(16)
        
        btnContact.setTitleColor(UIColor.darkBlueColor, for: .normal)
        btnProgram.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnAddVolunteer.setTitleColor(UIColor.darkBlueColor, for: .normal)
        
        btnProgram.backgroundColor = UIColor.red
        txtSearch.font = UIFont.RegularFont(16)
        txtSearch.textColor = UIColor.textWhiteColor
        
        btnProgram.layer.cornerRadius = 2
        btnContact.layer.cornerRadius = 2
        btnAddVolunteer.layer.cornerRadius = 2
        
        searchView.layer.cornerRadius = 2
        searchView.layer.borderColor = UIColor.textWhiteColor.cgColor
        searchView.layer.borderWidth = 1

        
        btnSearchClose.isHidden = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnSearchClose.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        btnSearchClose.isHidden = true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
//        if (textField.text != ""){
//
//           filteredData =  volunteerData?.filter({
//               if let name = $0.msnfp_contactId?.fullname, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
//                   return true
//                }
//              return false
//            })
//
//                tableView.reloadData()
//        }else{
//            filteredData = volunteerData
//            tableView.reloadData()
//        }
//
//
    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func contactTapped(_ sender: Any) {
        
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        
    }
    
    @IBAction func searchCloseTapped(_ sender: Any) {
        
    }
    
    @IBAction func addVolunteer(_ sender: Any) {
        
    }
    

}

//extension EventManageVC : UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 100
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//
//
//
//}
