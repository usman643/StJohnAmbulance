//
//  EventVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 27/01/2023.
//

import UIKit

class EventVC: ENTALDBaseViewController {
    
    var currentEventData : [CurrentEventsModel]?
    var upcomingEventData : [CurrentEventsModel]?
    var pastEventData : [CurrentEventsModel]?
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var selectGroupView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSelectGroup: UIButton!
    @IBOutlet weak var btnCreateEvent: UIButton!
    @IBOutlet weak var lblCurrent: UILabel!
    @IBOutlet weak var btnCurrentFilter: UIButton!
    @IBOutlet weak var btnUpcomingFilter: UIButton!
    @IBOutlet weak var btnPastFilter: UIButton!
    @IBOutlet weak var lblUpcoming: UILabel!
    @IBOutlet weak var lblPast: UILabel!
    
    @IBOutlet weak var currentStackView: UIStackView!
    @IBOutlet weak var upcomingStackView: UIStackView!
    @IBOutlet weak var pastStackView: UIStackView!
    
    @IBOutlet weak var currentHeaderView: UIView!
    @IBOutlet weak var upcomingHeaderView: UIView!
    @IBOutlet weak var pastHeaderView: UIView!
    
    @IBOutlet weak var currentTableView: UITableView!
    @IBOutlet weak var upcomingTableView: UITableView!
    @IBOutlet weak var pastTableView: UITableView!
    
    @IBOutlet weak var lblCurrentEvent: UILabel!
    @IBOutlet weak var lblCurrentLocation: UILabel!
    @IBOutlet weak var lblCurrentStart: UILabel!
    @IBOutlet weak var lblCurrentEnd: UILabel!
    @IBOutlet weak var lblCurrentNeeded: UILabel!
    @IBOutlet weak var lblUpcomingEvent: UILabel!
    @IBOutlet weak var lblUpcomingLocation: UILabel!
    @IBOutlet weak var lblUpcomingStart: UILabel!
    @IBOutlet weak var lblUpcomingEnd: UILabel!
    @IBOutlet weak var lblUpcomingNeeded: UILabel!
    @IBOutlet weak var lblPastEvent: UILabel!
    @IBOutlet weak var lblPastLocation: UILabel!
    @IBOutlet weak var lblPastDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentTableView.delegate = self
        currentTableView.dataSource = self
        currentTableView.register(UINib(nibName: "EventTVC", bundle: nil), forCellReuseIdentifier: "EventTVC")
        currentTableView.register(UINib(nibName: "EmptyEventTableCell", bundle: nil), forCellReuseIdentifier: "EmptyEventTableCell")
        
        upcomingTableView.delegate = self
        upcomingTableView.dataSource = self
        upcomingTableView.register(UINib(nibName: "EventTVC", bundle: nil), forCellReuseIdentifier: "EventTVC")
        upcomingTableView.register(UINib(nibName: "EmptyEventTableCell", bundle: nil), forCellReuseIdentifier: "EmptyEventTableCell")
        
        pastTableView.delegate = self
        pastTableView.dataSource = self
        pastTableView.register(UINib(nibName: "PastEventTVC", bundle: nil), forCellReuseIdentifier: "PastEventTVC")
        pastTableView.register(UINib(nibName: "EmptyEventTableCell", bundle: nil), forCellReuseIdentifier: "EmptyEventTableCell")
        
        
        
        decorateUI()
        getCurrentEvents()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.btnSelectGroup.setTitle("\(ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupName() ?? "")", for: .normal)
    }
    
    func decorateUI(){
        selectGroupView.layer.cornerRadius = 3
        btnSelectGroup.layer.cornerRadius = 3
        btnCreateEvent.layer.cornerRadius = 3
        lblTitle.font = UIFont.BoldFont(20)
        lblTitle.textColor = UIColor.themePrimaryColor
        
        currentHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        upcomingHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        pastHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        currentHeaderView.layer.borderWidth = 1.5
        upcomingHeaderView.layer.borderWidth = 1.5
        pastHeaderView.layer.borderWidth = 1.5
        lblUpcoming.font = UIFont.BoldFont(16)
        lblUpcoming.textColor = UIColor.themePrimaryColor
        lblCurrent.font = UIFont.BoldFont(16)
        lblCurrent.textColor = UIColor.themePrimaryColor
        lblPast.font = UIFont.BoldFont(16)
        lblPast.textColor = UIColor.themePrimaryColor
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        btnCreateEvent.titleLabel?.font = UIFont.BoldFont(12)
        btnSelectGroup.backgroundColor = UIColor.themePrimary
        
        btnSelectGroup.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnCreateEvent.setTitleColor(UIColor.textWhiteColor, for: .normal)
        lblCurrentEvent.font = UIFont.BoldFont(12)
        lblCurrentLocation.font = UIFont.BoldFont(12)
        lblCurrentStart.font = UIFont.BoldFont(12)
        lblCurrentEnd.font = UIFont.BoldFont(12)
        lblCurrentNeeded.font = UIFont.BoldFont(12)
        lblUpcomingEvent.font = UIFont.BoldFont(12)
        lblUpcomingLocation.font = UIFont.BoldFont(12)
        lblUpcomingStart.font = UIFont.BoldFont(12)
        lblUpcomingEnd.font = UIFont.BoldFont(12)
        lblUpcomingNeeded.font = UIFont.BoldFont(12)
        lblPastEvent.font = UIFont.BoldFont(12)
        lblPastLocation.font = UIFont.BoldFont(12)
        lblPastDate.font = UIFont.BoldFont(12)
        
        lblCurrentEvent.textColor = UIColor.themePrimaryColor
        lblCurrentLocation.textColor = UIColor.themePrimaryColor
        lblCurrentStart.textColor = UIColor.themePrimaryColor
        lblCurrentEnd.textColor = UIColor.themePrimaryColor
        lblCurrentNeeded.textColor = UIColor.themePrimaryColor
        lblUpcomingEvent.textColor = UIColor.themePrimaryColor
        lblUpcomingLocation.textColor = UIColor.themePrimaryColor
        lblUpcomingStart.textColor = UIColor.themePrimaryColor
        lblUpcomingEnd.textColor = UIColor.themePrimaryColor
        lblUpcomingNeeded.textColor = UIColor.themePrimaryColor
        lblPastEvent.textColor = UIColor.themePrimaryColor
        lblPastLocation.textColor = UIColor.themePrimaryColor
        lblPastDate.textColor = UIColor.themePrimaryColor
        
        currentTableView.clipsToBounds = false
        currentTableView.layer.masksToBounds = false
        currentTableView.layer.shadowColor = UIColor.lightGray.cgColor
        currentTableView.layer.shadowOffset = .zero
        currentTableView.layer.shadowRadius = 0
        currentTableView.layer.shadowOpacity = 0.5
        
        upcomingTableView.clipsToBounds = false
        upcomingTableView.layer.masksToBounds = false
        upcomingTableView.layer.shadowColor = UIColor.lightGray.cgColor
        upcomingTableView.layer.shadowOffset = .zero
        upcomingTableView.layer.shadowRadius = 0
        upcomingTableView.layer.shadowOpacity = 0.5
        
        pastTableView.clipsToBounds = false
        pastTableView.layer.masksToBounds = false
        pastTableView.layer.shadowColor = UIColor.lightGray.cgColor
        pastTableView.layer.shadowOffset = .zero
        pastTableView.layer.shadowRadius = 0
        pastTableView.layer.shadowOpacity = 0.5
        
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
    
    @IBAction func currentFilterTapped(_ sender: Any) {
        
        self.currentEventData = self.currentEventData?.reversed()
        DispatchQueue.main.async {
            self.currentTableView.reloadData()
        }
        
    }
    
    @IBAction func upcomingFilterTapped(_ sender: Any) {
        self.upcomingEventData = self.upcomingEventData?.reversed()
        DispatchQueue.main.async {
            self.upcomingTableView.reloadData()
        }
        
    }
    
    @IBAction func pastFilterTapped(_ sender: Any) {
        self.pastEventData = self.pastEventData?.reversed()
        DispatchQueue.main.async {
            self.pastTableView.reloadData()
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
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, dataObj: ProcessUtils.shared.userGroupsList) { params, controller in
            
            if let data = params as? LandingGroupsModel {
                ProcessUtils.shared.selectedUserGroup = data
                self.getCurrentEvents()
                self.btnSelectGroup.setTitle("\(data.msnfp_groupId?.getGroupName() ?? "")", for: .normal)
                
            }
        }
    }
    
    
    func getCurrentEvents(){
        
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() else {return}
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_startingdate,msnfp_location,msnfp_engagementopportunitystatus,_sjavms_program_value,msnfp_engagementopportunityid,msnfp_endingdate,msnfp_maximum,msnfp_minimum",
            
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(msnfp_groupid eq \(groupId)))",
            ParameterKeys.filter : "(statecode eq 0 and sjavms_adhocevent ne true and Microsoft.Dynamics.CRM.Today(PropertyName='msnfp_startingdate') and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002'])) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/msnfp_groupid eq \(groupId))))",
            ParameterKeys.orderby : "msnfp_engagementopportunitytitle asc"
            
        ]
        
        self.getCurrentEventData(params: params)
        
    }
    
    
    fileprivate func getCurrentEventData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestCurrentEvents(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            self.getUpcomingEvents()
            switch result{
            case .success(value: let response):
                
                if let currentEvent = response.value {
                    self.currentEventData = currentEvent
                    if (self.currentEventData?.count == 0 || self.currentEventData?.count == nil){
                        self.showEmptyView(tableVw: self.currentTableView)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.currentTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.currentTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.currentTableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
               
                self.showEmptyView(tableVw: self.currentTableView)
                
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    
    // Upcoming Events API
    
    func getUpcomingEvents(){
        
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() else {return}
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_startingdate,msnfp_location,msnfp_engagementopportunitystatus,_sjavms_program_value,msnfp_engagementopportunityid,msnfp_endingdate,msnfp_maximum,msnfp_minimum",
            
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(msnfp_groupid eq \(groupId)))",
            ParameterKeys.filter : "(statecode eq 0 and sjavms_adhocevent ne true and Microsoft.Dynamics.CRM.Today(PropertyName='msnfp_startingdate') and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002'])) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/msnfp_groupid eq \(groupId))))",
            ParameterKeys.orderby : "msnfp_engagementopportunitytitle asc"
            
        ]
        
        self.getUpcomingEventData(params: params)
        
    }
    
    
    fileprivate func getUpcomingEventData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestUpcomingEvents(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            self.getPastEvents()
            switch result{
            case .success(value: let response):
                
                if let upcomingEvent = response.value {
                    self.upcomingEventData = upcomingEvent
                    if (self.upcomingEventData?.count == 0 || self.upcomingEventData?.count == nil){
                        self.showEmptyView(tableVw: self.upcomingTableView)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.upcomingTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.upcomingTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.upcomingTableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.currentTableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    // Past Event API
    
    
    func getPastEvents(){
        
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() else {return}
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_startingdate,msnfp_location,msnfp_engagementopportunitystatus,_sjavms_program_value,_sjavms_program_value,msnfp_engagementopportunityid,sjavms_maxparticipants,msnfp_endingdate,msnfp_maximum,msnfp_minimum",
            
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(msnfp_groupid eq \(groupId)))",
            ParameterKeys.filter : "(statecode eq 0 and sjavms_adhocevent ne true and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002']) and (Microsoft.Dynamics.CRM.Tomorrow(PropertyName='msnfp_startingdate') or Microsoft.Dynamics.CRM.NextXYears(PropertyName='msnfp_startingdate',PropertyValue=10))) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/msnfp_groupid eq \(groupId))))",
            ParameterKeys.orderby : "msnfp_engagementopportunitytitle asc"
            
        ]
        
        self.getPastEventData(params: params)
        
    }
    
    
    fileprivate func getPastEventData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestPastEvents(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let pastEvent = response.value {
                    self.pastEventData = pastEvent
                    if (self.pastEventData?.count == 0 || self.pastEventData?.count == nil){
                        self.showEmptyView(tableVw: self.pastTableView)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.pastTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.pastTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.pastTableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.pastTableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    
}


extension EventVC: UITableViewDelegate,UITableViewDataSource ,UITextViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.currentTableView){
           return self.currentEventData?.count ?? 0
        }else if (tableView == self.upcomingTableView){
            return self.upcomingEventData?.count ?? 0
        }else if(tableView == self.pastTableView){
            return self.pastEventData?.count ?? 0
            
        }
        
        return self.currentEventData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        
        if (tableView == self.currentTableView){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventTVC", for: indexPath) as! EventTVC
            if indexPath.row % 2 == 0{
                cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
                cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
            }else{
                cell.mainView.backgroundColor = UIColor.viewLightColor
                cell.seperaterView.backgroundColor = UIColor.gray
            }
            
            let rowModel = self.currentEventData?[indexPath.row]
            
            cell.lblEvent.text = rowModel?.msnfp_engagementopportunitytitle ?? ""
            //            cell.lblLocation.text = rowModel?.msnfp_location ?? ""
            cell.lblStart.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy-MM-dd")
            cell.lblEnd.text =  DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy-MM-dd")
            cell.lblNeeded.text = "\(rowModel?.msnfp_minimum ?? 0)"
            
            return cell
            
            
        }else if (tableView == self.upcomingTableView){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventTVC", for: indexPath) as! EventTVC
            if indexPath.row % 2 == 0{
                cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
                cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
            }else{
                cell.mainView.backgroundColor = UIColor.viewLightColor
                cell.seperaterView.backgroundColor = UIColor.gray
            }
            
            let rowModel = self.upcomingEventData?[indexPath.row]
            
            cell.lblEvent.text = rowModel?.msnfp_engagementopportunitytitle ?? ""
            //            cell.lblLocation.text = rowModel?.msnfp_location ?? ""
            cell.lblStart.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy-MM-dd")
            cell.lblEnd.text =  DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy-MM-dd")
            cell.lblNeeded.text = "\(rowModel?.msnfp_minimum ?? 0)"
            
            return cell
            
        }else if(tableView == self.pastTableView){
            
            let  cell = tableView.dequeueReusableCell(withIdentifier: "PastEventTVC", for: indexPath) as! PastEventTVC
            if indexPath.row % 2 == 0{
                cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
                cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
            }else{
                cell.mainView.backgroundColor = UIColor.viewLightColor
                cell.seperaterView.backgroundColor = UIColor.gray
            }
            
            let rowModel = self.pastEventData?[indexPath.row]
            
            cell.lblEvent.text = rowModel?.msnfp_engagementopportunitytitle ?? ""
            //            cell.lblLocation.text = rowModel?.msnfp_location ?? ""
            cell.lblDate.text = DateFormatManager.shared.formatDateStrToStr(date: rowModel?.msnfp_endingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy-MM-dd")
            
            return cell
        }
        let cells = tableView.dequeueReusableCell(withIdentifier: "EmptyEventTableCell", for: indexPath) as! EmptyEventTableCell
        return cells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
