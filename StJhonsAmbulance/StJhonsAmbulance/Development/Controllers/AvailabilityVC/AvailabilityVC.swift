//
//  AvailabilityVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 15/02/2023.
//

import UIKit

class AvailabilityVC: ENTALDBaseViewController {

    
    var adhocData : [SideMenuHoursModel]?
    var volunteerHourData : [SideMenuHoursModel]?
    var availablityData : [AvailablityHourModel]?
    var programsData : [ProgramModel]?
    let contactId = UserDefaults.standard.contactIdToken ?? ""
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLabelView: UIView!
    @IBOutlet var allHeadingLabel: [UILabel]!
    
   
    @IBOutlet var allTableLabels: [UILabel]!
    
    @IBOutlet weak var adhocHeaderView: UIView!
    @IBOutlet weak var voluteerHourHeaderView: UIView!
    @IBOutlet weak var availablityHeaderView: UIView!
    @IBOutlet var allTableHeadingLabel: [UILabel]!
  
    
    @IBOutlet weak var adhocTableView: UITableView!
    @IBOutlet weak var voluteerHourTableView: UITableView!
    @IBOutlet weak var availablityTableView: UITableView!
    
    @IBOutlet weak var lblPending: UILabel!
    @IBOutlet weak var lblYeartoDate: UILabel!
    @IBOutlet weak var lblLifeTime: UILabel!
    
//    @IBOutlet weak var lblTabTitle: UILabel!
//    @IBOutlet weak var selectedTabImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
        setupContent()
        registerCell()
    }
    
    func registerCell(){
        adhocTableView.delegate = self
        voluteerHourTableView.delegate = self
        availablityTableView.delegate = self
        adhocTableView.dataSource = self
        voluteerHourTableView.dataSource = self
        availablityTableView.dataSource = self
        adhocTableView.register(UINib(nibName: "AdhocHourTVC", bundle: nil), forCellReuseIdentifier: "AdhocHourTVC")
        voluteerHourTableView.register(UINib(nibName: "VolunteerHourAvailabilityTVC", bundle: nil), forCellReuseIdentifier: "VolunteerHourAvailabilityTVC")
        
        availablityTableView.register(UINib(nibName: "AvailabilityTVC", bundle: nil), forCellReuseIdentifier: "AvailabilityTVC")
    }
    
    func setupContent(){
        lblPending.text = UserDefaults.standard.userInfo?.sjavms_totalpendinghrs?.getFormattedNumber()
        lblYeartoDate.text = UserDefaults.standard.userInfo?.sjavms_totalhourscompletedthisyear?.getFormattedNumber()
        lblLifeTime.text = UserDefaults.standard.userInfo?.msnfp_totalengagementhours?.getFormattedNumber()
        
        self.getAllProgramesfile( completion: {status in
            
            self.getAdhocHour()
            self.getAvailability()
            self.getVolunteerHour()
        })
        
        
    }

    func decorateUI(){
        
//        headerView.layer.borderWidth = 1
//        headerView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        
        headerLabelView.layer.borderWidth = 1
        headerLabelView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        
        adhocHeaderView.layer.borderWidth = 1
        adhocHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        availablityHeaderView.layer.borderWidth = 1
        availablityHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        voluteerHourHeaderView.layer.borderWidth = 1
        voluteerHourHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        
        
        for lbltext in allTableHeadingLabel{
            lbltext.font = UIFont.BoldFont(12)
            lbltext.textColor = UIColor.themePrimaryColor
        }
        
        for lbltext in allHeadingLabel{
            lbltext.font = UIFont.BoldFont(14)
            lbltext.textColor = UIColor.themePrimaryWhite
        }
        
        for lbltext in allTableLabels{
            lbltext.font = UIFont.BoldFont(10)
            lbltext.textColor = UIColor.themePrimaryWhite
        }
        
        lblPending.textColor = UIColor.themePrimaryWhite
        lblPending.font = UIFont.BoldFont(16)
        lblYeartoDate.textColor = UIColor.themePrimaryWhite
        lblYeartoDate.font = UIFont.BoldFont(16)
        lblLifeTime.textColor = UIColor.themePrimaryWhite
        lblLifeTime.font = UIFont.BoldFont(16)
//        lblTabTitle.textColor = UIColor.themePrimaryColor
//        lblTabTitle.font = UIFont.BoldFont(16)
//        
//        selectedTabImg.image = selectedTabImg.image?.withRenderingMode(.alwaysTemplate)
//        selectedTabImg.tintColor = UIColor.themePrimaryColor
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
    
    }
    
    @IBAction func adhocFilterTapped(_ sender: Any) {
        self.adhocData = self.adhocData?.reversed()
        DispatchQueue.main.async {
            self.adhocTableView.reloadData()
        }
        
    }
    
    @IBAction func volunteerFilterTapped(_ sender: Any) {
        self.volunteerHourData = self.volunteerHourData?.reversed()
        DispatchQueue.main.async {
            self.voluteerHourTableView .reloadData()
        }
    }
    
    @IBAction func availablityFilterTapped(_ sender: Any) {
        self.availablityData = self.availablityData?.reversed()
        DispatchQueue.main.async {
            self.availablityTableView.reloadData()
        }
    }

    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
    




// ============================  API  ===============================



    
    private func getAllProgramesfile( completion: @escaping(_ status:Bool)->Void) {
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestAllProgram(params: [:]){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let pastEvent = response.value {
                    self.programsData = pastEvent
                    ProcessUtils.shared.programsData = self.programsData
//                    self.eventProgramData = self.getProgramName(self.eventData?._sjavms_program_value ?? "")
                    
                    DispatchQueue.main.async {
//                        self.lblProgramType.text = self.eventProgramData?.sjavms_name ?? ""
                        //contact info
                    }
//                    self.getAdhocHour()
//                    self.getAvailability()
//                    self.getVolunteerHour()
                    
                }
                completion(true)
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                completion(false)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
            
        }
        
        
    }

    func getAvailability(){
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_availabilitytitle,msnfp_effectivefrom,msnfp_effectiveto,msnfp_workingdays,msnfp_availabilityid",
            ParameterKeys.filter : "(_msnfp_contactid_value eq \(self.contactId))",
            ParameterKeys.orderby : "msnfp_effectivefrom desc"
            
        ]
        
        self.getAvailabilityData(params: params)
    }
    
    fileprivate func getAvailabilityData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestSideMenuAvailablityHour(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let availablity = response.value {
                    self.availablityData = availablity
                    if (self.availablityData?.count == 0 || self.availablityData?.count == nil){
                        self.showEmptyView(tableVw: self.availablityTableView)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.availablityTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.availablityTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.availablityTableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
               
                self.showEmptyView(tableVw: self.availablityTableView)
                
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    func getVolunteerHour(){
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_schedulestatus,sjavms_start,sjavms_end,_sjavms_volunteerevent_value,_msnfp_engagementopportunityscheduleid_value,sjavms_hours,msnfp_participationscheduleid",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=_sjavms_program_value,msnfp_engagementopportunitytitle),msnfp_engagementOpportunityScheduleId($select=msnfp_shiftname,msnfp_engagementopportunityschedule)",
            ParameterKeys.filter : "(statecode eq 0 and _sjavms_volunteer_value eq \(self.contactId)) and (sjavms_VolunteerEvent/sjavms_adhocevent ne true)",
            ParameterKeys.orderby : "_sjavms_volunteerevent_value asc,msnfp_schedulestatus desc"
            
        ]
        self.getVolunteerHourData(params: params)
    }
    
    
    fileprivate func getVolunteerHourData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestSideMenuVolunteerHour(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let hours = response.value {
                    self.volunteerHourData = hours
                    if (self.volunteerHourData?.count == 0 || self.volunteerHourData?.count == nil){
                        self.showEmptyView(tableVw: self.voluteerHourTableView)
                    }else{
//                        for i in (0 ..< (self.adhocData?.count ?? 0)) {
//
//                            self.volunteerHourData?[i].program_name = self.getProgramName(self.volunteerHourData?[i].sjavms_VolunteerEvent?._sjavms_program_value  ?? "")
//
//                        }
                        DispatchQueue.main.async {
                            for subview in self.voluteerHourTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.voluteerHourTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.voluteerHourTableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
               
                self.showEmptyView(tableVw: self.voluteerHourTableView)
                
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    
    func getAdhocHour(){
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_schedulestatus,sjavms_hours,msnfp_participationscheduleid",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=msnfp_engagementopportunitytitle,_sjavms_program_value)",
            ParameterKeys.filter : "(statecode eq 0 and _sjavms_volunteer_value eq \(self.contactId)) and (sjavms_VolunteerEvent/sjavms_adhocevent eq true)",
            ParameterKeys.orderby : "msnfp_schedulestatus desc"
            
        ]
        self.getAdhocHourData(params: params)
    }
    
    
    fileprivate func getAdhocHourData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestAdhocHour(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let hours = response.value {
                    self.adhocData = hours
                    if (self.adhocData?.count == 0 || self.adhocData?.count == nil){
                        self.showEmptyView(tableVw: self.adhocTableView)
                    }else{
                        
//                        for i in (0 ..< (self.adhocData?.count ?? 0)) {
//
//                            self.adhocData?[i].program_name = self.getProgramName(self.adhocData?[i].sjavms_VolunteerEvent?._sjavms_program_value ?? "")
//
//                        }
                        
                        
                        
                        DispatchQueue.main.async {
                            for subview in self.adhocTableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.adhocTableView.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.adhocTableView)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
               
                self.showEmptyView(tableVw: self.adhocTableView)
                
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    func getProgramName(_ programId:String)->String?{
        let programName = self.programsData?.filter({$0.sjavms_programid == programId}).first?.sjavms_name
        return programName
    }
    

}


extension AvailabilityVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.adhocTableView){
            return adhocData?.count ?? 0
        }else if (tableView == voluteerHourTableView){
            return volunteerHourData?.count ?? 0
        }else if (tableView == availablityTableView){
            return availablityData?.count ?? 0
        }

        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        if (tableView == self.adhocTableView){
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdhocHourTVC", for: indexPath) as! AdhocHourTVC

            if indexPath.row % 2 == 0{
                cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
                cell.seperatorView.backgroundColor = UIColor.themePrimaryColor
            }else{
                cell.backgroundColor = UIColor.viewLightColor
                cell.seperatorView.backgroundColor = UIColor.gray
            }

            let rowModel = self.adhocData?[indexPath.row]
            let programName = self.getProgramName(rowModel?.sjavms_VolunteerEvent?._sjavms_program_value ?? "")
            cell.setContent(cellModel: rowModel , programName: programName)
            return cell

        }else if (tableView == voluteerHourTableView){

            let cell = tableView.dequeueReusableCell(withIdentifier: "VolunteerHourAvailabilityTVC", for: indexPath) as! VolunteerHourAvailabilityTVC

            if indexPath.row % 2 == 0{
                cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
                cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
            }else{
                cell.backgroundColor = UIColor.viewLightColor
                cell.seperaterView.backgroundColor = UIColor.gray
            }
            let rowModel = self.volunteerHourData?[indexPath.row]
            let programName = self.getProgramName(rowModel?.sjavms_VolunteerEvent?._sjavms_program_value ?? "")
            cell.setContent(cellModel: rowModel , programName: programName)
            return cell

        }else if (tableView == availablityTableView){

            let cell = tableView.dequeueReusableCell(withIdentifier: "AvailabilityTVC", for: indexPath) as! AvailabilityTVC

            if indexPath.row % 2 == 0{
                cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
                cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
            }else{
                cell.backgroundColor = UIColor.viewLightColor
                cell.seperaterView.backgroundColor = UIColor.gray
            }
            let rowModel = self.availablityData?[indexPath.row]
            cell.setContent(cellModel: rowModel)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AvailabilityTVC", for: indexPath) as! AvailabilityTVC
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
}

