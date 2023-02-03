//
//  PendingShiftVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 27/01/2023.
//

import UIKit

class PendingShiftVC: ENTALDBaseViewController {
    
    var pendingShiftData : [PendingShiftModelTwo]?
    var pendingShiftDataOne : [PendingShiftModelOne]?
    var pendingShiftDataThree : [PendingShiftModelThree]?
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnSelectGroup: UIButton!
    @IBOutlet weak var btnGroupView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblShift: UILabel!
    @IBOutlet weak var lblAction: UILabel!
    
    
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
        self.btnSelectGroup.setTitle("\(ProcessUtils.shared.selectedUserGroup?.sjavms_RoleType?.getRoleType() ?? "")", for: .normal)
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
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        btnSelectGroup.backgroundColor = UIColor.themePrimary
        
        btnSelectGroup.setTitleColor(UIColor.textWhiteColor, for: .normal)
        lblTitle.textColor = UIColor.themePrimaryColor
        lblSubTitle.textColor = UIColor.themePrimaryColor
        lblName.textColor = UIColor.themePrimaryColor
        lblName.textColor = UIColor.themePrimaryColor
        lblEvent.textColor = UIColor.themePrimaryColor
        lblDate.textColor = UIColor.themePrimaryColor
        lblHours.textColor = UIColor.themePrimaryColor
        lblShift.textColor = UIColor.themePrimaryColor
        lblAction.textColor = UIColor.themePrimaryColor
        
        tableHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        tableHeaderView.layer.borderWidth = 1.5
        
        btnGroupView.layer.cornerRadius = 3
        
        
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
    
    func showGroupsPicker(list:[LandingGroupsModel] = []){
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, dataObj: ProcessUtils.shared.userGroupsList) { params, controller in
            
            if let data = params as? LandingGroupsModel {
                ProcessUtils.shared.selectedUserGroup = data
                self.getPendingShift()
                self.getPendingShiftThree()
                self.btnSelectGroup.setTitle("\(data.msnfp_groupId?.getGroupName() ?? "")", for: .normal)
                
            }
        }
    }
    
}


extension PendingShiftVC: UITableViewDelegate,UITableViewDataSource ,UITextViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingShiftData?.count ?? 0
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
        
        let rowModel = pendingShiftData?[indexPath.row]
        cell.setCellData(rowModel : rowModel)
        
//        let rowmodelThree = getPendingShiftThreeModelBy(rowModel?._sjavms_volunteerevent_value ?? "")
        
        let rowModelEvent = getPendingShiftOneModelBy(rowModel?._sjavms_volunteerevent_value ?? "")
        
        
        
        let startTime = DateFormatManager.shared.formatDateStrToStr(date: rowModelEvent?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
        
        let endTime = DateFormatManager.shared.formatDateStrToStr(date: rowModelEvent?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
        
        cell.lblShift.text = "\(startTime) - \(endTime)"
        cell.lblEvent.text = "\(rowModelEvent?.msnfp_engagementopportunitytitle ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

extension PendingShiftVC {
    
    
    func getPendingShift(){
        
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() else {return}
        
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
            
//            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(msnfp_groupid eq \(groupId)))",
            ParameterKeys.filter : "(_msnfp_engagementopportunity_value eq 0243fc0b-d274-ed11-81ac-0022486dfdbd)",
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
            
            
            debugPrint(engagementOppertunityId)
        }
        
        
        let params : [String:Any] = [
            
            
            ParameterKeys.select : "msnfp_name,createdon,msnfp_participationscheduleid,msnfp_schedulestatus,sjavms_start,sjavms_hours,_sjavms_volunteerevent_value,_sjavms_volunteer_value,msnfp_participationscheduleid",
            
            ParameterKeys.expand : "sjavms_Volunteer($select=fullname)",
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
    
    func getPendingShiftThreeModelBy(_ volunteerevent_value:String)->PendingShiftModelThree?{
        let modelThree = pendingShiftDataThree?.filter({$0._msnfp_engagementopportunity_value == volunteerevent_value}).first
        return modelThree
    }
    
    //    func getPendingShiftTwoModelBy(_ opertunityId:String)->PendingShiftModelTwo{
    //        let modelOne = pendingShiftDataTwo?.filter({$0.msnfp_engagementopportunityid == volunteerevent_value}).first
    //        return modelOne
    //    }
    
    
    
}
