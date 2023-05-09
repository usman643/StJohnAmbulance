//
//  PendingEventVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 28/01/2023.
//

import UIKit

protocol updatePendingEventStatusDelegate {
    
    func updateSiglePendingEventStatus(eventId:String)
    func openViewSummaryScreen(eventdata : CurrentEventsModel)
}

class PendingEventVC: ENTALDBaseViewController {
    
    var pendingApprovalData : [PendingApprovalEventsModel]?
    var pendingPublishData : [CurrentEventsModel]?
    
    var filterPendingApprovalData : [PendingApprovalEventsModel]?
    var filterPendingPublishData : [CurrentEventsModel]?
    
    var isPendingApprovalTableSearch = false
    var isPublishTableSearch = false
    
    var isPendingNameFilterApplied = false
    var isPendingLocationFilterApplied = false
    var isPendingNumberFilterApplied = false
    var isPendingDataFilterApplied = false
    
    var isPublishNameFilterApplied = false
    var isPublishLocationFilterApplied = false
    var isPublishNumberFilterApplied = false
    var isPublishDataFilterApplied = false
    

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var selectGroupView: UIView!
    @IBOutlet weak var btnSelectGroup: UIButton!
    
    @IBOutlet weak var lblPending: UILabel!
    @IBOutlet weak var btnPendingFilter: UIButton!
    @IBOutlet weak var btnApprovalFilter: UIButton!
    @IBOutlet weak var lblApproval: UILabel!
   
    
    @IBOutlet weak var pendingStackView: UIStackView!
    @IBOutlet weak var approvalStackView: UIStackView!
   
    
    @IBOutlet weak var pendingHeaderView: UIView!
    @IBOutlet weak var approvalHeaderView: UIView!
   
    
    @IBOutlet weak var pendingApprovalTableView: UITableView!
    @IBOutlet weak var pendingPublishTableView: UITableView!
  
    
    @IBOutlet weak var lblPendingName: UILabel!
    @IBOutlet weak var lblPendingLocation: UILabel!
    @IBOutlet weak var lblPendingMax: UILabel!
    @IBOutlet weak var lblPendingDate: UILabel!
    @IBOutlet weak var lblPendingStatus: UILabel!
    @IBOutlet weak var lblApprovalName: UILabel!
    @IBOutlet weak var lblApprovalLocation: UILabel!
    @IBOutlet weak var lblApprovalMax: UILabel!
    @IBOutlet weak var lblApprovalDate: UILabel!
    @IBOutlet weak var lblApprovalStatus: UILabel!
    @IBOutlet weak var lblTabTitle: UILabel!
    @IBOutlet weak var selectedTabImg: UIImageView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var textSearch: UITextField!
    @IBOutlet weak var btnSearchClose: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pendingApprovalTableView.delegate = self
        pendingApprovalTableView.dataSource = self
        pendingApprovalTableView.register(UINib(nibName: "PendingEventTVC", bundle: nil), forCellReuseIdentifier: "PendingEventTVC")
        pendingApprovalTableView.register(UINib(nibName: "EmptyEventTableCell", bundle: nil), forCellReuseIdentifier: "EmptyEventTableCell")
    
        pendingPublishTableView.delegate = self
        pendingPublishTableView.dataSource = self
        pendingPublishTableView.register(UINib(nibName: "PendingEventTVC", bundle: nil), forCellReuseIdentifier: "PendingEventTVC")
        pendingPublishTableView.register(UINib(nibName: "EmptyEventTableCell", bundle: nil), forCellReuseIdentifier: "EmptyEventTableCell")
        decorateUI()
        getPendingApproval()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.btnSelectGroup.setTitle("\(ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupName() ?? "")", for: .normal)
    }

    func decorateUI(){
        selectGroupView.layer.cornerRadius = 3
        btnSelectGroup.backgroundColor = UIColor.themePrimary
 
        pendingHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        approvalHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
     
        pendingHeaderView.layer.borderWidth = 1.5
        approvalHeaderView.layer.borderWidth = 1.5
      
        lblApproval.font = UIFont.BoldFont(20)
        lblApproval.textColor = UIColor.themePrimaryWhite
        lblPending.font = UIFont.BoldFont(20)
        lblPending.textColor = UIColor.themePrimaryWhite
        
        lblPendingName.font = UIFont.BoldFont(12)
        lblPendingLocation.font = UIFont.BoldFont(12)
        lblPendingMax.font = UIFont.BoldFont(12)
        lblPendingDate.font = UIFont.BoldFont(12)
        lblPendingStatus.font = UIFont.BoldFont(12)
        lblApprovalName.font = UIFont.BoldFont(12)
        lblApprovalLocation.font = UIFont.BoldFont(12)
        lblApprovalMax.font = UIFont.BoldFont(12)
        lblApprovalDate.font = UIFont.BoldFont(12)
        lblApprovalStatus.font = UIFont.BoldFont(12)
        lblTabTitle.font = UIFont.BoldFont(14)
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        
        btnSelectGroup.setTitleColor(UIColor.textWhiteColor, for: .normal)
        lblPendingName.textColor = UIColor.themePrimaryWhite
        lblPendingLocation.textColor = UIColor.themePrimaryWhite
        lblPendingMax.textColor = UIColor.themePrimaryWhite
        lblPendingDate.textColor = UIColor.themePrimaryWhite
        lblPendingStatus.textColor = UIColor.themePrimaryWhite
        lblApprovalName.textColor = UIColor.themePrimaryWhite
        lblApprovalLocation.textColor = UIColor.themePrimaryWhite
        lblApprovalMax.textColor = UIColor.themePrimaryWhite
        lblApprovalDate.textColor = UIColor.themePrimaryWhite
        lblApprovalStatus.textColor = UIColor.themePrimaryWhite
        lblTabTitle.textColor = UIColor.themePrimaryColor
        
        pendingApprovalTableView.clipsToBounds = false
        pendingApprovalTableView.layer.masksToBounds = false
        pendingApprovalTableView.layer.shadowColor = UIColor.lightGray.cgColor
        pendingApprovalTableView.layer.shadowOffset = CGSize(width: 0, height: 0)
        pendingApprovalTableView.layer.shadowRadius = 0.0
        pendingApprovalTableView.layer.shadowOpacity = 1.0
        
        pendingPublishTableView.clipsToBounds = false
        pendingPublishTableView.layer.masksToBounds = false
        pendingPublishTableView.layer.shadowColor = UIColor.lightGray.cgColor
        pendingPublishTableView.layer.shadowOffset = CGSize(width: 0, height: 0)
        pendingPublishTableView.layer.shadowRadius = 0.0
        pendingPublishTableView.layer.shadowOpacity = 1.0
        
        selectedTabImg.image = selectedTabImg.image?.withRenderingMode(.alwaysTemplate)
        selectedTabImg.tintColor = UIColor.themePrimaryColor
        
        searchView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        searchView.layer.borderWidth = 1.5
        searchView.isHidden = true
        textSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        
    }
    
    @IBAction func closeSearch(_ sender: Any) {
        
        self.searchView.isHidden = true
        textSearch.endEditing(true)
        textSearch.text = ""
        filterPendingPublishData = pendingPublishData
        filterPendingApprovalData = pendingApprovalData

        
        pendingPublishTableView.reloadData()
        pendingApprovalTableView.reloadData()
        
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectGroupTapped(_ sender: Any) {
        showGroupsPicker()
    }
    
    @IBAction func pendingFilterTapped(_ sender: Any) {
        
        isPublishTableSearch = false
        isPendingApprovalTableSearch = true
        self.searchView.isHidden = false
        self.textSearch.placeholder = "Filter Pending Approval"
        
        
    }
    
    @IBAction func approvalFilterTapped(_ sender: Any) {
        isPublishTableSearch = true
        isPendingApprovalTableSearch = false
        self.searchView.isHidden = false
        self.textSearch.placeholder = "Filter Pending Publish"
        
        
    }
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        present(menu!, animated: true)
    }
    // Bottom bar action
    
    @IBAction func openMessagesScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("sjavms_messages", self)
    }
    @IBAction func openVolunteerScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("sjavms_volunteers", self)
    }
    @IBAction func openEventScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("sjavms_events", self)
    }
    @IBAction func openPendingEventScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("sjavms_pendingevents", self)
    }
    @IBAction func openPendingShiftsScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("sjavms_pendingshifts", self)
    }
    @IBAction func openDashBoardScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        
    }
 
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnSearchClose.isHidden = false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (textField.text != "" && isPendingApprovalTableSearch == true ){
            
            filterPendingApprovalData  =  pendingApprovalData?.filter({
                if let name = $0.sjavms_name, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                }
                return false
            })
            DispatchQueue.main.async {
                self.pendingApprovalTableView.reloadData()
            }
            
            
        }else if(textField.text != "" && isPublishTableSearch == true ){
            
            filterPendingPublishData  =  pendingPublishData?.filter({
                if let name = $0.msnfp_engagementopportunitytitle, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                 }
               return false
             })
            
            DispatchQueue.main.async {
                self.pendingPublishTableView.reloadData()
            }
            
        }else{
            DispatchQueue.main.async {
                self.filterPendingPublishData  =  self.pendingPublishData
                self.pendingPublishTableView.reloadData()
                self.filterPendingApprovalData = self.pendingApprovalData
                self.pendingApprovalTableView.reloadData()
            }
        }
    }
    
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
    
    func showGroupsPicker(list:[LandingGroupsModel] = []){
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.groups, dataObj: ProcessUtils.shared.userGroupsList) { params, controller in
            
            if let data = params as? LandingGroupsModel {
                ProcessUtils.shared.selectedUserGroup = data
                self.getPendingApproval()
                self.btnSelectGroup.setTitle("\(data.sjavms_groupid?.getGroupName() ?? "")", for: .normal)
                
            }
        }
    }
    
    //==================  Filters  ================//
    
    
    @IBAction func pendingApprovalNameFilter(_ sender: Any) {
        if !isPendingNameFilterApplied{
            self.filterPendingApprovalData = self.filterPendingApprovalData?.sorted {
                $0.sjavms_name ?? "" < $1.sjavms_name ?? ""
            }
            isPendingNameFilterApplied = true
        }else{
            self.filterPendingApprovalData = self.filterPendingApprovalData?.sorted {
                $0.sjavms_name ?? "" > $1.sjavms_name ?? ""
            }
            isPendingNameFilterApplied = false
        }
        
        self.isPendingLocationFilterApplied = false
        self.isPendingNumberFilterApplied = false
        self.isPendingDataFilterApplied = false
        
        DispatchQueue.main.async {
            self.pendingApprovalTableView.reloadData()
        }
    }
    
    @IBAction func pendingApprovalLocationFilter(_ sender: Any) {
        if !isPendingLocationFilterApplied{
            self.filterPendingApprovalData = self.filterPendingApprovalData?.sorted {
                $0.sjavms_address1name ?? "" < $1.sjavms_address1name ?? ""
            }
            isPendingLocationFilterApplied = true
        }else{
            self.filterPendingApprovalData = self.filterPendingApprovalData?.sorted {
                $0.sjavms_address1name ?? "" > $1.sjavms_address1name ?? ""
            }
            isPendingLocationFilterApplied = false
        }
        
        self.isPendingNameFilterApplied = false
        self.isPendingNumberFilterApplied = false
        self.isPendingDataFilterApplied = false
        
        DispatchQueue.main.async {
            self.pendingApprovalTableView.reloadData()
        }
        
    }
    
    @IBAction func pendingApprovalNumFilter(_ sender: Any) {
        if !isPendingNumberFilterApplied{
            self.filterPendingApprovalData = self.filterPendingApprovalData?.sorted {
                $0.sjavms_maxvolunteers ?? 0 < $1.sjavms_maxvolunteers ?? 0
            }
            isPendingNumberFilterApplied = true
        }else{
            self.filterPendingApprovalData = self.filterPendingApprovalData?.sorted {
                $0.sjavms_maxvolunteers ?? 0 > $1.sjavms_maxvolunteers ?? 0
            }
            isPendingNumberFilterApplied = false
        }
        
        self.isPendingLocationFilterApplied = false
        self.isPendingNameFilterApplied = false
        self.isPendingDataFilterApplied = false
        
        DispatchQueue.main.async {
            self.pendingApprovalTableView.reloadData()
        }
        
    }
    
    @IBAction func pendingApprovalDateFilter(_ sender: Any) {
        if !isPendingDataFilterApplied{
            self.filterPendingApprovalData = self.filterPendingApprovalData?.sorted {
                $0.sjavms_eventstartdate ?? "" < $1.sjavms_eventstartdate ?? ""
            }
            isPendingDataFilterApplied = true
        }else{
            self.filterPendingApprovalData = self.filterPendingApprovalData?.sorted {
                $0.sjavms_eventstartdate ?? "" > $1.sjavms_eventstartdate ?? ""
            }
            isPendingDataFilterApplied = false
        }
        
        self.isPendingLocationFilterApplied = false
        self.isPendingNumberFilterApplied = false
        self.isPendingNameFilterApplied = false
        
        DispatchQueue.main.async {
            self.pendingApprovalTableView.reloadData()
        }
        
    }
    
    
    @IBAction func needPublishNameFilter(_ sender: Any) {
        if !isPublishNameFilterApplied{
            self.filterPendingPublishData = self.filterPendingPublishData?.sorted {
                $0.msnfp_engagementopportunitytitle ?? "" < $1.msnfp_engagementopportunitytitle ?? ""
            }
            isPublishNameFilterApplied = true
        }else{
            self.filterPendingPublishData = self.filterPendingPublishData?.sorted {
                $0.msnfp_engagementopportunitytitle ?? "" > $1.msnfp_engagementopportunitytitle ?? ""
            }
            isPublishNameFilterApplied = false

        }
        
        self.isPublishLocationFilterApplied = false
        self.isPublishNumberFilterApplied = false
        self.isPublishDataFilterApplied = false
        
        DispatchQueue.main.async {
            self.pendingPublishTableView.reloadData()
        }
        
    }
    
    @IBAction func needPublishLocationFilter(_ sender: Any) {
        if !isPublishLocationFilterApplied{
            self.filterPendingPublishData = self.filterPendingPublishData?.sorted {
                $0.msnfp_location ?? "" < $1.msnfp_location ?? ""
            }
            isPublishLocationFilterApplied = true
        }else{
            self.filterPendingPublishData = self.filterPendingPublishData?.sorted {
                $0.msnfp_location ?? "" > $1.msnfp_location ?? ""
            }
            isPublishLocationFilterApplied = false

        }
        
        self.isPublishDataFilterApplied = false
        self.isPublishNumberFilterApplied = false
        self.isPublishNameFilterApplied = false
        
        DispatchQueue.main.async {
            self.pendingPublishTableView.reloadData()
        }
        
    }
    
    @IBAction func needPublishNumFilter(_ sender: Any) {
        if !isPublishNumberFilterApplied{
            self.filterPendingPublishData = self.filterPendingPublishData?.sorted {
                $0.msnfp_maximum ?? 0 < $1.msnfp_maximum ?? 0
            }
            isPublishNumberFilterApplied = true
        }else{
            self.filterPendingPublishData = self.filterPendingPublishData?.sorted {
                $0.msnfp_maximum ?? 0 > $1.msnfp_maximum ?? 0
            }
            isPublishNumberFilterApplied = false

        }
        
        self.isPublishLocationFilterApplied = false
        self.isPublishDataFilterApplied = false
        self.isPublishNameFilterApplied = false
        
        DispatchQueue.main.async {
            self.pendingPublishTableView.reloadData()
        }
        
    }
    
    @IBAction func needPublishDateFilter(_ sender: Any) {
        if !isPublishDataFilterApplied{
            self.filterPendingPublishData = self.filterPendingPublishData?.sorted {
                $0.msnfp_startingdate ?? "" < $1.msnfp_startingdate ?? ""
            }
            isPublishDataFilterApplied = true
        }else{
            self.filterPendingPublishData = self.filterPendingPublishData?.sorted {
                $0.msnfp_startingdate ?? "" > $1.msnfp_startingdate ?? ""
            }
            isPublishDataFilterApplied = false
        }
        
        self.isPublishLocationFilterApplied = false
        self.isPublishNumberFilterApplied = false
        self.isPublishNameFilterApplied = false
        
        DispatchQueue.main.async {
            self.pendingPublishTableView.reloadData()
        }
        
    }
    
    
    
    
    
    
    func getPendingApproval(){
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupId() else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "sjavms_name,sjavms_address1name,sjavms_maxvolunteers,sjavms_eventstartdate,statecode,_sjavms_program_value,sjavms_eventrequestid",
            ParameterKeys.expand : "sjavms_msnfp_group_sjavms_eventrequest($filter=(msnfp_groupid eq \(groupId)))",
            ParameterKeys.filter : "(statecode eq 0 and (statuscode eq 1 or statuscode eq 802280002)) and (sjavms_msnfp_group_sjavms_eventrequest/any(o1:(o1/msnfp_groupid eq \(groupId))))",
//            ParameterKeys.orderby : "msnfp_engagementopportunityschedule asc"
        ]

        self.getPendingApprovalsData(params: params)
    }
    
    fileprivate func getPendingApprovalsData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestApprovalPendingApproval(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            self.getPendingPublish()
            switch result{
            case .success(value: let response):
                
                if let pendingData = response.value {
                    self.pendingApprovalData = pendingData
                    self.filterPendingApprovalData = pendingData
                    if (self.pendingApprovalData?.count == 0 || self.pendingApprovalData?.count == nil){
                        self.showEmptyView(tableVw: self.pendingApprovalTableView)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.pendingApprovalTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.pendingApprovalTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.pendingApprovalTableView)
                }
            
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.pendingApprovalTableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    func getPendingPublish(){
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.sjavms_groupid?.getGroupId() else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_location,msnfp_minimum,msnfp_startingdate,msnfp_endingdate,msnfp_engagementopportunitystatus,_sjavms_program_value,msnfp_engagementopportunityid,msnfp_maximum,_sjavms_contact_value,sjavms_maxparticipants",
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(msnfp_groupid eq \(groupId)))",
            ParameterKeys.filter : "(msnfp_engagementopportunitystatus eq 844060000) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/msnfp_groupid eq \(groupId))))",
//            ParameterKeys.orderby : "msnfp_engagementopportunityschedule asc"
        ]
        
        self.getPendingPublishData(params: params)
    }
    
    fileprivate func getPendingPublishData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestPendingPublishEvents(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let pendingData = response.value {
                    self.pendingPublishData = pendingData
                    self.filterPendingPublishData = pendingData
                    if (self.pendingPublishData?.count == 0 || self.pendingPublishData?.count == nil){
                        self.showEmptyView(tableVw: self.pendingPublishTableView)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.pendingPublishTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.pendingPublishTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.pendingPublishTableView)
                }
            
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.pendingPublishTableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
}

extension PendingEventVC: UITableViewDelegate,UITableViewDataSource ,UITextViewDelegate, UIActionSheetDelegate, updatePendingEventStatusDelegate{
    
    func openViewSummaryScreen(eventdata: CurrentEventsModel) {
        ENTALDControllers.shared.showEventSummaryScreen(type: .ENTALDPUSH, from: self , dataObj: eventdata) { params, controller in
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView == self.pendingPublishTableView){
            return self.filterPendingPublishData?.count ?? 0
            
        }else if (tableView == self.pendingApprovalTableView){
            return self.filterPendingApprovalData?.count ?? 0
        }

        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PendingEventTVC", for: indexPath) as! PendingEventTVC
        if indexPath.row % 2 == 0{
            cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
            cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
        }else{
            cell.mainView.backgroundColor = UIColor.viewLightColor
            cell.seperaterView.backgroundColor = UIColor.gray
        }
        
        if (tableView == self.pendingApprovalTableView){ // pending approval
            
            let rowModel = self.filterPendingApprovalData?[indexPath.row]
            
            cell.lblName.text = rowModel?.sjavms_name ?? ""
            cell.lblLocation.text = rowModel?.sjavms_address1name ?? ""
            cell.lblMax.text = "\(rowModel?.sjavms_maxvolunteers ?? 0)"
            cell.lblDate.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.sjavms_eventstartdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
            cell.lblStatus.text = rowModel?.sjavms_msnfp_group_sjavms_eventrequest?[0].getStatus()
            
            
            
        }else if (tableView == self.pendingPublishTableView){ // pending Publish
            
            let rowModel = self.filterPendingPublishData?[indexPath.row]
            cell.lblName.text = rowModel?.msnfp_engagementopportunitytitle ?? ""
            cell.lblLocation.text = rowModel?.msnfp_location ?? ""
            cell.lblMax.text = "\(rowModel?.msnfp_maximum  ?? 0)"
            cell.lblDate.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
            cell.lblStatus.text = rowModel?.getStatus()
            cell.delegate = self
            cell.eventId = rowModel?.msnfp_engagementopportunityid
            cell.delegate = self
            cell.isFromUnpublish = true
            cell.eventData = rowModel
        }
        
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (tableView == self.pendingPublishTableView){
            
            let eventdata = self.filterPendingPublishData?[indexPath.row]
            
            ENTALDControllers.shared.showEventSummaryScreen(type: .ENTALDPUSH, from: self , dataObj: eventdata) { params, controller in
                
            }
        }
        
        
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PendingEventTVC", for: indexPath) as! PendingEventTVC
//        showActionSheet(pointView: cell.mainView, arrIndex:indexPath.row)
        
        
    }
    
    func updateSiglePendingEventStatus(eventId:String) {
        
        
        
        
        
    }
   
    
    func showActionSheet(pointView:UIView, arrIndex : Int) {
        
        let alert = UIAlertController(title: "Action", message: "Please choose action", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { action in
            
            
        }))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
        }))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = pointView
            popoverController.sourceRect = pointView.bounds
        }
        
        present(alert, animated: true)
    }
    
    
}
