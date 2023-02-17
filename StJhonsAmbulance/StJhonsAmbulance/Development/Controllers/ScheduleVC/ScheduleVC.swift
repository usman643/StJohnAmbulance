//
//  ScheduleVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 07/02/2023.
//

import UIKit

class ScheduleVC: ENTALDBaseViewController {
    
    var scheduleGroupData : [ScheduleGroupsModel]?
    var scheduleEngagementData : [ScheduleModelTwo]?
    var scheduleData : [ScheduleModelThree]?
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnCalender: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addImg: UIImageView!
    
    @IBOutlet weak var selectedTabImg: UIImageView!
    @IBOutlet weak var lblTabTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        decorateUI()
        getScheduleInfo()
        
    }
    
    func registerCell(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ScheduleTVC", bundle: nil), forCellReuseIdentifier: "ScheduleTVC")
    }
    
    func decorateUI(){
        lblTitle.textColor = UIColor.themePrimaryWhite
        lblTitle.font = UIFont.BoldFont(24)
        
        btnSignUp.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSignUp.titleLabel?.font = UIFont.BoldFont(14)
        btnSignUp.layer.cornerRadius = 2
        
        let image = UIImage(named: "ic_add")?.withRenderingMode(.alwaysTemplate)
        addImg.image = image
        addImg.tintColor = .white
        
        lblTabTitle.textColor = UIColor.themePrimaryWhite
        lblTabTitle.font = UIFont.BoldFont(16)
        
        selectedTabImg.image = selectedTabImg.image?.withRenderingMode(.alwaysTemplate)
        selectedTabImg.tintColor = UIColor.themePrimaryWhite
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
    
    // Bottom bar Action
    
    
    @IBAction func openCheckInScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("checkIn", self)
    }
    
    @IBAction func openEventScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("event", self)
        
    }
    
    @IBAction func openHoursScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("hour", self)
        
    }
    
    @IBAction func openMessagesScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("message", self)
        
    }
    
    @IBAction func openScheduleScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("schedule", self)
        
    }
    
    @IBAction func openDashBoardScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        
    }
    
}


// ============================  Tableview Delegates ===================================

extension ScheduleVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTVC", for: indexPath) as! ScheduleTVC
        let rowModel = scheduleData?[indexPath.row]
        cell.setContent(cellModel : rowModel)
        
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
        }else{
            cell.backgroundColor = UIColor.viewLightColor
//            cell.seperatorView.backgroundColor = UIColor.gray
        }
        
        return cell
    }
    
}




// ============================ API ==========================//

extension ScheduleVC {

    func getScheduleInfo(){
    
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
                        self.showEmptyView(tableVw: self.tableView)
                    }else{
                        self.getScheduleInfoThree()
                        DispatchQueue.main.async {
                            for subview in self.tableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
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
                        self.showEmptyView(tableVw: self.tableView)
                        
                    }else{
                       
                        DispatchQueue.main.async {
                            
                            self.tableView.reloadData()
                            for subview in self.tableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
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
}



