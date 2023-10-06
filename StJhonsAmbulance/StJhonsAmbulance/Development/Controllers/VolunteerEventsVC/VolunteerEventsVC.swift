//
//  VolunteerEventsVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 05/02/2023.
//

import UIKit

protocol VolunteerEventDetailDelegate {
    
//    func openEventDetailScreen(eventId:String)
    func openAvailableEventDetailScreen(rowModel: AvailableEventModel?)
    func openScheduleEventDetailScreen(rowModel: ScheduleModelThree?)
}
class VolunteerEventsVC: ENTALDBaseViewController,VolunteerEventDetailDelegate {

    var pastEventData : [VolunteerEventsModel]?
    var scheduleGroupData : [ScheduleGroupsModel]?
    var scheduleEngagementData : [ScheduleModelTwo]?
    var scheduleData : [ScheduleModelThree]?
    var availableEngagementData : [ScheduleModelTwo]?
    var availableData : [AvailableEventModel]?
    
    var filterAvailableData : [AvailableEventModel]?
    var filterScheduleData : [ScheduleModelThree]?
    var filterPastEventData : [VolunteerEventsModel]?
    
    var isAvailabilityTableSearch = false
    var isScheduleTableSearch = false
    var isPastTableSearch = false
    
    
    var isAvailableEventFilterApplied = false
    var isAvailableLocationFilterApplied = false
    var isAvailableDateFilterApplied = false
    var isAvailableStartFilterApplied = false
    var isAvailableEndFilterApplied = false
    
    var isScheduleEventFilterApplied = false
    var isScheduleLocationFilterApplied = false
    var isScheduleDateFilterApplied = false
    var isScheduleStartFilterApplied = false
    var isScheduleEndFilterApplied = false
    
    var isPastEventFilterApplied = false
    var isPastLocationFilterApplied = false
    var isPastDateFilterApplied = false
    var isPastStartFilterApplied = false
    var isPastEndFilterApplied = false
    
    var isAvailableLoadMoreShow = true
    var isScheduleLoadMoreShow = true
    var isPastLoadMoreShow = true
    
    @IBOutlet weak var pastLoadMoreView: UIView!
    @IBOutlet weak var btnPastLoadMore: UIButton!    
    @IBOutlet weak var scheduleLoadMoreView: UIView!
    @IBOutlet weak var btnScheduleLoadMore: UIButton!
    @IBOutlet weak var avilableLoadMoreView: UIView!
    @IBOutlet weak var btnAvilableLoadMore: UIButton!
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!

    @IBOutlet weak var btnAvailable: UIButton!
    @IBOutlet weak var btnSchedule: UIButton!
    @IBOutlet weak var btnPast: UIButton!
    
    @IBOutlet weak var vwAvailable: UIView!
    @IBOutlet weak var vwSchedule: UIView!
    @IBOutlet weak var vwPast: UIView!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    //    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var availableTable: UITableView!
    @IBOutlet weak var scheduleTable: UITableView!
    @IBOutlet weak var pastTable: UITableView!
    
    @IBOutlet weak var availableView: UIView!
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var pastView: UIView!
    
//    @IBOutlet weak var searchView: UIView!
//    @IBOutlet weak var searchImg: UIImageView!
//    @IBOutlet weak var textSearch: UITextField!
//    @IBOutlet weak var btnSearchClose: UIButton!
    
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        decorateUI()
//        getScheduleInfo()
//        getVolunteerPastEvent()
//        getAvailableInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getScheduleInfo()
        getVolunteerPastEvent()
        getAvailableInfo()
    }

    func decorateUI(){
        lblTitle.font = UIFont.HeaderBoldFont(18)
        lblTitle.textColor = UIColor.headerGreen
//        searchView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
//        searchView.layer.borderWidth = 1.5
//        searchView.isHidden = false
        
//        textSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        resetButtonView()
        self.availableView.isHidden = false
        isAvailabilityTableSearch = true
        vwAvailable.isHidden = false
        btnAvailable.setTitleColor(UIColor.themeColorSecondry, for: .normal)
        headerView.addBottomShadow()
        pastLoadMoreView.isHidden = true
        scheduleLoadMoreView.isHidden = true
        avilableLoadMoreView.isHidden = true
        
        btnAvilableLoadMore.layer.borderColor = UIColor.themeColorSecondry.cgColor
        btnAvilableLoadMore.layer.borderWidth = 1.0
        btnAvilableLoadMore.setTitle("Load More", for: .normal)
        btnAvilableLoadMore.setTitleColor(UIColor.themeColorSecondry, for: .normal)
        btnAvilableLoadMore.titleLabel?.font = UIFont.BoldFont(16)
        avilableLoadMoreView.isHidden = true
        
        btnScheduleLoadMore.layer.borderColor = UIColor.themeColorSecondry.cgColor
        btnScheduleLoadMore.layer.borderWidth = 1.0
        btnScheduleLoadMore.setTitle("Load More", for: .normal)
        btnScheduleLoadMore.setTitleColor(UIColor.themeColorSecondry, for: .normal)
        btnScheduleLoadMore.titleLabel?.font = UIFont.BoldFont(16)
        scheduleLoadMoreView.isHidden = true
        
        btnPastLoadMore.layer.borderColor = UIColor.themeColorSecondry.cgColor
        btnPastLoadMore.layer.borderWidth = 1.0
        btnPastLoadMore.setTitle("Load More", for: .normal)
        btnPastLoadMore.setTitleColor(UIColor.themeColorSecondry, for: .normal)
        btnPastLoadMore.titleLabel?.font = UIFont.BoldFont(16)
        pastLoadMoreView.isHidden = true 
    }
    
    func registerCells(){
        
        availableTable.delegate = self
        availableTable.dataSource = self
        availableTable.register(UINib(nibName: "VolunteersEventsTVC", bundle: nil), forCellReuseIdentifier: "VolunteersEventsTVC")
        
        scheduleTable.delegate = self
        scheduleTable.dataSource = self
        scheduleTable.register(UINib(nibName: "VolunteersEventsTVC", bundle: nil), forCellReuseIdentifier: "VolunteersEventsTVC")
        
        pastTable.delegate = self
        pastTable.dataSource = self
        pastTable.register(UINib(nibName: "VolunteersEventsTVC", bundle: nil), forCellReuseIdentifier: "VolunteersEventsTVC")

    }
    
    func openScheduleEventDetailScreen(rowModel: ScheduleModelThree?) {
        ENTALDControllers.shared.showVolunteerEventDetailScreen(type: .ENTALDPUSH, from: self, dataObj: rowModel, eventType : "schedule" )  { params, controller in
            self.getScheduleInfo()
           
        }
    }
    
    func openAvailableEventDetailScreen(rowModel: AvailableEventModel?) {
        ENTALDControllers.shared.showVolunteerEventDetailScreen(type: .ENTALDPUSH, from: self, dataObj: rowModel, eventType : "available" )  { params, controller in
           
            self.getAvailableInfo()
        }
    }
    
    @IBAction func searchCloseTapped(_ sender: Any) {
//        self.searchView.isHidden = true
//        textSearch.endEditing(true)
//        textSearch.text = ""
        filterScheduleData = scheduleData
        filterAvailableData = availableData
        filterPastEventData = pastEventData
        
        availableTable.reloadData()
        scheduleTable.reloadData()
        pastTable.reloadData()
    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
        ENTALDControllers.shared.showGroupMessageVC(type: .ENTALDPUSH, from: self, callBack: nil)
    }
    
    @IBAction func availableTapped(_ sender: Any) {
        
        resetButtonView()
        self.availableView.isHidden = false
        isAvailabilityTableSearch = true
        vwAvailable.isHidden = false
        btnAvailable.setTitleColor(UIColor.themeColorSecondry, for: .normal)
  
            if (filterAvailableData?.count == 0){
                emptyView.isHidden = false
            }
    }
    
    @IBAction func scheduleTapped(_ sender: Any) {
        
        resetButtonView()
        self.scheduleView.isHidden = false
        isScheduleTableSearch = true
        vwSchedule.isHidden = false
        btnSchedule.setTitleColor(UIColor.themeColorSecondry, for: .normal)

            if (filterScheduleData?.count == 0){
                emptyView.isHidden = false
            }
    }
    
    @IBAction func pastTapped(_ sender: Any) {
        resetButtonView()
        self.pastView.isHidden = false
        isPastTableSearch = true
        vwPast.isHidden = false
        btnPast.setTitleColor(UIColor.themeColorSecondry, for: .normal)
        if (filterPastEventData?.count == 0){
            emptyView.isHidden = false
        }
    }
    
    func resetButtonView(){
        
        
        
        self.availableView.isHidden = true
        self.scheduleView.isHidden = true
        self.pastView.isHidden = true
        
        isAvailabilityTableSearch = false
        isScheduleTableSearch = false
        isPastTableSearch = false
    
        vwAvailable.isHidden = true
        vwSchedule.isHidden = true
        vwPast.isHidden = true
        emptyView.isHidden = true
        
        btnAvailable.titleLabel?.textColor = UIColor.gray
        btnSchedule.titleLabel?.textColor = UIColor.gray
        btnPast.titleLabel?.textColor = UIColor.gray
        
        
    }
    
    
    @IBAction func pastLoadMoreTapped(_ sender: Any) {
        isPastLoadMoreShow = false
        DispatchQueue.main.async {
            self.pastLoadMoreView.isHidden = true
            self.pastTable.reloadData()
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func scheduleLoadMoreTapped(_ sender: Any) {
        isScheduleLoadMoreShow = false
        DispatchQueue.main.async {
            self.scheduleLoadMoreView.isHidden = true
            self.scheduleTable.reloadData()
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func availableLoadMoreTapped(_ sender: Any) {
        isAvailableLoadMoreShow = false
        DispatchQueue.main.async {
            self.avilableLoadMoreView.isHidden = true
            self.availableTable.reloadData()
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func addEventsTapped(_ sender: Any) {
        ENTALDControllers.shared.showCreateEventForm(type: .ENTALDPUSH, from: self) { params, controller in
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        btnSearchClose.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        btnSearchClose.isHidden = true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (textField.text != "" && isAvailabilityTableSearch == true ){
            
            filterAvailableData  =  availableData?.filter({
                if let name = $0.msnfp_engagementopportunitytitle, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                }
                return false
            })
            DispatchQueue.main.async {
                self.availableTable.reloadData()
            }
            
            
        }else if(textField.text != "" && isScheduleTableSearch == true ){
            
            filterScheduleData  =  scheduleData?.filter({
                if let name = $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                 }
               return false
             })
            
            DispatchQueue.main.async {
                self.scheduleTable.reloadData()
            }
            
        }else if(textField.text != "" && isPastTableSearch == true ){
            
            filterPastEventData  =  pastEventData?.filter({
                if let name = $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                }
                return false
            })
            DispatchQueue.main.async {
                self.pastTable.reloadData()
            }
            
        }else{
            DispatchQueue.main.async {
                self.filterAvailableData = self.availableData
                self.availableTable.reloadData()
                self.filterScheduleData = self.scheduleData
                self.scheduleTable.reloadData()
                self.filterPastEventData = self.pastEventData
                self.pastTable.reloadData()
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
    
  // ============================== API ========================
    
    func getVolunteerPastEvent(){
        guard let contactId = UserDefaults.standard.contactIdToken else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "_sjavms_volunteerevent_value,msnfp_schedulestatus,sjavms_start,msnfp_participationscheduleid,sjavms_end,sjavms_checkedin",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=msnfp_engagementopportunitytitle,msnfp_location)",
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
                    self.pastEventData = self.pastEventData?.sorted {
                        $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
                    }
                    self.filterPastEventData = pastEvents
                    if (self.pastEventData?.count == 0 || self.pastEventData?.count == nil){
                        self.showEmptyView(tableVw: self.pastTable)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.pastTable.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.pastTable.reloadData()
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

    
    func getScheduleInfo(){
      let groupList =   ProcessUtils.shared.groupListValue ?? ""
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_engagementopportunitystatus,msnfp_startingdate,msnfp_endingdate,msnfp_engagementopportunityid",
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=['{B651C666-CDC3-EB11-BACC-000D3A1FEB2E}','{80A4FB78-CDC3-EB11-BACC-000D3A1FEB2E}'])))",
            ParameterKeys.filter : "(statecode eq 0 and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002'])) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(groupList)]))))",
            ParameterKeys.orderby : "msnfp_startingdate asc"
        ]
        
        self.getScheduleInfoTwoData(params: params)
    }
    
    
    fileprivate func getScheduleInfoTwoData(params : [String:Any]){
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
        
        ENTALDLibraryAPI.shared.requestScheduleTwo(params: params){ result in
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }
            
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
            ParameterKeys.orderby : "sjavms_start asc"
        ]

        
        self.getScheduleInfoThreeData(params: params)
        
    }
    
    fileprivate func getScheduleInfoThreeData(params : [String:Any]){
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
        
        ENTALDLibraryAPI.shared.requestScheduleThree(params: params){ result in
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }
            
            switch result{
            case .success(value: let response):
                
                if let scheduleGroup = response.value {
                    self.scheduleData = scheduleGroup
                    self.scheduleData = self.scheduleData?.sorted {
                        $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
                    }
                    self.filterScheduleData = scheduleGroup
                    if (self.scheduleData?.count == 0 || self.scheduleData?.count == nil){
                        self.showEmptyView(tableVw: self.scheduleTable)
                        
                    }else{
                       
                        DispatchQueue.main.async {
                            for subview in self.scheduleTable.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.scheduleTable.reloadData()
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

    
    func getAvailableInfo(){
        
        let propertyValues = ProcessUtils.shared.groupListValue ?? ""
       
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_engagementopportunitystatus,msnfp_endingdate,msnfp_startingdate,msnfp_engagementopportunityid,_sjavms_program_value,msnfp_location,msnfp_maximum,msnfp_minimum,msnfp_multipledays",
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(propertyValues)])))",
            
            ParameterKeys.filter : "(Microsoft.Dynamics.CRM.In(PropertyName='statuscode',PropertyValues=['1','802280000']) and sjavms_adhocevent ne true and msnfp_engagementopportunitystatus eq 844060002 and (Microsoft.Dynamics.CRM.Today(PropertyName='msnfp_endingdate') or Microsoft.Dynamics.CRM.NextXYears(PropertyName='msnfp_endingdate',PropertyValue=10))) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(propertyValues)]))))",
       ParameterKeys.orderby : "msnfp_startingdate asc"
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
                    self.availableData = self.availableData?.sorted {
                        $0.msnfp_startingdate ?? "" < $1.msnfp_startingdate ?? ""
                    }
                    self.filterAvailableData = availableEvent
                    if (self.availableData?.count == 0 || self.availableData?.count == nil){
//                        self.showEmptyView(tableVw: self.availableTable)
                        DispatchQueue.main.async {
                            self.emptyView.isHidden = false
                        }
                        
                    }else{
                        DispatchQueue.main.async {
                            self.availableTable.reloadData()
//                            for subview in self.availableTable.subviews {
//                                subview.removeFromSuperview()
//                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.availableTable.reloadData()
                    }
                }else{
//                    self.showEmptyView(tableVw: self.availableTable)
                    DispatchQueue.main.async {
                        self.emptyView.isHidden = false
                    }
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



extension VolunteerEventsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == availableTable){
            if ((filterAvailableData?.count ?? 0) > 3 && isAvailableLoadMoreShow){
                avilableLoadMoreView.isHidden = false
                return 3
            }
            return filterAvailableData?.count ?? 0
        }else if (tableView == scheduleTable){
            if ((filterScheduleData?.count ?? 0) > 3 && isScheduleLoadMoreShow){
                scheduleLoadMoreView.isHidden = false
                return 3
            }
            return filterScheduleData?.count ?? 0
        }else if (tableView == pastTable){
            if ((filterPastEventData?.count ?? 0) > 3 && isPastLoadMoreShow){
                pastLoadMoreView.isHidden = false
                return 3
            }
            return filterPastEventData?.count ?? 0
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VolunteersEventsTVC", for: indexPath) as! VolunteersEventsTVC
        
        if (tableView == availableTable){
            let rowModel = self.filterAvailableData?[indexPath.row]
            cell.setContent(cellModel: rowModel, indx : indexPath.row)
            cell.delegate = self
        }else if (tableView == scheduleTable){
            let rowModel = self.filterScheduleData?[indexPath.row]
            cell.setContent(cellModel: rowModel , indx : indexPath.row)
            cell.delegate = self
        }else if (tableView == pastTable){
            let rowModel = self.filterPastEventData?[indexPath.row]
            cell.setContent(cellModel: rowModel)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == availableTable){
            
            ENTALDControllers.shared.showEventDetailScreen(type: .ENTALDPUSH, from: self, data: self.filterAvailableData?[indexPath.row], eventName: "availableEvent", callBack: nil)

        }else if (tableView == scheduleTable){
            
            ENTALDControllers.shared.showEventDetailScreen(type: .ENTALDPUSH, from: self, data: self.filterScheduleData?[indexPath.row], eventName: "scheduleEvent", callBack: nil)
            
        }else if (tableView == pastTable){
            
            ENTALDControllers.shared.showEventDetailScreen(type: .ENTALDPUSH, from: self, data: self.filterPastEventData?[indexPath.row], eventName: "pastEvent", callBack: nil)
        }
    }
}
