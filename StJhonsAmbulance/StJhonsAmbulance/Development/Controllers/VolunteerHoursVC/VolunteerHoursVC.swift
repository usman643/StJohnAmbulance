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
    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    
    }
    
    @IBAction func eventFilterTapped(_ sender: Any) {
        self.eventData = self.eventData?.reversed()
        DispatchQueue.main.async {
            self.eventTableView.reloadData()
        }
        
    }
    
    @IBAction func nonEventFilterTapped(_ sender: Any) {
        self.nonEventData = self.nonEventData?.reversed()
        DispatchQueue.main.async {
            self.nonEventTableView.reloadData()
        }
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
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=msnfp_engagementopportunitytitle,_sjavms_program_value)",
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
            
            ParameterKeys.select : "msnfp_schedulestatus,sjavms_start,sjavms_end,_sjavms_volunteerevent_value,_msnfp_engagementopportunityscheduleid_value,sjavms_hours,msnfp_participationscheduleid",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=msnfp_engagementopportunitytitle,_sjavms_program_value)",
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
}
