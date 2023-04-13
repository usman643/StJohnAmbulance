//
//  EventHourVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/03/2023.
//

import UIKit

class EventHourVC: ENTALDBaseViewController {
    
    var eventData : CurrentEventsModel?
    var volunteerData : [VolunteerOfEventDataModel]?
    var selectedStatus : String?
    var summaryData : EventSummaryModel?
    
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSectionHeading: UILabel!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet var lblTableHeadings: [UILabel]!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getVolunteers()
        decorateUI()
        getSummaryData()
    }
    
    func registerCell(){
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(UINib(nibName: "EventHourTVC", bundle: nil), forCellReuseIdentifier: "EventHourTVC")
    }

    func decorateUI(){
        
        lbltitle.font = UIFont.BoldFont(22)
        lblStatus.font = UIFont.BoldFont(14)
        lblSectionHeading.font = UIFont.BoldFont(14)
        lblStatus.textColor = UIColor.textWhiteColor
        lblSectionHeading.textColor = UIColor.themePrimaryWhite
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        
        btnStatus.layer.cornerRadius = 5
        for label in lblTableHeadings{
            label.textColor = UIColor.themePrimaryWhite
            label.font = UIFont.BoldFont(11)
        }
        
    }
    
    func setupData(){
        let status = ProcessUtils.shared.eventStatusArr[self.summaryData?.msnfp_engagementopportunitystatus ?? 0]
        self.btnStatus.setTitle(status, for: .normal)
    }


    @IBAction func submitTapped(_ sender: Any) {
        
    }
    
    @IBAction func StatusTapped(_ sender: Any) {
        self.showGroupsPicker()
    }
    
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
    
    func getVolunteers(){
        
        let eventId = self.eventData?.msnfp_engagementopportunityid ?? ""
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_schedulestatus,sjavms_start,sjavms_hours,_sjavms_volunteerevent_value,_sjavms_volunteer_value,msnfp_participationscheduleid,sjavms_start,sjavms_end",
            
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
                
                if let messagesData = response.value {
                    self.volunteerData = messagesData
                    if (self.volunteerData?.count == 0 || self.volunteerData?.count == nil){
                        self.showEmptyView(tableVw: self.tableview)
                    }else{
                        
                        DispatchQueue.main.async {
                            for subview in self.tableview.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.volunteerData = self.volunteerData?.filter({$0.msnfp_schedulestatus == 335940000})
                        self.tableview.reloadData()
                    }
                    
                }else{
                    self.showEmptyView(tableVw: self.tableview)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.tableview)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    
    func showGroupsPicker(){
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.eventStatus, dataObj: ProcessUtils.shared.eventStatusArr) { params, controller in
            self.selectedStatus  = params as? String
            var status = ProcessUtils.shared.eventStatusArr.filter({$0.value == params as? String}).first?.key
            self.updateEventStatus(statusValue : status ?? NSNotFound)
        }
    }
    
    func updateEventStatus(statusValue:Int){
        
            DispatchQueue.main.async {
                LoadingView.show()
            }
            var params:[String:Any] = [:]
            
            
                params["msnfp_engagementopportunitystatus"] = statusValue as Int
                
        ENTALDLibraryAPI.shared.updateEventStatus(eventid: self.eventData?.msnfp_engagementopportunityid ?? "", params: params){ result in
                DispatchQueue.main.async {
                    LoadingView.hide()
                }
                switch result{
                case .success(value: _):
                    break
                case .error(let error, let errorResponse):
                    if error == .patchSuccess {
                        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Event Status Update Successfully", message: "", actionTitle: .KOK, completion: { status in })
                        self.btnStatus.setTitle(self.selectedStatus, for: .normal)
                    }else{
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
    }
    
    fileprivate func getSummaryData(){
        guard let eventId = self.eventData?.msnfp_engagementopportunityid else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "_sjavms_group_value,sjavms_onsiteparking,sjavms_tableschairsseating,msnfp_engagementopportunityid,sjavms_designatedvolunteerarea,sjavms_cleandrinkingwater,sjavms_othertreatments,sjavms_designatedspaceforvolunteers,sjavms_electricalpowersupply,msnfp_stateprovince,msnfp_shortdescription,_sjavms_program_value,sjavms_foodforvolunteers,msnfp_filledshifts,statuscode,msnfp_location,sjavms_age1860,msnfp_description,msnfp_maximum,_sjavms_branch_value,msnfp_endingdate,sjavms_onsitefoodforvolunteers,sjavms_age13under,msnfp_appliedparticipants,sjavms_age60,sjavms_eventscheduleinformation,msnfp_engagementopportunitystatus,sjavms_bathrooms,_sjavms_contact_value,msnfp_engagementopportunitytitle,msnfp_completed,sjavms_onsitecleandrinkingwater,_sjavms_council_value,msnfp_street1,msnfp_street2,sjavms_age1417,msnfp_shifts,sjavms_donationreceived,_msnfp_primarycontactid_value,sjavms_willotherhealthcareagenciesbeonsite,msnfp_number,sjavms_numberofparticipants,msnfp_cancelledshifts,sjavms_multidayevent,sjavms_firstaidroomtent,sjavms_emergencyservicescalled,sjavms_sitemapifapplicable,sjavms_onsitedesignatedvolunteerarea,_sjavms_eventcoordinator_value,sjavms_totalapproved,sjavms_onsitecellphonereception,sjavms_telephone,sjavms_onsitebathrooms,sjavms_onsiteother,sjavms_cellphonereception,_sjavms_account_value,msnfp_locationtype,sjavms_patientstreated,sjavms_onsitefirstaidroomtent,_sjavms_posteventsurvey_value,msnfp_minimum,sjavms_onsitetelephone,msnfp_city,sjavms_parking,sjavms_eventorganizerprovidedadequatesupport,msnfp_multipledays,msnfp_startingdate,sjavms_donationintended,msnfp_street3,sjavms_othercomments,sjavms_eventrequirements,sjavms_surveycomments,statecode,sjavms_adhocevent,sjavms_shadedareaifoutside,msnfp_zippostalcode,sjavms_locationcontactname,sjavms_maxparticipants",
            ParameterKeys.filter : "(msnfp_engagementopportunityid eq \(eventId))",

        ]

        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getEventSummary(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let summaryData = response.value {
                    self.summaryData = summaryData[0]
                    DispatchQueue.main.async {
                        self.setupData()
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
    
    
}


extension EventHourVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.volunteerData?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventHourTVC", for: indexPath) as! EventHourTVC
        
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
            cell.seperatorView.backgroundColor = UIColor.themePrimaryColor
        }else{
            cell.backgroundColor = UIColor.viewLightColor
            cell.seperatorView.backgroundColor = UIColor.gray
        }
        
        let rowModel = self.volunteerData?[indexPath.row]
        cell.setContent(rowModel: rowModel , eventName: self.eventData?.msnfp_engagementopportunitytitle)
        
        return cell
    }
}
