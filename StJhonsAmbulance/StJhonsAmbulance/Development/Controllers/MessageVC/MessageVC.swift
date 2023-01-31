//
//  MessageVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 26/01/2023.
//

import UIKit

class MessageVC: ENTALDBaseViewController {

    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnGroup: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnText: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var emailView: UIView!

    @IBOutlet weak var lblInbox: UILabel!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "MessageTVC", bundle: nil), forCellReuseIdentifier: "MessageTVC")
        decorateUI()
        
        btnGroup.setTitle(ProcessUtils.shared.selectedUserGroup?.sjavms_RoleType?.getRoleType() ?? "", for: .normal)
        
    }

    func decorateUI(){
        
        
        btnGroup.titleLabel?.font = UIFont.BoldFont(14)
        btnCall.titleLabel?.font = UIFont.RegularFont(14)
        btnText.titleLabel?.font = UIFont.RegularFont(14)
        btnEmail.titleLabel?.font = UIFont.RegularFont(14)
        
        
        btnGroup.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnCall.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnText.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnEmail.setTitleColor(UIColor.textWhiteColor, for: .normal)
        
        
        groupView.layer.cornerRadius = 3
        callView.layer.cornerRadius = 3
        textView.layer.cornerRadius = 3
        emailView.layer.cornerRadius = 3
        
        groupView.backgroundColor = UIColor.themePrimaryColor
        callView.backgroundColor = UIColor.themePrimaryColor
        textView.backgroundColor = UIColor.themePrimaryColor
        emailView.backgroundColor = UIColor.themePrimaryColor
        
        lblInbox.font = UIFont.BoldFont(16)
        lblInbox.textColor = UIColor.themePrimaryColor
    }


    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func homeTapped(_ sender: Any) {
    }
    
    @IBAction func selectGroupTapped(_ sender: Any) {
        showGroupsPicker()
    }
    
    @IBAction func callTapped(_ sender: Any) {
    }
    
    @IBAction func textTapped(_ sender: Any) {
    }
    
    @IBAction func emailTapped(_ sender: Any) {
    }
    
    func showGroupsPicker(list:[LandingGroupsModel] = []){
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, dataObj: ProcessUtils.shared.userGroupsList) { params, controller in
            
            if let data = params as? LandingGroupsModel {
                ProcessUtils.shared.selectedUserGroup = data
                
                self.btnGroup.setTitle("\(data.msnfp_groupId?.getGroupName() ?? "")", for: .normal)
                
            }
        }
    }
    
}


extension MessageVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "MessageTVC", for: indexPath) as! MessageTVC
        
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
