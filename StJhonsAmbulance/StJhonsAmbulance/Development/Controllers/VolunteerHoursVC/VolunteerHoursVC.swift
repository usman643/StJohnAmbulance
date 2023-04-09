//
//  VolunteerHoursVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 07/02/2023.
//

import UIKit

class VolunteerHoursVC: ENTALDBaseViewController {
    
    var eventData : [PendingShiftModelTwo]?
    var nonEventData : [PendingShiftModelTwo]?
    
    var isEventFilterApplied = false
    var isEventDateFilterApplied = false
    var isEventStartFilterApplied = false
    var isEventEndFilterApplied = false
    var isEventTotalFilterApplied = false
    
    var isNonEventFilterApplied = false
    var isNonEventDateFilterApplied = false
    var isNonEventStartFilterApplied = false
    var isNonEventEndFilterApplied = false
    var isNonEventTotalFilterApplied = false
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet var allHeadingLabel: [UILabel]!
    @IBOutlet weak var eventHeaderView: UIView!
    @IBOutlet weak var nonEventHeaderView: UIView!
    @IBOutlet var allTableHeadingLabel: [UILabel]!
    @IBOutlet weak var lblEventHeading: UILabel!
    @IBOutlet weak var lblNonEventHeading: UILabel!
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var nonEventTableView: UITableView!
    
    @IBOutlet weak var btnCreateAdhocHour: UIButton!
    @IBOutlet weak var lblPending: UILabel!
    @IBOutlet weak var lblYeartoDate: UILabel!
    @IBOutlet weak var lblLifeTime: UILabel!
    
    @IBOutlet weak var lblTabTitle: UILabel!
    @IBOutlet weak var selectedTabImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getVolunteerNonEvent()
        getVolunteerEvents()
        setupContent()
        self.decorateUI()
    }

    func registerCell(){
                eventTableView.delegate = self
                nonEventTableView.delegate = self
                eventTableView.dataSource = self
                nonEventTableView.dataSource = self
                eventTableView.register(UINib(nibName: "VoluteerHoursTVC", bundle: nil), forCellReuseIdentifier: "VoluteerHoursTVC")
                nonEventTableView.register(UINib(nibName: "VoluteerHoursTVC", bundle: nil), forCellReuseIdentifier: "VoluteerHoursTVC")
    }
    
    func setupContent(){
        lblPending.text = UserDefaults.standard.userInfo?.sjavms_totalpendinghrs?.getFormattedNumber()
        lblYeartoDate.text = UserDefaults.standard.userInfo?.sjavms_totalhourscompletedthisyear?.getFormattedNumber()
        lblLifeTime.text = UserDefaults.standard.userInfo?.msnfp_totalengagementhours?.getFormattedNumber()
    }

    func decorateUI(){
        headerView.layer.borderWidth = 1
        headerView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        eventHeaderView.layer.borderWidth = 1
        eventHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        nonEventHeaderView.layer.borderWidth = 1
        nonEventHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        
        for lbltext in allTableHeadingLabel{
            lbltext.font = UIFont.BoldFont(12)
            lbltext.textColor = UIColor.themePrimaryWhite
        }
        
        for lbltext in allHeadingLabel{
            lbltext.font = UIFont.BoldFont(14)
            lbltext.textColor = UIColor.themeBlackText
        }
        
        lblEventHeading.font = UIFont.BoldFont(18)
        lblEventHeading.textColor = UIColor.themePrimaryWhite
        lblNonEventHeading.font = UIFont.BoldFont(18)
        lblNonEventHeading.textColor = UIColor.themePrimaryWhite
        
        lblTabTitle.textColor = UIColor.themePrimaryColor
        lblTabTitle.font = UIFont.BoldFont(16)
        
        selectedTabImg.image = selectedTabImg.image?.withRenderingMode(.alwaysTemplate)
        selectedTabImg.tintColor = UIColor.themePrimaryColor
        btnCreateAdhocHour.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnCreateAdhocHour.titleLabel?.font = UIFont.BoldFont(13)
        btnCreateAdhocHour.layer.cornerRadius = 5
    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    
    }
    
    @IBAction func createAdhocHour(_ sender: Any) {
        
        ENTALDControllers.shared.showAddAdhocHourScreen(type: .ENTALDPUSH, from: self) { params, controller in
            
            if(params as? Int == 1){
                self.getVolunteerNonEvent()
                self.getVolunteerEvents()
                self.setupContent()
            }
        }
    }
    
    // ==================== Filter =====================
    
    
    @IBAction func eventFilterTapped(_ sender: Any) {
        if !isEventFilterApplied{
            self.eventData = self.eventData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" < $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isEventFilterApplied = true
        }else{
            self.eventData = self.eventData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" > $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isEventFilterApplied = false
        }

        DispatchQueue.main.async {
            self.eventTableView.reloadData()
        }

        isEventDateFilterApplied = false
        isEventStartFilterApplied = false
        isEventEndFilterApplied = false
        isEventTotalFilterApplied = false
        
    }
    
    @IBAction func nonEventFilterTapped(_ sender: Any) {
        if !isNonEventFilterApplied{
            self.nonEventData = self.nonEventData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" < $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isNonEventFilterApplied = true
        }else{
            self.nonEventData = self.nonEventData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" > $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isNonEventFilterApplied = false
        }

        DispatchQueue.main.async {
            self.nonEventTableView.reloadData()
        }

        isNonEventDateFilterApplied = false
        isNonEventStartFilterApplied = false
        isNonEventEndFilterApplied = false
        isNonEventTotalFilterApplied = false
    }
    
    
    @IBAction func eventFilter(_ sender: Any) {
        
        if !isEventFilterApplied{
            self.eventData = self.eventData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" < $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isEventFilterApplied = true
        }else{
            self.eventData = self.eventData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" > $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isEventFilterApplied = false
        }

        DispatchQueue.main.async {
            self.eventTableView.reloadData()
        }

        isEventDateFilterApplied = false
        isEventStartFilterApplied = false
        isEventEndFilterApplied = false
        isEventTotalFilterApplied = false
    }
    
    @IBAction func eventDateFilter(_ sender: Any) {
        
        if !isEventDateFilterApplied{
            self.eventData = self.eventData?.sorted {
                $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
            }
            isEventDateFilterApplied = true
        }else{
            self.eventData = self.eventData?.sorted {
                $0.sjavms_start ?? "" > $1.sjavms_start ?? ""
            }
            isEventDateFilterApplied = false
        }

        DispatchQueue.main.async {
            self.eventTableView.reloadData()
        }
        
        isEventFilterApplied = false
        isEventStartFilterApplied = false
        isEventEndFilterApplied = false
        isEventTotalFilterApplied = false
    }
    
    @IBAction func eventStartFilter(_ sender: Any) {
        
        if !isEventStartFilterApplied{
            self.eventData = self.eventData?.sorted {
                $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
            }
            isEventStartFilterApplied = true
        }else{
            self.eventData = self.eventData?.sorted {
                $0.sjavms_start ?? "" > $1.sjavms_start ?? ""
            }
            isEventStartFilterApplied = false
        }

        DispatchQueue.main.async {
            self.eventTableView.reloadData()
        }
        isEventFilterApplied = false
        isEventDateFilterApplied = false
        isEventEndFilterApplied = false
        isEventTotalFilterApplied = false
    }
    
    @IBAction func eventEndFilter(_ sender: Any) {
        if !isEventEndFilterApplied{
            self.eventData = self.eventData?.sorted {
                $0.sjavms_end ?? "" < $1.sjavms_end ?? ""
            }
            isEventEndFilterApplied = true
        }else{
            self.eventData = self.eventData?.sorted {
                $0.sjavms_end ?? "" > $1.sjavms_end ?? ""
            }
            isEventEndFilterApplied = false
        }

        DispatchQueue.main.async {
            self.eventTableView.reloadData()
        }
        
        isEventFilterApplied = false
        isEventDateFilterApplied = false
        isEventStartFilterApplied = false
        isEventTotalFilterApplied = false
    }
    
    @IBAction func eventTotalFilter(_ sender: Any) {
        
        if !isEventTotalFilterApplied{
            self.eventData = self.eventData?.sorted {
                $0.sjavms_hours ?? 0 < $1.sjavms_hours ?? 0
            }
            isEventTotalFilterApplied = true
        }else{
            self.eventData = self.eventData?.sorted {
                $0.sjavms_hours ?? 0 > $1.sjavms_hours ?? 0
            }
            isEventTotalFilterApplied = false
        }

        DispatchQueue.main.async {
            self.eventTableView.reloadData()
        }
        
        isEventFilterApplied = false
        isEventDateFilterApplied = false
        isEventStartFilterApplied = false
        isEventEndFilterApplied = false
    }
    
    
    
    
    @IBAction func nonEventFilter(_ sender: Any) {
        
        if !isNonEventFilterApplied{
            self.nonEventData = self.nonEventData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" < $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isNonEventFilterApplied = true
        }else{
            self.nonEventData = self.nonEventData?.sorted {
                $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? "" > $1.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
            isNonEventFilterApplied = false
        }

        DispatchQueue.main.async {
            self.nonEventTableView.reloadData()
        }

        isNonEventDateFilterApplied = false
        isNonEventStartFilterApplied = false
        isNonEventEndFilterApplied = false
        isNonEventTotalFilterApplied = false
    }
    
    @IBAction func nonEventDateFilter(_ sender: Any) {
        if !isNonEventDateFilterApplied{
            self.nonEventData = self.nonEventData?.sorted {
                $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
            }
            isNonEventDateFilterApplied = true
        }else{
            self.nonEventData = self.nonEventData?.sorted {
                $0.sjavms_start ?? "" > $1.sjavms_start ?? ""
            }
            isNonEventDateFilterApplied = false
        }

        DispatchQueue.main.async {
            self.nonEventTableView.reloadData()
        }
        isNonEventFilterApplied = false
        isNonEventStartFilterApplied = false
        isNonEventEndFilterApplied = false
        isNonEventTotalFilterApplied = false
        
    }
    
    @IBAction func nonEventStartFilter(_ sender: Any) {
        
        if !isNonEventStartFilterApplied{
            self.nonEventData = self.nonEventData?.sorted {
                $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
            }
            isNonEventStartFilterApplied = true
        }else{
            self.nonEventData = self.nonEventData?.sorted {
                $0.sjavms_start ?? "" > $1.sjavms_start ?? ""
            }
            isNonEventStartFilterApplied = false
        }

        DispatchQueue.main.async {
            self.nonEventTableView.reloadData()
        }
        
        isNonEventFilterApplied = false
        isNonEventDateFilterApplied = false
        isNonEventEndFilterApplied = false
        isNonEventTotalFilterApplied = false
    }
    
    @IBAction func nonEventEndFilter(_ sender: Any) {
        
        if !isNonEventEndFilterApplied{
            self.nonEventData = self.nonEventData?.sorted {
                $0.sjavms_end ?? "" < $1.sjavms_end ?? ""
            }
            isNonEventEndFilterApplied = true
        }else{
            self.nonEventData = self.nonEventData?.sorted {
                $0.sjavms_end ?? "" > $1.sjavms_end ?? ""
            }
            isNonEventEndFilterApplied = false
        }

        DispatchQueue.main.async {
            self.nonEventTableView.reloadData()
        }
        
        isNonEventFilterApplied = false
        isNonEventDateFilterApplied = false
        isNonEventStartFilterApplied = false
        isNonEventTotalFilterApplied = false
    }
    
    @IBAction func nonEventTotalFilter(_ sender: Any) {
        
        if !isNonEventTotalFilterApplied{
            self.nonEventData = self.nonEventData?.sorted {
                $0.sjavms_hours ?? 0 < $1.sjavms_hours ?? 0
            }
            isNonEventTotalFilterApplied = true
        }else{
            self.nonEventData = self.nonEventData?.sorted {
                $0.sjavms_hours ?? 0 > $1.sjavms_hours ?? 0
            }
            isNonEventTotalFilterApplied = false
        }

        DispatchQueue.main.async {
            self.nonEventTableView.reloadData()
        }
        
        isNonEventFilterApplied = false
        isNonEventDateFilterApplied = false
        isNonEventStartFilterApplied = false
        isNonEventEndFilterApplied = false
    }
    
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        
        present(menu!, animated: true)
    }
    
    
    // Bottom bar Action
    
    @IBAction func openLatestEventScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.callbackToController?("latestEvent", self)
    }
    
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
    
    
    func getVolunteerEvents(){
        guard let contactId = UserDefaults.standard.contactIdToken else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_schedulestatus,sjavms_hours,msnfp_participationscheduleid,sjavms_start,sjavms_end",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=sjavms_eventrequirements,msnfp_street2,msnfp_zippostalcode,msnfp_city,msnfp_engagementopportunitytitle,msnfp_location,msnfp_stateprovince,msnfp_street3,_sjavms_program_value,msnfp_street1)",
            ParameterKeys.filter : "(statecode eq 0 and _sjavms_volunteer_value eq \(contactId)) and (sjavms_VolunteerEvent/sjavms_adhocevent eq true)",
            ParameterKeys.orderby : "msnfp_schedulestatus desc"
        ]
        
        self.getVolunteerEventsData(params: params)
    }
    
    fileprivate func getVolunteerEventsData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerEvent(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let pendingData = response.value {
                    self.eventData = pendingData
                    if (self.eventData?.count == 0 || self.eventData?.count == nil){
                        self.showEmptyView(tableVw: self.eventTableView)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.eventTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.eventTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.eventTableView)
                }
            
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.eventTableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    func getVolunteerNonEvent(){
        guard let contactId = UserDefaults.standard.contactIdToken else {return}
        let params : [String:Any] = [
            
        
            ParameterKeys.select :
                "msnfp_schedulestatus,sjavms_start,sjavms_end,_sjavms_volunteerevent_value,_msnfp_engagementopportunityscheduleid_value,sjavms_hours,msnfp_participationscheduleid,statecode",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=sjavms_eventrequirements,msnfp_street2,msnfp_zippostalcode,msnfp_city,msnfp_engagementopportunitytitle,msnfp_location,msnfp_stateprovince,msnfp_street3,_sjavms_program_value,msnfp_street1)",
            
            
            ParameterKeys.filter : "(statecode eq 0 and _sjavms_volunteer_value eq \(contactId)) and (sjavms_VolunteerEvent/sjavms_adhocevent ne true)",
            ParameterKeys.orderby : "_sjavms_volunteerevent_value asc,msnfp_schedulestatus desc"
        ]
        
        self.getVolunteerNonEventData(params: params)
    }
    
    fileprivate func getVolunteerNonEventData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerNonEvent(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let pendingData = response.value {
                    self.nonEventData = pendingData
                    if (self.nonEventData?.count == 0 || self.nonEventData?.count == nil){
                        self.showEmptyView(tableVw: self.nonEventTableView)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.nonEventTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.nonEventTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.nonEventTableView)
                }
            
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.nonEventTableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
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


extension VolunteerHoursVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.eventTableView){
            return eventData?.count ?? 0
        }else if (tableView == nonEventTableView){
            return nonEventData?.count ?? 0
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VoluteerHoursTVC", for: indexPath) as! VoluteerHoursTVC
        
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
            cell.seperatorView.backgroundColor = UIColor.themePrimaryColor
        }else{
            cell.backgroundColor = UIColor.viewLightColor
            cell.seperatorView.backgroundColor = UIColor.gray
        }
        
        if (tableView == self.eventTableView){
            let rowModel = self.eventData?[indexPath.row]
            cell.setContent(cellModel: rowModel)
            
        }else if (tableView == nonEventTableView){
            let rowModel = self.nonEventData?[indexPath.row]
            cell.setContent(cellModel: rowModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (tableView == self.eventTableView){
            let rowModel = self.eventData?[indexPath.row]
            
//            ENTALDControllers.shared.showVolunteerHourDetailScreen(type: .ENTALDPUSH, from: self, dataObj : rowModel) { params, controller in
//                if(params as? Int == 1){
//                    self.getVolunteerEvents()
//                }
//            }
            
            
            
        }else if (tableView == nonEventTableView){
            let rowModel = self.nonEventData?[indexPath.row]
            
            ENTALDControllers.shared.showVolunteerHourDetailScreen(type: .ENTALDPUSH, from: self, dataObj : rowModel) { params, controller in
                if(params as? Int == 1){
                    self.getVolunteerNonEvent()
                }
            }
        }
    }
    
    
}
