//
//  VolunteerEventsVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 05/02/2023.
//

import UIKit

class VolunteerEventsVC: UIViewController {

    var pastEventData : [VolunteerEventsModel]?
    var scheduleGroupData : [ScheduleGroupsModel]?
    var scheduleEngagementData : [ScheduleModelTwo]?
    var scheduleData : [ScheduleModelThree]?
    var availableEngagementData : [ScheduleModelTwo]?
    var availableData : [AvailableEventModel]?
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet var allHeadingLabels: [UILabel]!
    @IBOutlet var allLabels: [UILabel]!
    
    @IBOutlet weak var availableHeaderView: UIView!
    @IBOutlet weak var scheduleHeaderView: UIView!
    @IBOutlet weak var pastHeaderView: UIView!
    
    @IBOutlet weak var availableTable: UITableView!
    @IBOutlet weak var scheduleTable: UITableView!
    @IBOutlet weak var pastTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        decorateUI()
        getScheduleInfo()
        getVolunteerPastEvent()
        getAvailableInfo()
    }

    func decorateUI(){
        
        for lbltext in allLabels{
            lbltext.font = UIFont.BoldFont(12)
            lbltext.textColor = UIColor.themePrimaryColor
        }
        for lbltext in allHeadingLabels{
            lbltext.font = UIFont.BoldFont(18)
            lbltext.textColor = UIColor.themePrimaryColor
        }
        
        availableHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        availableHeaderView.layer.borderWidth = 1
        
        scheduleHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        scheduleHeaderView.layer.borderWidth = 1
        
        pastHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        pastHeaderView.layer.borderWidth = 1
        

    }
    
    func registerCells(){
        
        availableTable.delegate = self
        availableTable.dataSource = self
        availableTable.register(UINib(nibName: "VolunteerEventTVC", bundle: nil), forCellReuseIdentifier: "VolunteerEventTVC")
        
        scheduleTable.delegate = self
        scheduleTable.dataSource = self
        scheduleTable.register(UINib(nibName: "VolunteerEventTVC", bundle: nil), forCellReuseIdentifier: "VolunteerEventTVC")
        
        pastTable.delegate = self
        pastTable.dataSource = self
        pastTable.register(UINib(nibName: "VolunteerEventTVC", bundle: nil), forCellReuseIdentifier: "VolunteerEventTVC")

    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
    }
    
    @IBAction func availableFilterTapped(_ sender: Any) {
        self.availableData = self.availableData?.reversed()
        DispatchQueue.main.async {
            self.availableTable.reloadData()
        }
        
    }
    
    @IBAction func scheduledFilterTapped(_ sender: Any) {
        self.scheduleData = self.scheduleData?.reversed()
        DispatchQueue.main.async {
            self.scheduleTable.reloadData()
        }
        
    }
    
    @IBAction func pastFilterTapped(_ sender: Any) {
        self.pastEventData = self.pastEventData?.reversed()
        DispatchQueue.main.async {
            self.pastTable.reloadData()
            self.pastTable.reloadData()
        }
    }
    
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
    
    
}

extension VolunteerEventsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == availableTable){
            return availableData?.count ?? 0
        }else if (tableView == scheduleTable){
            return scheduleData?.count ?? 0
        }else if (tableView == pastTable){
            return pastEventData?.count ?? 0
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VolunteerEventTVC", for: indexPath) as! VolunteerEventTVC
        
        if (tableView == availableTable){
            let rowModel = self.availableData?[indexPath.row]
            cell.setContent(cellModel: rowModel)
        }else if (tableView == scheduleTable){
            let rowModel = self.scheduleData?[indexPath.row]
            cell.setContent(cellModel: rowModel)
        }else if (tableView == pastTable){
            let rowModel = self.pastEventData?[indexPath.row]
            cell.setContent(cellModel: rowModel)
        }
        
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
            cell.seperatorView.backgroundColor = UIColor.themePrimaryColor
        }else{
            cell.backgroundColor = UIColor.viewLightColor
            cell.seperatorView.backgroundColor = UIColor.gray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == availableTable){
            let vc = EventDetailVC(nibName: "EventDetailVC", bundle: nil)
            vc.availableEvent = self.availableData?[indexPath.row]
            self.navigationController?.pushViewController(vc , animated: true)
        }else if (tableView == scheduleTable){
            let vc = EventDetailVC(nibName: "EventDetailVC", bundle: nil)
            vc.scheduleEvent = self.scheduleData?[indexPath.row]
            self.navigationController?.pushViewController(vc , animated: true)
        }else if (tableView == pastTable){
            let vc = EventDetailVC(nibName: "EventDetailVC", bundle: nil)
            vc.pastEvent = self.pastEventData?[indexPath.row]
            self.navigationController?.pushViewController(vc , animated: true)
        }
    }
}


extension VolunteerEventsVC {
    
    func getVolunteerPastEvent(){
        guard let contactId = UserDefaults.standard.contactIdToken else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "_sjavms_volunteerevent_value,msnfp_schedulestatus,sjavms_start,msnfp_participationscheduleid,sjavms_end",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=msnfp_location,msnfp_engagementopportunityid,msnfp_engagementopportunitytitle)",
            ParameterKeys.filter : "(msnfp_schedulestatus eq 335940001 and _sjavms_volunteer_value eq \(contactId)) and (sjavms_VolunteerEvent/msnfp_engagementopportunitystatus eq 844060004)",
            ParameterKeys.orderby : "sjavms_start asc,_sjavms_volunteerevent_value asc"
        ]
        
        self.getVolunteerPastEventData(params: params)
    }
    
    fileprivate func getVolunteerPastEventData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerPastEvent(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let pastEvents = response.value {
                    self.pastEventData = pastEvents
                    if (self.pastEventData?.count == 0 || self.pastEventData?.count == nil){
                        self.showEmptyView(tableVw: self.pastTable)
                    }else{
                        DispatchQueue.main.async {
                            self.pastTable.reloadData()
                            for subview in self.pastTable.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    
                }else{
                    self.showEmptyView(tableVw: self.pastTable)
                }
            
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.pastTable)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    //==================== Schedule API =====================
    
//    func getScheduleInfo(){
//
//        guard let contactId = UserDefaults.standard.contactIdToken  else {return}
//        let params : [String:Any] = [
//
//            ParameterKeys.select : "msnfp_groupmembershipid,msnfp_groupmembershipname,_msnfp_groupid_value",
//            ParameterKeys.expand : "msnfp_groupId",
//            ParameterKeys.filter : "(statuscode eq 1 and _msnfp_contactid_value eq \(contactId)) and (msnfp_groupId/statecode eq 0)",
//            ParameterKeys.orderby : "msnfp_groupmembershipname asc"
//        ]
//
//        self.getGroupidData(params: params)
//    }
//    fileprivate func getGroupidData(params : [String:Any]){
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
//
//        ENTALDLibraryAPI.shared.requestScheduleOne(params: params){ result in
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }
//
//            switch result{
//            case .success(value: let response):
//
//                if let scheduleGroup = response.value {
//                    self.scheduleGroupData = scheduleGroup
//                    if (self.scheduleGroupData?.count == 0 || self.scheduleGroupData?.count == nil){
//                        self.showEmptyView(tableVw: self.scheduleTable)
//                    }else{
//                        self.getScheduleInfoTwo()
//                        self.getAvailableInfoTwo()
//                        DispatchQueue.main.async {
//                            for subview in self.scheduleTable.subviews {
//                                subview.removeFromSuperview()
//                            }
//                        }
//                    }
//                }else{
//                    self.showEmptyView(tableVw: self.scheduleTable)
//                }
//
//            case .error(let error, let errorResponse):
//                var message = error.message
//                if let err = errorResponse {
//                    message = err.error
//                }
//                self.showEmptyView(tableVw: self.scheduleTable)
//                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
//                }
//            }
//        }
//    }
    
    func getScheduleInfo(){
        
//        var propertyValues = ""
//
//        for i in (0 ..< (self.scheduleGroupData?.count ?? 0)){
//            var str = ""
//
//            if let groupid_value = self.scheduleGroupData?[i].msnfp_groupId?._sjavms_groupid_value {
//
//                if ( i == (self.scheduleGroupData?.count ?? 0) - 1){
//                    str = "'{\(groupid_value)}'"
//                }else{
//                    str = "'{\(groupid_value)}',"
//                }
//
//                propertyValues += str
//            }
//
//
//        }
    
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_engagementopportunitystatus,msnfp_startingdate,msnfp_endingdate,msnfp_engagementopportunityid",
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=['{B651C666-CDC3-EB11-BACC-000D3A1FEB2E}','{80A4FB78-CDC3-EB11-BACC-000D3A1FEB2E}'])))",
            ParameterKeys.filter : "(statecode eq 0 and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002'])) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(ProcessUtils.shared.groupListValue ?? "")]))))",
            ParameterKeys.orderby : "msnfp_engagementopportunitytitle asc"
        ]
        
        self.getScheduleInfoTwoData(params: params)
    }
    
    
    fileprivate func getScheduleInfoTwoData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestScheduleTwo(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let scheduleGroup = response.value {
                    self.scheduleEngagementData = scheduleGroup
                    if (self.scheduleEngagementData?.count == 0 || self.scheduleEngagementData?.count == nil){
                        self.showEmptyView(tableVw: self.scheduleTable)
                    }else{
                        self.getScheduleInfoThree()
                        DispatchQueue.main.async {
                            for subview in self.scheduleTable.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                }else{
                    self.showEmptyView(tableVw: self.scheduleTable)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.scheduleTable)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    func getScheduleInfoThree(){
        var propertyValues = ""
        
        for i in (0 ..< (self.scheduleGroupData?.count ?? 0)){
            var str = ""
            if ( i == (self.scheduleGroupData?.count ?? 0) - 1){
                str = "sjavms_VolunteerEvent/ msnfp_engagementopportunityid eq \(self.scheduleEngagementData?[i].msnfp_engagementopportunityid ?? "")"
            }else{
                str = "sjavms_VolunteerEvent/ msnfp_engagementopportunityid eq \(self.scheduleEngagementData?[i].msnfp_engagementopportunityid ?? "") or "
            }
            
            propertyValues += str
            
        }
        
        guard let contactId = UserDefaults.standard.contactIdToken  else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "_sjavms_volunteerevent_value,msnfp_schedulestatus,sjavms_start,msnfp_participationscheduleid,sjavms_end",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=msnfp_engagementopportunitytitle,msnfp_location)",
            ParameterKeys.filter : "(_sjavms_volunteer_value eq \(contactId) and msnfp_schedulestatus eq 335940000 and (\(propertyValues))) ",
//            ParameterKeys.filter : "(_sjavms_volunteer_value eq \(contactId) and msnfp_schedulestatus eq 335940000 and (\(propertyValues))) ",
            ParameterKeys.orderby : "msnfp_name asc"
        ]
        
        self.getScheduleInfoThreeData(params: params)
        
    }
    
    fileprivate func getScheduleInfoThreeData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestScheduleThree(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let scheduleGroup = response.value {
                    self.scheduleData = scheduleGroup
                    if (self.scheduleData?.count == 0 || self.scheduleData?.count == nil){
                        self.showEmptyView(tableVw: self.scheduleTable)
                        
                    }else{
                       
                        DispatchQueue.main.async {
                            
                            self.scheduleTable.reloadData()
                            for subview in self.scheduleTable.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                }else{
                    self.showEmptyView(tableVw: self.scheduleTable)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.scheduleTable)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    // ========================= Available API ================================
    
    
    
    
//    func getAvailableInfo(){
//        guard let contactId = UserDefaults.standard.contactIdToken  else {return}
////        var propertyValues = ""
////
////        for i in (0 ..< (self.scheduleGroupData?.count ?? 0)){
////            var str = ""
////
////            if let groupid_value = self.scheduleGroupData?[i].msnfp_groupId?._sjavms_groupid_value {
////
////                if ( i == (self.scheduleGroupData?.count ?? 0) - 1){
////                    str = "'{\(groupid_value)}'"
////                }else{
////                    str = "'{\(groupid_value)}',"
////                }
////
////                propertyValues += str
////            }
////
////
////        }
//
//        let params : [String:Any] = [
//
//            ParameterKeys.select : "msnfp_groupmembershipid,msnfp_groupmembershipname,_msnfp_groupid_value",
//
////            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=['{B651C666-CDC3-EB11-BACC-000D3A1FEB2E}','{80A4FB78-CDC3-EB11-BACC-000D3A1FEB2E}'])))",
////            ParameterKeys.filter : "(statecode eq 0 and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002'])) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(ProcessUtils.shared.groupListValue ?? "")]))))",
//            ParameterKeys.filter : "(statuscode eq 1 and _msnfp_contactid_value eq \(contactId)) and (msnfp_groupId/statecode eq 0)",
//            ParameterKeys.orderby : "msnfp_engagementopportunitytitle asc"
//        ]
//
//        self.getAvailableTwoData(params: params)
//    }
//
//
//    fileprivate func getAvailableTwoData(params : [String:Any]){
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
//
//        ENTALDLibraryAPI.shared.requestVolunteerAvailableEventTwo(params: params){ result in
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }
//
//            switch result{
//            case .success(value: let response):
//
//                if let availableGroup = response.value {
//                    self.availableEngagementData = availableGroup
//                    if (self.availableEngagementData?.count == 0 || self.availableEngagementData?.count == nil){
//                        self.showEmptyView(tableVw: self.availableTable)
//                    }else{
//                        self.getScheduleInfoThree()
//                        DispatchQueue.main.async {
//                            for subview in self.availableTable.subviews {
//                                subview.removeFromSuperview()
//                            }
//                        }
//                    }
//                }else{
//                    self.showEmptyView(tableVw: self.availableTable)
//                }
//
//            case .error(let error, let errorResponse):
//                var message = error.message
//                if let err = errorResponse {
//                    message = err.error
//                }
//                self.showEmptyView(tableVw: self.availableTable)
//                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
//                }
//            }
//        }
//    }
    
    func getAvailableInfo(){
       
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_engagementopportunitystatus,msnfp_endingdate,msnfp_startingdate,msnfp_engagementopportunityid,_sjavms_program_value,msnfp_location,msnfp_maximum,msnfp_minimum",
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=['{b80A4FB78-CDC3-EB11-BACC-000D3A1FEB2E}','{B651C666-CDC3-EB11-BACC-000D3A1FEB2E}'])))",
//            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=['{80A4FB78-CDC3-EB11-BACC-000D3A1FEB2E}','{B651C666-CDC3-EB11-BACC-000D3A1FEB2E}'])))",
//            ParameterKeys.filter : "(Microsoft.Dynamics.CRM.In(PropertyName='statuscode',PropertyValues=['1','802280000']) and sjavms_adhocevent ne true and msnfp_engagementopportunitystatus eq 844060002 and (Microsoft.Dynamics.CRM.Today(PropertyName='msnfp_endingdate') or Microsoft.Dynamics.CRM.NextXYears(PropertyName='msnfp_endingdate',PropertyValue=10))) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(ProcessUtils.shared.groupListValue ?? "")]))))",
            ParameterKeys.filter : "(Microsoft.Dynamics.CRM.In(PropertyName='statuscode',PropertyValues=['1','802280000']) and sjavms_adhocevent ne true and msnfp_engagementopportunitystatus eq 844060002 and (Microsoft.Dynamics.CRM.Today(PropertyName='msnfp_endingdate') or Microsoft.Dynamics.CRM.NextXYears(PropertyName='msnfp_endingdate',PropertyValue=10))) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=['{9afc17ef-14b4-ec11-983e-0022486db8f0}','{7079a17f-0339-ed11-9db1-0022486dfdbd}','{49005e21-76f8-ec11-82e5-0022486dccc4}','{37371436-03d2-ec11-a7b5-0022486dfa41}','{a02e2a85-cdc3-eb11-bacc-000d3a1feb2e}','{18791306-d7bb-ec11-983f-000d3af4ed1b}','{80a4fb78-cdc3-eb11-bacc-000d3a1feb2e}','{b651c666-cdc3-eb11-bacc-000d3a1feb2e}']))))",
       ParameterKeys.orderby : "msnfp_engagementopportunitytitle asc"
        ]
        
        self.getAvailalbeInfoData(params: params)
        
    }
    
    fileprivate func getAvailalbeInfoData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerAvailableEventTwo(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let availableEvent = response.value {
                    self.availableData = availableEvent
                    if (self.availableData?.count == 0 || self.availableData?.count == nil){
                        self.showEmptyView(tableVw: self.availableTable)
                        
                    }else{
                       
                        DispatchQueue.main.async {
                            
                            self.availableTable.reloadData()
                            for subview in self.availableTable.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                }else{
                    self.showEmptyView(tableVw: self.availableTable)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.availableTable)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
}

