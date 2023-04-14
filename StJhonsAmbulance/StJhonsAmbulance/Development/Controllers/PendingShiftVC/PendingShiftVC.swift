//
//  PendingShiftVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 27/01/2023.
//

import UIKit

protocol updatePendingShiftStatusDelegate {
    
    func updateSiglePendingShiftStatus(eventId:String)
}

class PendingShiftVC: ENTALDBaseViewController,updatePendingShiftStatusDelegate {

    
    var pendingShiftData : [PendingShiftModelTwo]?
    var pendingShiftDataOne : [PendingShiftModelOne]?
    var pendingShiftDataThree : [PendingShiftModelThree]?
    
    var filterPendingShiftData : [PendingShiftModelTwo]?
    
    var selectedShifts : [PendingShiftModelTwo] = []
    
    var isNamefilterApplied:Bool = false
    var isDatefilterApplied:Bool = false
    var isEventfilterApplied:Bool = false
    
    let groupId : String = ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() ?? ""
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnSelectGroup: UIButton!
    @IBOutlet weak var btnGroupView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var btnSeclectAction: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblShift: UILabel!
    @IBOutlet weak var lblAction: UILabel!
    
    @IBOutlet weak var lblTabTitle: UILabel!
    
    @IBOutlet weak var selectedTabImg: UIImageView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var textSearch: UITextField!
    @IBOutlet weak var btnSearchClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PendingShiftTVC", bundle: nil), forCellReuseIdentifier: "PendingShiftTVC")
        tableView.register(UINib(nibName: "EmptyEventTableCell", bundle: nil), forCellReuseIdentifier: "EmptyEventTableCell")
    
        decorateUI()
        getPendingShift()
        getPendingShiftThree()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.btnSelectGroup.setTitle("\(ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupName() ?? "")", for: .normal)
    }
    
    func decorateUI(){
        
        lblTitle.font = UIFont.BoldFont(20)
        lblSubTitle.font = UIFont.BoldFont(16)
        lblName.font = UIFont.BoldFont(12)
        lblName.font = UIFont.BoldFont(12)
        lblEvent.font = UIFont.BoldFont(12)
        lblDate.font = UIFont.BoldFont(12)
        lblHours.font = UIFont.BoldFont(12)
        lblShift.font = UIFont.BoldFont(12)
        lblAction.font = UIFont.BoldFont(12)
        lblTabTitle.font = UIFont.BoldFont(14)
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        btnSelectGroup.backgroundColor = UIColor.themePrimary
        btnSelectGroup.setTitleColor(UIColor.textWhiteColor, for: .normal)
        
        btnSeclectAction.titleLabel?.font = UIFont.BoldFont(14)
        btnSeclectAction.backgroundColor = UIColor.themePrimary
        btnSeclectAction.setTitleColor(UIColor.textWhiteColor, for: .normal)
 
        lblTitle.textColor = UIColor.themePrimaryWhite
        lblSubTitle.textColor = UIColor.themePrimaryWhite
        lblName.textColor = UIColor.themePrimaryWhite
        lblName.textColor = UIColor.themePrimaryWhite
        lblEvent.textColor = UIColor.themePrimaryWhite
        lblDate.textColor = UIColor.themePrimaryWhite
        lblHours.textColor = UIColor.themePrimaryWhite
        lblShift.textColor = UIColor.themePrimaryWhite
        lblAction.textColor = UIColor.themePrimaryWhite
        lblTabTitle.textColor = UIColor.themePrimaryColor
        
        tableHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        tableHeaderView.layer.borderWidth = 1.5
        
        btnGroupView.layer.cornerRadius = 3
        
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
        filterPendingShiftData = pendingShiftData

        tableView.reloadData()
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectGroupTapped(_ sender: Any) {
        showGroupsPicker()
    }
    
    @IBAction func homeTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
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
    
    @IBAction func filterTapped(_ sender: Any) {
        self.filterPendingShiftData = self.filterPendingShiftData?.reversed()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    
    @IBAction func selectActionTapped(_ sender: Any) {
        
        ENTALDControllers.shared.showPendingShiftStatusUpdatePicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, dataObj: ProcessUtils.shared.getPendingShiftStatus()) { params, controller in
            
            let selectedEvents = self.pendingShiftData?.filter( {$0.event_selected == true})
            
            for i in (0..<(selectedEvents?.count ?? 0 )){
                
                if let data = params{
                    let apiParams = [
                        "msnfp_schedulestatus": data as! Int
                    ]
                    
                    self.updateStatusData(eventId: selectedEvents?[i].msnfp_participationscheduleid ?? "", params: apiParams as [String : Any])
                }
            }
            self.getPendingShift()
        }
        
    }
    func filterByName(){
        if !isNamefilterApplied{
            self.filterPendingShiftData = self.filterPendingShiftData?.sorted {
                $0.sjavms_Volunteer?.fullname ?? "" < $1.sjavms_Volunteer?.fullname ?? ""
            }
            isNamefilterApplied = true
        }else{
            self.filterPendingShiftData = self.filterPendingShiftData?.sorted {
                $0.sjavms_Volunteer?.fullname ?? "" > $1.sjavms_Volunteer?.fullname ?? ""
            }
            isNamefilterApplied = false
        }
        
        isDatefilterApplied = false
        isEventfilterApplied = false
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func nameFilterTapped(_ sender: Any) {
        
        self.searchView.isHidden = false
        self.textSearch.placeholder = "Filter PendingShifts"

    }
    
    
    @IBAction func eventFilterTapped(_ sender: Any) {

        if !isEventfilterApplied{
            self.filterPendingShiftData = self.filterPendingShiftData?.sorted {
                $0.event_name ?? "" < $1.event_name ?? ""
            }
            isEventfilterApplied = true
        }else{
            self.filterPendingShiftData = self.filterPendingShiftData?.sorted {
                $0.event_name ?? "" > $1.event_name ?? ""
            }
            isEventfilterApplied = false
        }
        
        isDatefilterApplied = false
        isNamefilterApplied = false
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func dateFilterTapped(_ sender: Any) {
        
        
        if !isDatefilterApplied{
            self.filterPendingShiftData = self.filterPendingShiftData?.sorted {
                $0.event_starttime ?? "" < $1.event_starttime ?? ""
            }
            isDatefilterApplied = true
        }else{
            self.filterPendingShiftData = self.filterPendingShiftData?.sorted {
                $0.event_starttime ?? "" > $1.event_starttime ?? ""
            }
            isDatefilterApplied = false
        }
        
        isEventfilterApplied = false
        isNamefilterApplied = false
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    
    }
    
    func updateSiglePendingShiftStatus(eventId:String) {
        ENTALDControllers.shared.showPendingShiftStatusUpdatePicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, dataObj: ProcessUtils.shared.getPendingShiftStatus()) { params, controller in
            
//            let selectedEvents = self.pendingShiftData?.filter( {$0.event_selected == true})
        
                if let data = params {
                    let apiParams = [
                        "msnfp_schedulestatus": data as! Int
                    ]
                    self.updateStatusData(eventId: eventId , params: apiParams )
                }
            self.getPendingShift()
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
                self.getPendingShift()
                self.getPendingShiftThree()
                self.btnSelectGroup.setTitle("\(data.msnfp_groupId?.getGroupName() ?? "")", for: .normal)
                
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnSearchClose.isHidden = false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (textField.text != "" ){
            
            filterPendingShiftData  =  pendingShiftData?.filter({
                if let name = $0.event_name, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                }
                return false
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }else{
            DispatchQueue.main.async {
                self.filterPendingShiftData = self.pendingShiftData
                self.tableView.reloadData()
               
            }
        }
        
    }
    

    
    // ======================== API ====================== //
    
    
    fileprivate func updateStatusData(eventId: String, params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }

        ENTALDLibraryAPI.shared.requestPendingShiftUpdate(eventId: eventId, params: params){ result in
        DispatchQueue.main.async {
            LoadingView.hide()
        }
        switch result{
        case .success(value: let _):
             break
        case .error(let error, let errorResponse):
            if error == .patchSuccess {
//                ENTALDAlertView.shared.showContactAlertWithTitle(title: "Profile Updated Successfully", message: "", actionTitle: .KOK, completion: { status in })
            }else{
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
    
//
    }
    
    
    func getPendingShift(){
        
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_engagementopportunitystatus,msnfp_needsreviewedparticipants,msnfp_minimum,msnfp_maximum,_sjavms_group_value,msnfp_endingdate,msnfp_cancelledparticipants,msnfp_appliedparticipants,msnfp_startingdate,msnfp_engagementopportunityid",
            
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(msnfp_groupid eq \(groupId)))",
            ParameterKeys.filter : "(sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/msnfp_groupid eq \(groupId))))",
            ParameterKeys.orderby : "msnfp_engagementopportunitytitle asc"
            
        ]
        
        self.getPendingShiftDataOne(params: params)
        
    }
    
    
    func getPendingShiftThree(){
        
        let paramsThree : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunityschedule,createdon,msnfp_totalhours,msnfp_startperiod,msnfp_hoursperday,_msnfp_engagementopportunity_value,msnfp_endperiod,msnfp_effectiveto,msnfp_effectivefrom,msnfp_workingdays,msnfp_engagementopportunityscheduleid",
            
            ParameterKeys.filter : "(_msnfp_engagementopportunity_value eq 0243fc0b-d274-ed11-81ac-0022486dfdbd)",
//            ParameterKeys.filter : "(_msnfp_engagementopportunity_value eq 0243fc0b-d274-ed11-81ac-0022486dfdbd)",
            ParameterKeys.orderby : "msnfp_engagementopportunityschedule asc"
            
        ]
        

        self.getPendingShiftDataThree(params: paramsThree)
    }
    
    fileprivate func getPendingShiftDataOne(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestPendingShiftsOne(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let pendingShift = response.value {
                    self.pendingShiftDataOne = pendingShift
                    
                }
                self.getPendingShiftDataTwo()
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
    
    
    fileprivate func getPendingShiftDataTwo(){
        
        
        var engagementOppertunityId = ""
        
        for i in (0 ..< (self.pendingShiftDataOne?.count ?? 0)){
            var str = ""
            if ( i == (self.pendingShiftDataOne?.count ?? 0) - 1){
                str = "'{\(self.pendingShiftDataOne?[i].msnfp_engagementopportunityid ?? "")}'"
            }else{
                str = "'{\(self.pendingShiftDataOne?[i].msnfp_engagementopportunityid ?? "")}',"
            }
            engagementOppertunityId += str

        }
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_name,createdon,msnfp_participationscheduleid,msnfp_schedulestatus,sjavms_start,sjavms_hours,_sjavms_volunteerevent_value,_sjavms_volunteer_value,msnfp_participationscheduleid",
            
            ParameterKeys.expand : "sjavms_Volunteer($select=fullname,lastname,telephone1,emailaddress1,address1_stateorprovince,address1_postalcode,address1_country,address1_city)",
            ParameterKeys.filter : "(Microsoft.Dynamics.CRM.In(PropertyName='sjavms_volunteerevent',PropertyValues=[\(engagementOppertunityId)]))",
            ParameterKeys.orderby : "msnfp_name asc"
            
        ]
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestPendingShiftsTwo(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let pendingShift = response.value {
                    self.pendingShiftData = pendingShift
                    if (self.pendingShiftData?.count == 0 || self.pendingShiftData?.count == nil){
                        self.showEmptyView(tableVw: self.tableView)
                    }else{
                    
                        for i in (0 ..< (self.pendingShiftData?.count ?? 0)) {
                            
                            let rowModelEvent = self.getPendingShiftOneModelBy(self.pendingShiftData?[i]._sjavms_volunteerevent_value ?? "")
                            
                            self.pendingShiftData?[i].event_name = rowModelEvent?.msnfp_engagementopportunitytitle ?? ""
                            self.pendingShiftData?[i].event_starttime = rowModelEvent?.msnfp_startingdate ?? ""
                            self.pendingShiftData?[i].event_endtime = rowModelEvent?.msnfp_endingdate ?? ""
                            
                        }
                        
                        
                        DispatchQueue.main.async {
                            for subview in self.tableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.pendingShiftData = self.pendingShiftData?.filter({$0.msnfp_schedulestatus == 335940000})
                        self.filterPendingShiftData = self.pendingShiftData
                        self.filterByName()
                        self.tableView.reloadData()
                    }

                }else{
                    self.showEmptyView(tableVw: self.tableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.tableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    
    fileprivate func getPendingShiftDataThree(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestPendingShiftsThree(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let pendingShift = response.value {
                    self.pendingShiftDataThree = pendingShift

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
    
    
    func getPendingShiftOneModelBy(_ volunteerevent_value:String)->PendingShiftModelOne?{
        let modelOne = pendingShiftDataOne?.filter({$0.msnfp_engagementopportunityid == volunteerevent_value}).first
        return modelOne
    }
    
    func getPendingShiftThreeModelBy(_ volunteerevent_value:String)->String?{
        let modelThree = pendingShiftDataThree?.filter({$0._msnfp_engagementopportunity_value == volunteerevent_value}).first?.msnfp_engagementopportunityscheduleid
        return modelThree
    }
    
    //    func getPendingShiftTwoModelBy(_ opertunityId:String)->PendingShiftModelTwo{
    //        let modelOne = pendingShiftDataTwo?.filter({$0.msnfp_engagementopportunityid == volunteerevent_value}).first
    //        return modelOne
    //    }
    
    
    
}

















extension PendingShiftVC: UITableViewDelegate,UITableViewDataSource ,UITextViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterPendingShiftData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PendingShiftTVC", for: indexPath) as! PendingShiftTVC
        if indexPath.row % 2 == 0{
            cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
            cell.dividerView.backgroundColor = UIColor.themePrimaryColor
        }else{
            cell.mainView.backgroundColor = UIColor.viewLightColor
            cell.dividerView.backgroundColor = UIColor.gray
        }
        
        cell.delegate = self
        let rowModel = filterPendingShiftData?[indexPath.row]
        let eventId = self.filterPendingShiftData?[indexPath.row].msnfp_participationscheduleid
//        let eventId = self.getPendingShiftThreeModelBy(rowModel?._sjavms_volunteerevent_value ?? "")
        cell.eventId = eventId ?? ""
        
        cell.setCellData(rowModel : rowModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (self.filterPendingShiftData?[indexPath.row].event_selected ?? false){
            
            self.filterPendingShiftData?[indexPath.row].event_selected = false
        }else{
            self.filterPendingShiftData?[indexPath.row].event_selected = true
        }
        
        tableView.reloadRows(at: [indexPath], with: .none)
        
        
        
        
        //        ENTALDControllers.shared.showEventManageScreen(type: .ENTALDPUSH, from: self, data:self.pendingShiftData?[indexPath.row], callBack: nil)
    }
}
