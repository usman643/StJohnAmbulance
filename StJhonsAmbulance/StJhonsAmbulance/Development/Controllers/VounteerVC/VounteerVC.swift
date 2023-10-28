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
    var isLoadMoreShow : Bool = true

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnSelectGroup: UIButton!
    @IBOutlet weak var btnGroupView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchMainView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var textSearch: UITextField!
    @IBOutlet weak var btnLoadMore: UIButton!
    @IBOutlet weak var loadMoreView: UIView!
    
    
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
        self.navigationController?.navigationBar.isHidden = true
        btnSelectGroup.setTitle(ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupName() ?? "", for: .normal)
    }
    
    func decorateUI(){
        if (ProcessUtils.shared.selectedUserGroup == nil){
            if (ProcessUtils.shared.userGroupsList.count > 0 ){
                ProcessUtils.shared.selectedUserGroup = ProcessUtils.shared.volunteerGroupsList[0]
                btnSelectGroup.setTitle(ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupName() ?? "", for: .normal)
            }
        }
        lblTitle.font = UIFont.HeaderBoldFont(18)
        lblTitle.textColor = UIColor.headerGreen
//        searchView.layer.borderWidth = 1.5
        btnSelectGroup.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSelectGroup.titleLabel?.font = UIFont.HeaderBoldFont(14)
        btnSelectGroup.backgroundColor = UIColor.themePrimary
        searchMainView.isHidden = true
        btnLoadMore.layer.borderColor = UIColor.themeColorSecondry.cgColor
        btnLoadMore.layer.borderWidth = 1.0
        btnLoadMore.setTitle("Load More", for: .normal)
        btnLoadMore.setTitleColor(UIColor.themeColorSecondry, for: .normal)
        btnLoadMore.titleLabel?.font = UIFont.BoldFont(16)
        loadMoreView.isHidden = true
        let originalImage = UIImage(named: "messages-bubble-square-text")!
        let tintedImage = ProcessUtils.shared.tintImage(originalImage)
        btnMessage.setImage(tintedImage, for: .normal)
    }

    @IBAction func messageTapped(_ sender: Any) {
        ENTALDControllers.shared.showGroupMessageVC(type: .ENTALDPUSH, from: self, callBack: nil)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectGroupTapped(_ sender: Any) {
        
        showGroupsPicker()
    }
    
    
    
    @IBAction func loadMoreTapped(_ sender: Any) {
        isLoadMoreShow = false
        DispatchQueue.main.async {
            self.loadMoreView.isHidden = true
            self.tableView.reloadData()
        }
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

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if scrollView.contentOffset.y > tableView.frame.size.height {
            searchMainView.isHidden = false
        }
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
                
                self.btnSelectGroup.setTitle("\(data.sjavms_groupid?.getGroupName() ?? "")", for: .normal)
                self.getVolunteers()
            }
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      
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
        
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupId() else {return}
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_groupmembershipid,msnfp_membershiprole",
            
            ParameterKeys.expand : "msnfp_contactId($select=fullname,lastname,telephone1,emailaddress1,address1_stateorprovince,address1_line1,address1_postalcode,address1_country,address1_city,sjavms_gender),sjavms_RoleType($select=sjavms_rolecategory,sjavms_name)",
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
                        self.searchMainView.isHidden = true
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
        if ((filteredData?.count ?? 0) > 5 && isLoadMoreShow){
            loadMoreView.isHidden = false
            return 5
        }
            return filteredData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VounteerTVC", for: indexPath) as! VounteerTVC        
        let rowModel = filteredData?[indexPath.row]
 
        cell.lblName.text = rowModel?.msnfp_contactId?.fullname
        cell.lblRole.text = rowModel?.sjavms_RoleType?.sjavms_name
        cell.lblAddress.text = rowModel?.msnfp_contactId?.address1_line1
//        cell.profileImg.image = rowModel?.
        cell.btnMsg.tag = indexPath.row
        cell.btnDetail.tag = indexPath.row
        cell.btnMsg.addTarget(self, action: #selector(didTapMsg(_:)), for: .touchUpInside)
        cell.btnDetail.addTarget(self, action: #selector(didTapDetail(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        ENTALDControllers.shared.showVolunteerDetailScreen(type: .ENTALDPUSH, from: self, dataObj: filteredData?[indexPath.row]) { params, controller in
//
//        }
        
        
        
    }
    @objc private func didTapMsg(_ sender: CoreSegment) {
        let tag = sender.tag
        let rowModel = filteredData?[tag]
        
        ENTALDControllers.shared.showSignalRVC(type: .ENTALDPUSH, from: self, eventId: rowModel?.msnfp_groupmembershipid ?? "", callBack: nil)
      
    }
    @objc private func didTapDetail(_ sender: CoreSegment) {
        let tag = sender.tag
        let rowModel = filteredData?[tag]
        
        ENTALDControllers.shared.showVolunteerDetailScreen(type: .ENTALDPUSH, from: self, dataObj: rowModel) { params, controller in
            
        }
    }
    
}
