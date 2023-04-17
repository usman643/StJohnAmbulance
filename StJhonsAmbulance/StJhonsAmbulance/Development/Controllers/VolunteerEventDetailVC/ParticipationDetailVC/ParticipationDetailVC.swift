//
//  ParticipationDetailVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 05/04/2023.
//

import UIKit

class ParticipationDetailVC: ENTALDBaseViewController,UITextViewDelegate, UITextFieldDelegate {

    var eventId :String?
    var userParticipantData : VolunteerEventParticipationCheckModel?
    var participationData : [OtherVolunteerParticipationModel]?
    var participationFilterData : [OtherVolunteerParticipationModel]?
    
    var isCreateOnFilterApplied = false
    var isVolunteerOnFilterApplied = false
    var isEventOnFilterApplied = false
    var isStartOnFilterApplied = false
    var isEndOnFilterApplied = false
    var isCompletedFilterApplied = false
    var isPendingFilterApplied = false
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnCloseSearch: UIButton!
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet var allHeadingLabels: [UILabel]!
    @IBOutlet weak var btnCreateFilter: UIButton!
    @IBOutlet weak var btnVolunteerFilter: UIButton!
    @IBOutlet weak var btnEventFilter: UIButton!
    @IBOutlet weak var btnStartFilter: UIButton!
    @IBOutlet weak var btnEndFilter: UIButton!
    @IBOutlet weak var btnCompletedFilter: UIButton!
    @IBOutlet weak var btnPendingFilter: UIButton!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearch.delegate = self
        decorateUI()
        registerCell()
        getParticipations()
        
    }

    func decorateUI(){
        for label in allHeadingLabels{
            label.font = UIFont.BoldFont(11)
            label.textColor = UIColor.themePrimaryWhite
        }
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        tableHeaderView.layer.borderWidth = 1
        tableHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        btnCloseSearch.isHidden = true
        txtSearch.font = UIFont.RegularFont(12)
        txtSearch.textColor = UIColor.textBlackColor
        txtSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func registerCell(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ParticipationDetailTVC", bundle: nil), forCellReuseIdentifier: "ParticipationDetailTVC")
    }
    
    // =================== Search ====================
    
    
    @IBAction func searchCloseTapped(_ sender: Any) {
        self.searchView.isHidden = true
        txtSearch.endEditing(true)
        txtSearch.text = ""
        
        participationFilterData = participationData
        tableView.reloadData()
     
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnCloseSearch.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        btnCloseSearch.isHidden = true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (textField.text != ""){
            self.btnCloseSearch.isHidden = false
            participationFilterData  =  participationData?.filter({
                if let name = $0.msnfp_participationtitle, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                }
                return false
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
        }else{
            DispatchQueue.main.async {
                self.participationFilterData = self.participationData
                self.tableView.reloadData()
                self.btnCloseSearch.isHidden = true
               
            }
        }
    }
    
    
    @IBAction func filterTapped(_ sender: Any) {
        self.searchView.isHidden = false
        
    }
    
    
    // ============  Filter ===============
    
    
    @IBAction func createdOnFilter(_ sender: Any) {
        
        if !isCreateOnFilterApplied{
            self.participationFilterData = self.participationFilterData?.sorted {
                $0.createdon ?? "" < $1.createdon ?? ""
            }
            isCreateOnFilterApplied = true
        }else{
            self.participationFilterData = self.participationFilterData?.sorted {
                $0.createdon ?? "" > $1.createdon ?? ""
            }
            isCreateOnFilterApplied = false
        }
        
        isVolunteerOnFilterApplied = false
        isEventOnFilterApplied = false
        isStartOnFilterApplied = false
        isEndOnFilterApplied = false
        isCompletedFilterApplied = false
        isPendingFilterApplied = false
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func volunteerFilter(_ sender: Any) {
        
        if !isVolunteerOnFilterApplied{
            self.participationFilterData = self.participationFilterData?.sorted {
                $0.volunteerName ?? "" < $1.volunteerName ?? ""
            }
            isVolunteerOnFilterApplied = true
        }else{
            self.participationFilterData = self.participationFilterData?.sorted {
                $0.volunteerName ?? "" > $1.volunteerName ?? ""
            }
            isVolunteerOnFilterApplied = false
        }

        isCreateOnFilterApplied = false
        isEventOnFilterApplied = false
        isStartOnFilterApplied = false
        isEndOnFilterApplied = false
        isCompletedFilterApplied = false
        isPendingFilterApplied = false

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func eventFilter(_ sender: Any) {
        
        if !isEventOnFilterApplied{
            self.participationFilterData = self.participationFilterData?.sorted {
                $0.eventName ?? "" < $1.eventName ?? ""
            }
            isEventOnFilterApplied = true
        }else{
            self.participationFilterData = self.participationFilterData?.sorted {
                $0.eventName ?? "" > $1.eventName ?? ""
            }
            isEventOnFilterApplied = false
        }

        isCreateOnFilterApplied = false
        isVolunteerOnFilterApplied = false
        isStartOnFilterApplied = false
        isEndOnFilterApplied = false
        isCompletedFilterApplied = false
        isPendingFilterApplied = false

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func startFilter(_ sender: Any) {
        
        if !isStartOnFilterApplied{
            self.participationFilterData = self.participationFilterData?.sorted {
                $0.msnfp_startdate ?? "" < $1.msnfp_startdate ?? ""
            }
            isStartOnFilterApplied = true
        }else{
            self.participationFilterData = self.participationFilterData?.sorted {
                $0.msnfp_startdate ?? "" > $1.msnfp_startdate ?? ""
            }
            isStartOnFilterApplied = false
        }
        
        isCreateOnFilterApplied = false
        isVolunteerOnFilterApplied = false
        isEventOnFilterApplied = false
        isEndOnFilterApplied = false
        isCompletedFilterApplied = false
        isPendingFilterApplied = false

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func endFilter(_ sender: Any) {
        
        if !isEndOnFilterApplied{
            self.participationFilterData = self.participationFilterData?.sorted {
                $0.msnfp_enddate ?? "" < $1.msnfp_enddate ?? ""
            }
            isEndOnFilterApplied = true
        }else{
            self.participationFilterData = self.participationFilterData?.sorted {
                $0.msnfp_enddate ?? "" > $1.msnfp_enddate ?? ""
            }
            isEndOnFilterApplied = false
        }
        

        isCreateOnFilterApplied = false
        isVolunteerOnFilterApplied = false
        isEventOnFilterApplied = false
        isStartOnFilterApplied = false
        isCompletedFilterApplied = false
        isPendingFilterApplied = false

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func completedFilter(_ sender: Any) {
        
        if !isCompletedFilterApplied{
            self.participationFilterData = self.participationFilterData?.sorted {
                $0.msnfp_hours ?? Float(NSNotFound) < $1.msnfp_hours ?? Float(NSNotFound)
            }
            isCompletedFilterApplied = true
        }else{
            self.participationFilterData = self.participationFilterData?.sorted {
                $0.msnfp_hours ?? Float(NSNotFound) > $1.msnfp_hours ?? Float(NSNotFound)
            }
            isCompletedFilterApplied = false
        }
        
        isCreateOnFilterApplied = false
        isVolunteerOnFilterApplied = false
        isEventOnFilterApplied = false
        isStartOnFilterApplied = false
        isEndOnFilterApplied = false
        isPendingFilterApplied = false


        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func pendingFilter(_ sender: Any) {
        
//        if !isPendingFilterApplied{
//            self.participationFilterData = self.participationFilterData?.sorted {
//                $0. ?? "" < $1. ?? ""
//            }
//            isPendingFilterApplied = true
//        }else{
//            self.participationFilterData = self.participationFilterData?.sorted {
//                $0. ?? "" > $1. ?? ""
//            }
//            isPendingFilterApplied = false
//        }
//
//        isCreateOnFilterApplied = false
//        isVolunteerOnFilterApplied = false
//        isEventOnFilterApplied = false
//        isStartOnFilterApplied = false
//        isEndOnFilterApplied = false
//        isCompletedFilterApplied = false
//
//
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
    }
    
    
    
    
    
    func getParticipations() {
        
        let params : [String:Any] = [
            ParameterKeys.select : "createdon,_msnfp_engagementopportunityid_value,_msnfp_contactid_value,sjavms_totalpendinghours,msnfp_hours,msnfp_participationid,msnfp_participationtitle,msnfp_startdate,msnfp_enddate",
            ParameterKeys.filter : "(statecode eq 0 and msnfp_status eq 844060002 and _msnfp_engagementopportunityid_value eq \(self.eventId ?? ""))",
            ParameterKeys.orderby : "createdon desc,_msnfp_contactid_value desc"
        ]
        
        self.getParticipationsData(params: params)
        
    }
    
    
    fileprivate func getParticipationsData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }

        ENTALDLibraryAPI.shared.getOtherVolunteerParticipations(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):

                if let particopations = response.value {
                    self.participationData = particopations
                    self.participationFilterData = particopations

                    if (self.participationData?.count == 0 || self.participationData?.count == nil){
                        self.showEmptyView(tableVw: self.tableView)
                    }else{

                        DispatchQueue.main.async {
                            for subview in self.tableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }

                        
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.tableView.reloadData()
                    }

                }else{
                    self.showEmptyView(tableVw: self.tableView)
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

}


extension ParticipationDetailVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participationFilterData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipationDetailTVC", for: indexPath) as! ParticipationDetailTVC
        
        if indexPath.row % 2 == 0{
            cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
            cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
        }else{
            cell.mainView.backgroundColor = UIColor.viewLightColor
            cell.seperaterView.backgroundColor = UIColor.gray
        }
        
        if let participationtitle = self.participationFilterData?[indexPath.row].msnfp_participationtitle{
            let arr = participationtitle.components(separatedBy: " - ")
            self.participationFilterData?[indexPath.row].eventName = arr[1]
            self.participationFilterData?[indexPath.row].volunteerName = arr[0]
        }
            
            
            
        
        
        var rowModel = self.participationFilterData?[indexPath.row]
        cell.setContent(cellModel: rowModel )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
}
