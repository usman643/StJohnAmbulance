//
//  VounteerVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 26/01/2023.
//

import UIKit

class VounteerVC: ENTALDBaseViewController, UITextFieldDelegate{

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnSelectGroup: UIButton!
    @IBOutlet weak var btnGroupView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var textSearch: UISearchTextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblState: UILabel!
    
    @IBOutlet weak var btnSearchClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "VounteerTVC", bundle: nil), forCellReuseIdentifier: "VounteerTVC")
        textSearch.delegate = self
        decorateUI()

        btnSelectGroup.setTitle(ProcessUtils.shared.selectedUserGroup?.sjavms_RoleType?.getRoleType() ?? "", for: .normal)
        
    }
    
    func decorateUI(){
        
        lblTitle.font = UIFont.BoldFont(20)
        lblTitle.textColor = UIColor.themePrimaryColor
        lblName.font = UIFont.BoldFont(12)
        lblRole.font = UIFont.BoldFont(12)
        lblCity.font = UIFont.BoldFont(12)
        lblState.font = UIFont.BoldFont(12)
        lblName.textColor = UIColor.themePrimaryColor
        lblRole.textColor = UIColor.themePrimaryColor
        lblCity.textColor = UIColor.themePrimaryColor
        lblState.textColor = UIColor.themePrimaryColor
        stackView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        searchView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        stackView.layer.borderWidth = 1.5
        searchView.layer.borderWidth = 1.5
        btnSearchClose.isHidden = true
        btnSelectGroup.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        
    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectGroupTapped(_ sender: Any) {
        
        showGroupsPicker()
    }
    

    @IBAction func searchCloseTapped(_ sender: Any) {
        textSearch.endEditing(true)
        textSearch.text = ""
    }
    
    func showGroupsPicker(list:[LandingGroupsModel] = []){
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, dataObj: ProcessUtils.shared.userGroupsList) { params, controller in
            
            if let data = params as? LandingGroupsModel {
                ProcessUtils.shared.selectedUserGroup = data
                
                self.btnSelectGroup.setTitle("\(data.msnfp_groupId?.getGroupName() ?? "")", for: .normal)
                
            }
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnSearchClose.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        btnSearchClose.isHidden = true
    }
    
    
    
    
}


extension VounteerVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VounteerTVC", for: indexPath) as! VounteerTVC
        if indexPath.row % 2 == 0{
            cell.mianView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
            cell.dividerView.backgroundColor = UIColor.themePrimaryColor
        }else{
            cell.mianView.backgroundColor = UIColor.viewLightColor
            cell.dividerView.backgroundColor = UIColor.gray
        }
        cell.lblName.text = "NAME"
        cell.lblRole.text = "Role"
        cell.lblCity.text = "City"
        cell.lblState.text = "State"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    

    
}