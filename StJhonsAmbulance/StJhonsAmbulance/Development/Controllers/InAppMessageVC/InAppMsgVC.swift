//
//  InAppMsgVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 18/07/2023.
//

import UIKit

class InAppMsgVC: ENTALDBaseViewController {
    
    var scheduleGroupData : [ScheduleGroupsModel]?
    var scheduleEngagementData : [ScheduleModelTwo]?
    var scheduleData : [ScheduleModelThree]?
    var filterScheduleData : [ScheduleModelThree]?

    @IBOutlet weak var eventsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
        registerCell()
        getScheduleInfo()
    }
    
    
    func decorateUI(){

        
        
    }
    
    func registerCell(){
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.register(UINib(nibName: "InAppEventTVC", bundle: nil), forCellReuseIdentifier: "InAppEventTVC")
        
       
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //==================== Schedule API =====================
    
    
    func getScheduleInfo(){
        let groupList =   ProcessUtils.shared.groupListValue ?? ""
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_engagementopportunitystatus,msnfp_startingdate,msnfp_endingdate,msnfp_engagementopportunityid",
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=['{B651C666-CDC3-EB11-BACC-000D3A1FEB2E}','{80A4FB78-CDC3-EB11-BACC-000D3A1FEB2E}'])))",
            ParameterKeys.filter : "(statecode eq 0 and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002'])) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(groupList)]))))",
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
                        self.showEmptyView(tableVw: self.eventsTableView)
                    }else{
                        self.getScheduleInfoThree()
                        DispatchQueue.main.async {
                            for subview in self.eventsTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                }else{
                    self.showEmptyView(tableVw: self.eventsTableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.eventsTableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    func getScheduleInfoThree(){
        var propertyValues = ""
        
        for i in (0 ..< (self.scheduleEngagementData?.count ?? 0)){
            var str = ""
            if ( i == (self.scheduleEngagementData?.count ?? 0) - 1){
                str = "sjavms_VolunteerEvent/ msnfp_engagementopportunityid eq \(self.scheduleEngagementData?[i].msnfp_engagementopportunityid ?? "")"
            }else{
                str = "sjavms_VolunteerEvent/ msnfp_engagementopportunityid eq \(self.scheduleEngagementData?[i].msnfp_engagementopportunityid ?? "") or "
            }
            
            propertyValues += str
            
        }
        
        guard let contactId = UserDefaults.standard.contactIdToken  else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "_sjavms_volunteerevent_value,msnfp_schedulestatus,sjavms_start,msnfp_participationscheduleid,sjavms_end,sjavms_checkedin",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=msnfp_engagementopportunitytitle,msnfp_location)",
            ParameterKeys.filter : "(_sjavms_volunteer_value eq \(contactId) and msnfp_schedulestatus eq 335940000 and (\(propertyValues))) ",
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
                    self.filterScheduleData = scheduleGroup
                    if (self.scheduleData?.count == 0 || self.scheduleData?.count == nil){
                        self.showEmptyView(tableVw: self.eventsTableView)
                        
                    }else{
                        
                        DispatchQueue.main.async {
                            for subview in self.eventsTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.eventsTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.eventsTableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.eventsTableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    fileprivate func getCheckInData(eventOppId:String, completion:@escaping((_ model : CheckInResponseModel?) -> Void )){
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "fullname,telephone1,_ownerid_value,emailaddress1,bdo_province,address1_postalcode,address1_city,bdo_contactid,_parentcustomerid_value,contactid,entityimage",
            ParameterKeys.expand : "sjavms_contact_msnfp_participationschedule_Volunteer($select=sjavms_checkedin,sjavms_checkedinlatitude,sjavms_checkedinlongitude,sjavms_checkedinlatitudevalue,sjavms_checkedinlongitudevalue,sjavms_checkedinat,sjavms_checkedinlocation;$filter=(_sjavms_volunteerevent_value eq \(eventOppId) and msnfp_schedulestatus eq 335940000))",
            ParameterKeys.filter : "(sjavms_contact_msnfp_participationschedule_Volunteer/any(o1:(o1/_sjavms_volunteerevent_value eq \(eventOppId) and o1/msnfp_schedulestatus eq 335940000)))",
            ParameterKeys.orderby : "fullname asc"
        ]
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestCheckInData(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                completion(response)
                
                //                if let checkInData = response.value {
                //                    self.checkInData = checkInData
                //                    if ((self.checkInData?.count ?? 0) > 0){
                //                        self.mapData.append(contentsOf: (checkInData))
                //                    }
                //                }
                
            case .error(let error, let errorResponse):
                //                completion(nil)
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                print("Error Message \(message)")
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
    
}


extension InAppMsgVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleData?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InAppEventTVC", for: indexPath) as! InAppEventTVC
        
        cell.lblTitle.text = scheduleData?[indexPath.row].sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
//        if indexPath.row % 2 == 0{
            cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
            
//        }else{
//            cell.mainView.backgroundColor = UIColor.viewLightColor
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ENTALDControllers.shared.showSignalRVC(type: .ENTALDPUSH, from: self, eventId: scheduleData?[indexPath.row].sjavms_VolunteerEvent?.msnfp_engagementopportunityid ?? "", callBack: nil)
        
    }
    
}
