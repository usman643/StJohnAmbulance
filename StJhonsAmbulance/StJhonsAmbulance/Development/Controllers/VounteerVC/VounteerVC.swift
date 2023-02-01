//
//  VounteerVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 26/01/2023.
//

import UIKit

class VounteerVC: ENTALDBaseViewController, UITextFieldDelegate{
    
    var volunteerData : [VolunteerModel]?
    var filteredData : [VolunteerModel]?

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
        getVolunteers()
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
    
    
    
    func getVolunteers(){
        
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() else {return}
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_groupmembershipid,msnfp_membershiprole",
            
            ParameterKeys.expand : "msnfp_contactId($select=fullname,telephone1,emailaddress1,address1_stateorprovince,address1_postalcode,address1_country,address1_city),sjavms_RoleType($select=sjavms_rolecategory,sjavms_name)",
            ParameterKeys.filter : "(statecode eq 0 and _msnfp_groupid_value eq 7079a17f-0339-ed11-9db1-0022486dfdbd) and (msnfp_contactId/statecode eq 0)",
            ParameterKeys.orderby : "msnfp_membershiprole asc"
            
        ]
        
        
        self.getVolunteerData(params: params)
        
    }
    
    fileprivate func getVolunteerData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteer(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let volunteers = response.value {
                    self.volunteerData = volunteers
                    self.filteredData = volunteers
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                    }
                }

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


extension VounteerVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volunteerData?.count ?? 0
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
        cell.lblName.text = volunteerData?[indexPath.row].msnfp_contactId?.fullname
        cell.lblRole.text = volunteerData?[indexPath.row].sjavms_RoleType?.sjavms_name
        cell.lblCity.text = volunteerData?[indexPath.row].msnfp_contactId?.address1_city
        cell.lblState.text = volunteerData?[indexPath.row].msnfp_contactId?.address1_stateorprovince
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//       
//        filteredData = searchText.isEmpty ? volunteerData : volunteerData.msnfp_contactId?.fullname.filter { (item: String) -> Bool in
//               
//                return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//            }
//            
//            tableView.reloadData()
//        }
    
}
