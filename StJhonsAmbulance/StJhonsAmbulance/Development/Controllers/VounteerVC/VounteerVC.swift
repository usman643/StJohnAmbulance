//
//  VounteerVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 26/01/2023.
//

import UIKit

class VounteerVC: ENTALDBaseViewController, UITextFieldDelegate {
    
    var volunteerData : [VolunteerModel]?
    var filteredData : [VolunteerModel]?
    var isNameFilter : Bool = false
    var isRoleFilter : Bool = false
    

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnSelectGroup: UIButton!
    @IBOutlet weak var btnGroupView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var textSearch: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var btnSearchClose: UIButton!
    
    @IBOutlet weak var lblTabTitle: UILabel!
    @IBOutlet weak var selectedTabImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "VounteerTVC", bundle: nil), forCellReuseIdentifier: "VounteerTVC")
        textSearch.delegate = self
        decorateUI()
        getVolunteers()
        textSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btnSelectGroup.setTitle(ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupName() ?? "", for: .normal)
    }
    
    func decorateUI(){
        
        lblTitle.font = UIFont.BoldFont(20)
        lblTitle.textColor = UIColor.themePrimaryWhite
        lblName.font = UIFont.BoldFont(12)
        lblRole.font = UIFont.BoldFont(12)
        lblCity.font = UIFont.BoldFont(12)
        lblState.font = UIFont.BoldFont(12)
        lblTabTitle.font = UIFont.BoldFont(16)
        lblName.textColor = UIColor.themePrimaryWhite
        lblRole.textColor = UIColor.themePrimaryWhite
        lblCity.textColor = UIColor.themePrimaryWhite
        lblState.textColor = UIColor.themePrimaryWhite
        lblTabTitle.textColor = UIColor.themePrimaryColor
        stackView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        searchView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        stackView.layer.borderWidth = 1.5
        searchView.layer.borderWidth = 1.5
        btnSearchClose.isHidden = true
        btnSelectGroup.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        btnSelectGroup.backgroundColor = UIColor.themePrimary
        
        
        selectedTabImg.image = selectedTabImg.image?.withRenderingMode(.alwaysTemplate)
        selectedTabImg.tintColor = UIColor.themePrimaryColor
        
        
    }

    @IBAction func homeTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        filteredData = volunteerData
        tableView.reloadData()
    }
    
    
    
    @IBAction func nameFilterTapped(_ sender: Any) {
 
        if !isNameFilter{
            self.filteredData = self.filteredData?.sorted {
                $0.msnfp_contactId?.fullname ?? "" < $1.msnfp_contactId?.fullname ?? ""
            }
            isNameFilter = true
        }else{
            self.filteredData = self.filteredData?.sorted {
                $0.msnfp_contactId?.fullname ?? "" > $1.msnfp_contactId?.fullname ?? ""
            }
            isNameFilter = false
        }
        
        isRoleFilter = false

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func roleFilterTapped(_ sender: Any) {
        
        if !isRoleFilter{
            self.filteredData = self.filteredData?.sorted {
                $0.sjavms_RoleType?.sjavms_name ?? "" < $1.sjavms_RoleType?.sjavms_name ?? ""
            }
            isRoleFilter = true
        }else{
            self.filteredData = self.filteredData?.sorted {
                $0.sjavms_RoleType?.sjavms_name ?? "" > $1.sjavms_RoleType?.sjavms_name ?? ""
            }
            isRoleFilter = false
        }
        
        isNameFilter = false

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        
    }
    
    
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        present(menu!, animated: true)
        
    }
    
    
    //================ Side Menu =============//
    
    @IBAction func openMessagesScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?(1, self)
    }
    @IBAction func openVolunteerScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?(2, self)
    }
    @IBAction func openEventScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?(3, self)
    }
    @IBAction func openPendingEventScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?(4, self)
    }
    @IBAction func openPendingShiftsScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?(5, self)
    }
 
    
    
    
    @IBAction func openDashBoardScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    
    
    
    
    
    
    func showEmptyView(){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = self.tableView.frame
            self.view.addSubview(view)
        }
    }
    
    func showGroupsPicker(list:[LandingGroupsModel] = []){
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.groups, dataObj: ProcessUtils.shared.userGroupsList) { params, controller in
            
            if let data = params as? LandingGroupsModel {
                ProcessUtils.shared.selectedUserGroup = data
                
                self.btnSelectGroup.setTitle("\(data.msnfp_groupId?.getGroupName() ?? "")", for: .normal)
                self.getVolunteers()
            }
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnSearchClose.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        btnSearchClose.isHidden = true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (textField.text != ""){
            
           filteredData =  volunteerData?.filter({
               if let name = $0.msnfp_contactId?.fullname, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                   return true
                }
               if let role = $0.sjavms_RoleType?.sjavms_name, role.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                   return true
                }
               if let city = $0.msnfp_contactId?.address1_city, city.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                   return true
                }
               
               if let state = $0.msnfp_contactId?.address1_stateorprovince, state.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                   return true
                }
 
                               
              return false
            })
                
                tableView.reloadData()
        }else{
            filteredData = volunteerData
            tableView.reloadData()
        }
        
        
    }
    
    
    func getVolunteers(){
        
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() else {return}
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_groupmembershipid,msnfp_membershiprole",
            
            ParameterKeys.expand : "msnfp_contactId($select=fullname,lastname,telephone1,emailaddress1,address1_stateorprovince,address1_line1,address1_postalcode,address1_country,address1_city),sjavms_RoleType($select=sjavms_rolecategory,sjavms_name)",
            ParameterKeys.filter : "(statecode eq 0 and _msnfp_groupid_value eq \(groupId)) and (msnfp_contactId/statecode eq 0)",
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
                    if (self.volunteerData?.count == 0 || self.volunteerData?.count == nil){
                        self.showEmptyView()
                    }else{
                        
                        self.filteredData = self.filteredData?.sorted {
                            $0.msnfp_contactId?.lastname ?? "" < $1.msnfp_contactId?.lastname ?? ""
                        }
                        
                        DispatchQueue.main.async {
                            for subview in self.tableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }else{
                    self.showEmptyView()
                }

            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView()
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
}


extension VounteerVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData?.count ?? 0
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
        
        let rowModel = filteredData?[indexPath.row]
 
        cell.lblName.text = rowModel?.msnfp_contactId?.fullname
        cell.lblRole.text = rowModel?.sjavms_RoleType?.sjavms_name
        cell.lblCity.text = rowModel?.msnfp_contactId?.address1_city
        cell.lblState.text = rowModel?.msnfp_contactId?.address1_stateorprovince
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ENTALDControllers.shared.showVolunteerDetailScreen(type: .ENTALDPRESENT_POPOVER, from: self, dataObj: filteredData?[indexPath.row]) { params, controller in
            
        }
        
        
        
    }
    
}
