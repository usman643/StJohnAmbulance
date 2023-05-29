//
//  EventManageVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 05/02/2023.
//

import UIKit
import GoogleMaps
protocol updateVolunteerCheckInDelegate {
    
    func updateVolunteerCheckIn(participationId:String , param : [String:Bool])
   
}

class EventManageVC: ENTALDBaseViewController, UITextFieldDelegate,updateVolunteerCheckInDelegate {
    
    let currentDate = DateFormatManager.shared.getCurrentDateWithFormat(format: "yyyy/MM/dd") 
    var volunteerData : [VolunteerOfEventDataModel]?
    var eventData : CurrentEventsModel?
    
    var pendingShiftData : PendingShiftModelTwo?
    var pendingEventApprovalData : PendingApprovalEventsModel?
    var unpublishEventData : CurrentEventsModel?
    
    @IBOutlet weak var mapContainerVu: UIView!
    @IBOutlet weak var v_ContainerVU: UIView!
    @IBOutlet weak var C_Segments: UISegmentedControl!
    var dataVol : [String:Any] = [:]
    var volentierResultData : [String:Any] = [:]
    var filteredData : [String:Any] = [:]
    var programsData : [ProgramModel]?
    var eventProgramData : ProgramModel?
    var contactInfo : [ContactDataModel]?
    
    private lazy var mapView: GMSMapView = {
        let map = GMSMapView()
        return map
    }()
    
    var mapCoords : [MapCoordsModel] = []
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblProgramType: UILabel!
    @IBOutlet weak var btnProgram: UIButton!
    @IBOutlet weak var btnContact: UIButton!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearchClose: UIButton!
    @IBOutlet weak var btnAddVolunteer: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMapView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "EventManagerSectionView", bundle: nil), forHeaderFooterViewReuseIdentifier: "EventManagerSectionView")
        tableView.register(UINib(nibName: "EventManagerTVC", bundle: nil), forCellReuseIdentifier: "EventManagerTVC")
        
        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        decorateUI()
        setupData()
        getVolunteers()
        getAllProgramesfile()
    }
    
    func setupData(){
        
        if ((eventData) != nil){
            
            lblEventName.text = eventData?.msnfp_engagementopportunitytitle
            if (eventData?.msnfp_startingdate != nil && eventData?.msnfp_startingdate != ""){
                let date =  DateFormatManager.shared.formatDateStrToStr(date: eventData?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEEE, MMMM d, yyyy")
                lblDate.text = date

               let dayRemaining = DateFormatManager.shared.dayRemaining(date: eventData?.msnfp_startingdate ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")
                if dayRemaining > 0 {
                    DispatchQueue.main.async {
                        self.btnProgram.isEnabled = true
                        self.btnProgram.backgroundColor = UIColor.redPinkColor
                        self.btnProgram.setTitle("Cancel Event", for: .normal)
                    }
                }else{
                    DispatchQueue.main.async {
                        self.btnProgram.isEnabled = false
                        self.btnProgram.backgroundColor = UIColor.lightGray
                        self.btnProgram.setTitle("Cancel Event", for: .normal)
                    }
                }
                
                if(DateFormatManager.shared.isDatePassed(date: eventData?.msnfp_endingdate ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")){
                    DispatchQueue.main.async {
                        self.btnProgram.isEnabled = true
                        self.btnProgram.backgroundColor = UIColor.redPinkColor
                        self.btnProgram.setTitle("Close Event", for: .normal)
                    }
                    
                }
                
                
            }else{
                lblDate.text = " "
            }
            lblLocation.text = eventData?.msnfp_location
            
            
            
        }else if ((pendingShiftData) != nil){
            
            lblEventName.text = pendingShiftData?.msnfp_name
            if (pendingShiftData?.sjavms_start != nil && pendingShiftData?.sjavms_start != ""){
                let date =  DateFormatManager.shared.formatDateStrToStr(date: pendingShiftData?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "EEEE, MMMM d, yyyy")
                lblDate.text = date
                
                let dayRemaining = DateFormatManager.shared.dayRemaining(date: pendingShiftData?.sjavms_start ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")
                 if dayRemaining > 0 {
                     
                     self.btnProgram.isEnabled = true
                     btnProgram.backgroundColor = UIColor.redPinkColor
                     btnProgram.setTitle("Cancel Event", for: .normal)
                 }
                 
                 if(DateFormatManager.shared.isDatePassed(date: pendingShiftData?.sjavms_end ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")){
                     self.btnProgram.isEnabled = true
                     self.btnProgram.backgroundColor = UIColor.redPinkColor
                     self.btnProgram.setTitle("Close Event", for: .normal)
                 }
            }else{
                lblDate.text = " "
            }
        }else if ((unpublishEventData) != nil){
            
            lblEventName.text = unpublishEventData?.msnfp_engagementopportunitytitle
            if (unpublishEventData?.msnfp_startingdate != nil && unpublishEventData?.msnfp_startingdate != ""){
                let date =  DateFormatManager.shared.formatDateStrToStr(date: unpublishEventData?.msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
                lblDate.text = date
                if(DateFormatManager.shared.isDatePassed(date: unpublishEventData?.msnfp_startingdate ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")){
                    self.btnProgram.isEnabled = false
                    btnProgram.backgroundColor = UIColor.lightGray
                    btnProgram.setTitle("Event Passed", for: .normal)
                }
                
                
                let dayRemaining = DateFormatManager.shared.dayRemaining(date: unpublishEventData?.msnfp_startingdate ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")
                 if dayRemaining > 0 {
                     
                     self.btnProgram.isEnabled = true
                     btnProgram.backgroundColor = UIColor.redPinkColor
                     btnProgram.setTitle("Cance Event", for: .normal)
                 }
                 
                 if(DateFormatManager.shared.isDatePassed(date: unpublishEventData?.msnfp_endingdate ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")){
                     self.btnProgram.isEnabled = true
                     self.btnProgram.backgroundColor = UIColor.redPinkColor
                     self.btnProgram.setTitle("Close Event", for: .normal)
                 }
                
                
                
                
                
                
                
            }else{
                lblDate.text = " "
            }
            lblLocation.text = unpublishEventData?.msnfp_location
            
        }else if ((pendingEventApprovalData) != nil){
            
            lblEventName.text = pendingEventApprovalData?.sjavms_name
            if (pendingEventApprovalData?.sjavms_eventstartdate != nil && pendingEventApprovalData?.sjavms_eventstartdate == ""){
                let date =  DateFormatManager.shared.formatDateStrToStr(date: pendingEventApprovalData?.sjavms_eventstartdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
                lblDate.text = date
                let dayRemaining = DateFormatManager.shared.dayRemaining(date: pendingEventApprovalData?.sjavms_eventstartdate  ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")
                 if dayRemaining > 0 {
                     
                     self.btnProgram.isEnabled = true
                     btnProgram.backgroundColor = UIColor.redPinkColor
                     btnProgram.setTitle("Cance Event", for: .normal)
                 }
                 
                 if(DateFormatManager.shared.isDatePassed(date: pendingEventApprovalData?.sjavms_eventstartdate  ?? "", format: "yyyy-MM-dd'T'HH:mm:ss'Z'")){
                     self.btnProgram.isEnabled = true
                     self.btnProgram.backgroundColor = UIColor.redPinkColor
                     self.btnProgram.setTitle("Close Event", for: .normal)
                 }
            }else{
                lblDate.text = " "
            }
            //            lblLocation.text = pendingEventApprovalData?.
            
        }
        
    }
    
    func decorateUI(){
        
        btnBack.tintColor = .white
        
        lblEventName.font = UIFont.BoldFont(22)
        lblDate.font = UIFont.BoldFont(16)
        lblLocation.font = UIFont.BoldFont(16)
        lblProgramType.font = UIFont.BoldFont(16)
        lblTitle.font = UIFont.BoldFont(22)
        
        lblEventName.textColor = UIColor.textWhiteColor
        lblDate.textColor = UIColor.textWhiteColor
        lblLocation.textColor = UIColor.textWhiteColor
        lblProgramType.textColor = UIColor.red
        lblTitle.textColor = UIColor.darkBlueColor
        
        btnContact.titleLabel?.font = UIFont.BoldFont(16)
        btnProgram.titleLabel?.font = UIFont.BoldFont(16)
        btnAddVolunteer.titleLabel?.font = UIFont.BoldFont(16)
        
        btnContact.setTitleColor(UIColor.darkBlueColor, for: .normal)
        btnProgram.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnAddVolunteer.setTitleColor(UIColor.darkBlueColor, for: .normal)
        
        btnProgram.backgroundColor = UIColor.red
        txtSearch.font = UIFont.RegularFont(16)
        txtSearch.textColor = UIColor.textWhiteColor
        
        btnProgram.layer.cornerRadius = 2
        btnContact.layer.cornerRadius = 2
        btnAddVolunteer.layer.cornerRadius = 2
        
        searchView.layer.cornerRadius = 2
        searchView.layer.borderColor = UIColor.textWhiteColor.cgColor
        searchView.layer.borderWidth = 1
        
        btnSearchClose.isHidden = true
        
        btnProgram.setTitle("Close Event", for: .normal)
        lblDate.text = ""
        lblTitle.text = ""
        lblLocation.text = ""
    }
    
    fileprivate func setupLocationPins(){
        for coords in self.mapCoords {
            let markerpic = ProcessUtils.shared.convertBase64StringToImage(imageBase64String: coords.pic ?? "")
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: coords.lat, longitude: coords.lng)
            marker.map = mapView
            
            let mapView : MapPinView = MapPinView.fromNib()
            mapView.frame = CGRect(x: 0, y: 0, width: 105, height: 105)
//            MapPinView(frame: )
            mapView.pinTitle.text = coords.name
            mapView.pinIcon.image = markerpic
            marker.iconView = mapView
        }
    }
    
    fileprivate func setupMapView() {
        mapContainerVu.addSubview(mapView)
        mapContainerVu.addConstraintsWithFormat("H:|[v0]|", views: mapView)
        mapContainerVu.addConstraintsWithFormat("V:|[v0]|", views: mapView)
        
        let camera = GMSCameraPosition.camera(withLatitude: 45.27996209121132, longitude: -66.06639728779841, zoom: 6.0)
        mapView.camera = camera
    }
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnSearchClose.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        btnSearchClose.isHidden = true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if let str = textField.text, str.count > 2 {
            let searchResults = self.getSearchData(keyword: str)
            self.dataVol = searchResults
            self.tableView.reloadData()
        }
        
        
        //        if (textField.text != ""){
        //
        //           filteredData =  volunteerData?.filter({
        //               if let name = $0.msnfp_contactId?.fullname, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
        //                   return true
        //                }
        //              return false
        //            })
        //
        //                tableView.reloadData()
        //        }else{
        //            filteredData = volunteerData
        //            tableView.reloadData()
        //        }
    }
    
    
    @IBAction func segmentsTapped(_ sender: Any) {
        if self.C_Segments.selectedSegmentIndex == 0 {
            self.v_ContainerVU.isHidden = false
            self.mapContainerVu.isHidden = true
        }else{
            self.v_ContainerVU.isHidden = true
            self.mapContainerVu.isHidden = false
        }
    }
    
    
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func contactTapped(_ sender: Any) {
        self.getContact()
        
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        
    }
    
    @IBAction func btnProgramAction(_ sender: Any) {
        
        var statusValue = NSNotFound
        var message = ""
        if (self.btnProgram.titleLabel?.text ==  "Close Event"){
            statusValue = 844060004
            message = "Are you sure you want to Close Event"
        }else{
            statusValue = 844060005
            message = "Are you sure you want to Cancel Event"
        }
        
        ENTALDAlertView.shared.showActionAlertWithTitle(title: "Alert", message: message, actionTitle: .KOK, completion: { status in
            
            if status == true{
                let params = [
                    "msnfp_engagementopportunitystatus": statusValue as Int
                ]
                
                self.closeVolunteersData(params: params)
            }else{
                
            }
            
        })

    }
    @IBAction func searchCloseTapped(_ sender: Any) {
        txtSearch.text = ""
        txtSearch.endEditing(true)
        
        self.dataVol = self.volentierResultData
        self.tableView.reloadData()
    }
    
    @IBAction func addVolunteer(_ sender: Any) {
        
    }
    
    func updateVolunteerCheckIn(participationId:String , param : [String:Bool]){
        
        self.updateCheckInData(participationId: participationId, params: param)
        
    }
    
    func setMapData(){
        
        if let data = self.volunteerData {
            for i in (0..<data.count){
                
                if let lat = data[i].sjavms_checkedinlatitude, let lng = data[i].sjavms_checkedinlongitude {
                    
                    self.mapCoords.append(MapCoordsModel(lat: lat, lng: lng, name: "\(data[i].sjavms_Volunteer?.fullname ?? "")", pic: "\(data[i].sjavms_Volunteer?.entityimage ?? "")"))
                    break
                }
            }
        }
        
        self.setupLocationPins()
        
    }
    
    func getVolunteers(){
        
        let eventId = self.eventData?.msnfp_engagementopportunityid ?? ""
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_schedulestatus,sjavms_start,sjavms_hours,_sjavms_volunteerevent_value,_sjavms_volunteer_value,msnfp_participationscheduleid,sjavms_start,sjavms_end,sjavms_checkedin,sjavms_checkedinlatitude,sjavms_checkedinlongitude",
            
            ParameterKeys.expand : "sjavms_Volunteer($select=fullname)",
            ParameterKeys.filter : "(_sjavms_volunteerevent_value eq \(eventId))",
            ParameterKeys.orderby : "_sjavms_volunteer_value asc,_sjavms_volunteerevent_value asc"
            
        ]
        
        self.getVolunteersData(params: params)
        
    }
    
    
    fileprivate func getVolunteersData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteersOfEvent(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let pastEvent = response.value {
                    self.volunteerData = pastEvent
                    if (self.volunteerData?.count == 0 || self.volunteerData?.count == nil){
                        self.showEmptyView(tableVw: self.tableView)
                    }else{
                        self.volunteerData = self.volunteerData?.sorted {
                            $0.sjavms_start ?? "" > $1.sjavms_start ?? ""
                        }
                        
                        self.dataVol = self.getEntryTypesByGroup(volunteers: self.volunteerData) ?? [:]
                        self.volentierResultData = self.getEntryTypesByGroup(volunteers:self.volunteerData) ?? [:]
                        
                        
                        DispatchQueue.main.async {
                            for subview in self.tableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.setMapData()
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
    
    
    fileprivate func closeVolunteersData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        let eventId = self.eventData?.msnfp_engagementopportunityid ?? ""
        ENTALDLibraryAPI.shared.requestCloseEvent(eventId:eventId, params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                if let pastEvent = response.error {
                    DispatchQueue.main.async {
                        
                        ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: pastEvent.message, actionTitle: .KOK, completion: {status in })
                    }
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
//                self.showEmptyView(tableVw: self.tableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    fileprivate func updateCheckInData(participationId: String, params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        
        
        ENTALDLibraryAPI.shared.updateVolunteerCheckIn(particitionId: participationId, params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                if let pastEvent = response.value {

                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
//                self.showEmptyView(tableVw: self.tableView)
                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    
    
    private func getAllProgramesfile(){
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
                    self.eventProgramData = self.getProgramName(self.eventData?._sjavms_program_value ?? "")
                    
                    DispatchQueue.main.async {
                        
                        self.lblProgramType.text = self.eventProgramData?.sjavms_name ?? " "
                        //contact info
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

    //====================== Orgnizer Contact API ==========================
    
    func getContact(){

        let eventId = self.eventData?.msnfp_engagementopportunityid ?? ""

        let params : [String:Any] = [

            ParameterKeys.select : "msnfp_engagementopportunitytitle",
            ParameterKeys.expand : "sjavms_Contact($select=emailaddress1,address1_country,address1_line1,address1_line3,address1_city,lastname,firstname,fullname,address1_postalcode,telephone1,address1_stateorprovince,address1_line2)",
            ParameterKeys.filter : "(msnfp_engagementopportunityid eq \(eventId)) and (sjavms_Contact/contactid ne null)"
            //            ParameterKeys.orderby : "_sjavms_volunteer_value asc,_sjavms_volunteerevent_value asc"
            
        ]

        self.getContactData(params: params)

    }

    fileprivate func getContactData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }

        ENTALDLibraryAPI.shared.requestContactInfo(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }

            switch result{
            case .success(value: let response):

                if let contactData = response.value {
                    self.contactInfo = contactData
                    var messageStr = ""
                    if let str = self.contactInfo?[0].sjavms_Contact?.fullname{
                        messageStr += "Name: \(str)\n"
                    }
                    if let str = self.contactInfo?[0].sjavms_Contact?.telephone1{
                        messageStr += "Phone: \(str)\n"
                    }
                    if let str = self.contactInfo?[0].sjavms_Contact?.emailaddress1{
                        messageStr += "Email: \(str)\n"
                    }
                    
                    DispatchQueue.main.async {
                        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Organizer Contact Infomation", message: messageStr, actionTitle: .KOK, completion: {status in })
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
    
    
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
    
    func getEntryTypesByGroup(volunteers:[VolunteerOfEventDataModel]?)->[String:Any]?{
        if let entryTypes = volunteers {
            let dictionary = Dictionary(grouping: entryTypes, by:  { DateFormatManager.shared.formatDateStrToStr(date: $0.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy") })
            return dictionary
        }
        return nil
    }
    
    
    func getProgramName(_ programId:String)->ProgramModel?{
        let programModel = self.programsData?.filter({$0.sjavms_programid == programId}).first
        return programModel
    }
    
}

extension EventManageVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "EventManagerSectionView") as! EventManagerSectionView
        
        let key = Array(self.dataVol.keys)[section]
        if let rowModel : [VolunteerOfEventDataModel] = self.dataVol[key] as? [VolunteerOfEventDataModel]{
            
            let startTime = DateFormatManager.shared.formatDateStrToStr(date: rowModel.first?.sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            let endTime = DateFormatManager.shared.formatDateStrToStr(date: rowModel.first?.sjavms_end ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh:mm a")
            
            headerView.lblTime.text = "\(startTime) - \(endTime)"
        }
        headerView.lblDate.text = key
        
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.numberOfSection()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfRows(section: section)
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventManagerTVC", for: indexPath) as! EventManagerTVC
        
        
        let key = Array(self.dataVol.keys)[indexPath.section]
        if let rowModel : [VolunteerOfEventDataModel] = self.dataVol[key] as? [VolunteerOfEventDataModel]{
            cell.cellModel = rowModel[indexPath.row]
            cell.lblTitle.text = rowModel[indexPath.row].sjavms_Volunteer?.fullname ?? ""
            if ( rowModel[indexPath.row].sjavms_checkedin == true){
                cell.btnCheckIn.isOn = true
            }else{
                cell.btnCheckIn.isOn = false
            }
            cell.delegate = self
            
        }
        return cell
    }
    
    func numberOfSection() -> Int {
        return self.dataVol.count
    }
    
    func numberOfRows(section : Int) -> Int {
        let key = Array(self.dataVol.keys)[section]
        if let rowModel : [VolunteerOfEventDataModel] = self.dataVol[key] as? [VolunteerOfEventDataModel]{
            return rowModel.count
        }
        return 0
    }
    
    func getSearchData(keyword:String)->[String:Any]{
        
        let result = self.volunteerData?.filter({
            if let name = $0.sjavms_Volunteer?.fullname?.lowercased(), name.contains(keyword.lowercased()) {return true}
            return false
        })
        
        return self.getEntryTypesByGroup(volunteers: result) ?? [:]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let key = Array(self.dataVol.keys)[indexPath.section]
//        var rowModel  = self.dataVol[key] as? [VolunteerOfEventDataModel]
//
//        if ( rowModel?[indexPath.row].sjavms_checkedin == true){
//            rowModel?[indexPath.row].sjavms_checkedin = false
//
//            let params = [
//                "sjavms_checkedin": false
//            ]
//            self.updateCheckInData(participationId: rowModel?[indexPath.row].msnfp_participationscheduleid ?? "", params: params)
//        }else{
//
//            rowModel?[indexPath.row].sjavms_checkedin = true
//            let params = [
//                "sjavms_checkedin": false
//            ]
//            self.updateCheckInData(participationId: rowModel?[indexPath.row].msnfp_participationscheduleid ?? "", params: params)
//        }
//
//        tableView.reloadRows(at: [indexPath], with: .none)
        
        
    }
}
