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
    
    var volunteerData : [InAppVolunteerDataModel]?
    var filterVolunteerData : [InAppVolunteerDataModel]?
    
    var isEventsTableSearch = false
    var isVolunteerTableSearch = false

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var volunteerTableView: UITableView!
    
    @IBOutlet weak var volunteerView: UIView!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var textSearch: UITextField!
    
    @IBOutlet weak var lblCompose: UILabel!
    
    @IBOutlet weak var pencilImg: UIImageView!
    @IBOutlet weak var btnMessage: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
        registerCell()
        getVolunteers()
        getScheduleInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false // or true
    }
    
    
    func decorateUI(){
        headerView.addBottomShadow()
        lblTitle.font = UIFont.HeaderBoldFont(18)
        lblTitle.textColor = UIColor.headerGreen
        
        lblCompose.font = UIFont.HeaderBoldFont(14)
        lblCompose.textColor = UIColor.white
//        searchView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
//        searchView.layer.borderWidth = 1.5
//        searchView.isHidden = false
        
        textSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        self.volunteerView.isHidden = false
        self.eventView.isHidden = true
        
        isEventsTableSearch = true
        isVolunteerTableSearch = false
        pencilImg.image = pencilImg.image?.withRenderingMode(.alwaysTemplate)
        pencilImg.tintColor = UIColor.white
        let originalImage = UIImage(named: "messages-bubble-square-text")!
        let tintedImage = ProcessUtils.shared.tintImage(originalImage)
        btnMessage.setImage(tintedImage, for: .normal)   
        
    }
    
    @IBAction func segmenTapped(_ sender: Any) {
        if self.segment.selectedSegmentIndex == 0 {
            self.volunteerView.isHidden = false
            self.eventView.isHidden = true
            
            isEventsTableSearch = false
            isVolunteerTableSearch = true
            
        }else if (self.segment.selectedSegmentIndex == 1 ){
            
            self.volunteerView.isHidden = true
            self.eventView.isHidden = false
            
            isEventsTableSearch = true
            isVolunteerTableSearch = false

        }
        self.textSearch.text = ""
        
        
    }
    
    func registerCell(){
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.register(UINib(nibName: "InAppEventTVC", bundle: nil), forCellReuseIdentifier: "InAppEventTVC")
        volunteerTableView.delegate = self
        volunteerTableView.dataSource = self
        volunteerTableView.register(UINib(nibName: "InAppEventTVC", bundle: nil), forCellReuseIdentifier: "InAppEventTVC")
       
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func composeTapped(_ sender: Any) {
        ENTALDControllers.shared.showVolunteerMessagesVC(type: .ENTALDPUSH, from: self) { params, controller in
            
        }
        
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (textField.text != "" && isVolunteerTableSearch == true ){
            
            filterVolunteerData  =  volunteerData?.filter({
                if let name = $0.fullname, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                }
                return false
            })
            DispatchQueue.main.async {
                self.volunteerTableView.reloadData()
            }
            
            
        }else if(textField.text != "" && isEventsTableSearch == true ){
            
            filterScheduleData  =  scheduleData?.filter({
                if let name = $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                 }
               return false
             })
            
            DispatchQueue.main.async {
                self.eventsTableView.reloadData()
            }
            
        }else{
            DispatchQueue.main.async {
                self.filterVolunteerData = self.volunteerData
                self.volunteerTableView.reloadData()
                self.filterScheduleData = self.scheduleData
                self.eventsTableView.reloadData()
                
            }
        }
    }
    
    //==================== Schedule API =====================
    
    
    func getVolunteers(){
        let groupList =   ProcessUtils.shared.groupListValue ?? ""
        let params : [String:Any] = [
            
            ParameterKeys.select : "contactid,fullname",
//            ParameterKeys.expand : "",
            ParameterKeys.filter : "(msnfp_volunteer eq true and statuscode eq 1)",
            ParameterKeys.orderby : "fullname asc"
        ]
        
        self.getVolunteersData(params: params)
    }
    
    
    
    fileprivate func getVolunteersData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getVolunteersData(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if var volunteers = response.value {
                    let loggedInContact = "\(UserDefaults.standard.userInfo?.contactid ?? "")"
                    volunteers.removeAll(where: {$0.contactid == loggedInContact})
                    self.volunteerData = volunteers
                    self.filterVolunteerData = volunteers
                    if (self.volunteerData?.count == 0 || self.volunteerData?.count == nil){
                        self.showEmptyView(tableVw: self.volunteerTableView)
                    }else{
                        
                        DispatchQueue.main.async {
                            for subview in self.volunteerTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.volunteerTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.volunteerTableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.volunteerTableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
        if (tableView == volunteerTableView){
            return filterVolunteerData?.count ?? 0
        }else{
            return filterScheduleData?.count ?? 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InAppEventTVC", for: indexPath) as! InAppEventTVC
        if (tableView == volunteerTableView){
            cell.lblTitle.text = filterVolunteerData?[indexPath.row].fullname ?? ""
            cell.userImg.image = ProcessUtils.shared.convertBase64StringToImage(imageBase64String: filterVolunteerData?[indexPath.row].entityimage ?? "") ?? UIImage(named: "ic_communication")
//                cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
        }else{
            cell.lblTitle.text = filterScheduleData?[indexPath.row].sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
//                cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == volunteerTableView){
            ENTALDControllers.shared.showSignalRVC(type: .ENTALDPUSH, from: self, eventId: filterVolunteerData?[indexPath.row].contactid ?? "", dataObj: filterVolunteerData?[indexPath.row] , eventType : "volunteer" ,callBack: nil)
        }else{
            ENTALDControllers.shared.showSignalRVC(type: .ENTALDPUSH, from: self, eventId: filterScheduleData?[indexPath.row].sjavms_VolunteerEvent?.msnfp_engagementopportunityid ?? "", dataObj:filterScheduleData?[indexPath.row] , eventType : "event",  callBack: nil)
        }
        
        
    }
    
}
