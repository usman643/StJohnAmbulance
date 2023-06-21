//
//  QualificationCertificationVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 16/02/2023.
//

import UIKit

class QualificationCertificationVC: ENTALDBaseViewController,UITextFieldDelegate {
    
    var externalQualification : [ExternalQualificationDataModel]?
    var SJAQualification : [SJAQualificationDataModel]?
    var SJAQualificationTypes : [SJAQualificationTypeDataModel]?
    
    var filterSJAQualification : [SJAQualificationDataModel]?
    var filterExternalQualification : [ExternalQualificationDataModel]?
    
    let contactId = UserDefaults.standard.contactIdToken ?? ""
    
    var isExternalTableSearch = false
    var isSJATableSearch = false
    
    var isExternalCertificationIDFilterApplied = false
    var isExternalQualificationFilterApplied = false
    var isExternalTypeFilterApplied = false
    var isExternalIssuedFilterApplied = false
    var isExternalExpireFilterApplied = false
    
    
    var isGainedQualificationFilterApplied = false
    var isGainedTypeFilterApplied = false
    var isGainedEffectiveFilterApplied = false
    var isGainedExpireFilterApplied = false
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet var allTableHeadingLabel: [UILabel]!
    
    @IBOutlet weak var externalQualificationTitle: UILabel!
    @IBOutlet weak var SJAQualificationTitle: UILabel!
//    @IBOutlet weak var lblTabTitle: UILabel!
//    @IBOutlet weak var selectedTabImg: UIImageView!
  
    @IBOutlet weak var qualificationHeaderView: UIView!
    @IBOutlet weak var certificationHeaderView: UIView!
    
    @IBOutlet weak var externalTable: UITableView!
    @IBOutlet weak var SJATableview: UITableView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var textSearch: UITextField!
    @IBOutlet weak var btnSearchClose: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        decorateUI()
        self.getQualificationType() { status in
            self.getSJAQualification()
            self.getExternalQualification()
        }
        textSearch.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func decorateUI(){
        
        qualificationHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        qualificationHeaderView.layer.borderWidth = 1
        certificationHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        certificationHeaderView.layer.borderWidth = 1
        
        externalQualificationTitle.textColor = UIColor.themePrimaryWhite
        externalQualificationTitle.font = UIFont.BoldFont(16)
        SJAQualificationTitle.textColor = UIColor.themePrimaryWhite
        SJAQualificationTitle.font = UIFont.BoldFont(16)
//        lblTabTitle.textColor = UIColor.themePrimary
//        lblTabTitle.font = UIFont.BoldFont(16)
        
        for lbltext in allTableHeadingLabel{
            lbltext.font = UIFont.BoldFont(10)
            lbltext.textColor = UIColor.themePrimaryColor
        }
        
        
        searchView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        searchView.layer.borderWidth = 1.5
        searchView.isHidden = true
        textSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    func registerCell(){
        
        externalTable.delegate = self
        externalTable.dataSource = self
        externalTable.register(UINib(nibName: "ExternalQualificationTVC", bundle: nil), forCellReuseIdentifier: "ExternalQualificationTVC")
        
        
        SJATableview.delegate = self
        SJATableview.dataSource = self
        SJATableview.register(UINib(nibName: "SJAQualificationTVC", bundle: nil), forCellReuseIdentifier: "SJAQualificationTVC")
        
    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func certificationFilterTapped(_ sender: Any) {
     
        isExternalTableSearch = false
        isSJATableSearch = true
      
        self.searchView.isHidden = false
        self.textSearch.placeholder = "Filter External Qualification Event"
        
        
    }
    
    @IBAction func qualificationFilterTapped(_ sender: Any) {
        
        isExternalTableSearch = true
        isSJATableSearch = false
      
        self.searchView.isHidden = false
        self.textSearch.placeholder = "Filter SJA Qualification Event"
    }
    
    
    @IBAction func closeSearch(_ sender: Any) {
        self.searchView.isHidden = true
        textSearch.endEditing(true)
        textSearch.text = ""
        filterSJAQualification = SJAQualification
        filterExternalQualification = externalQualification

        SJATableview.reloadData()
        externalTable.reloadData()
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnSearchClose.isHidden = false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (textField.text != "" && isSJATableSearch == true ){
            
            filterSJAQualification  =  SJAQualification?.filter({
                if let name = $0.bdo_qualificationsid?.bdo_name, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                }
                return false
            })
            DispatchQueue.main.async {
                self.SJATableview.reloadData()
            }
            
            
        }else if(textField.text != "" && isExternalTableSearch == true ){
            
            filterExternalQualification  =  externalQualification?.filter({
                if let name = $0.sjavms_Qualification?.sjavms_type_value , name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                 }
               return false
             })
            
            DispatchQueue.main.async {
                self.externalTable.reloadData()
            }
            
        }else{
            DispatchQueue.main.async {
                self.filterSJAQualification = self.SJAQualification
                self.SJATableview.reloadData()
                self.filterExternalQualification = self.externalQualification
                self.externalTable.reloadData()
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
    
    // ================== Filters ====================//
    
    @IBAction func externalCertificationIdFilter(_ sender: Any) {
        
        if !isExternalCertificationIDFilterApplied{
            self.filterExternalQualification = self.filterExternalQualification?.sorted {
                $0.sjavms_Qualification?.sjavms_type ?? 0 < $1.sjavms_Qualification?.sjavms_type ?? 0
            }
            isExternalCertificationIDFilterApplied = true
        }else{
            self.filterExternalQualification = self.filterExternalQualification?.sorted {
                $0.sjavms_Qualification?.sjavms_type ?? 0 > $1.sjavms_Qualification?.sjavms_type ?? 0
            }
            isExternalCertificationIDFilterApplied = false
        }
    
        DispatchQueue.main.async {
            self.externalTable.reloadData()
        }
        
        self.isExternalQualificationFilterApplied = false
        self.isExternalTypeFilterApplied = false
        self.isExternalIssuedFilterApplied = false
        self.isExternalExpireFilterApplied = false
        
        
    }
    
    @IBAction func externalQualificationFilter(_ sender: Any) {
//        if !isExternalQualificationFilterApplied{
//            self.filterExternalQualification = self.filterExternalQualification?.sorted {
//                $0.sjavms_name ?? "" < $1.sjavms_name ?? ""
//            }
//            isExternalQualificationFilterApplied = true
//        }else{
//            self.filterExternalQualification = self.filterExternalQualification?.sorted {
//                $0.sjavms_name ?? "" > $1.sjavms_name ?? ""
//            }
//            isExternalQualificationFilterApplied = false
//        }
//
//        DispatchQueue.main.async {
//            self.externalTable.reloadData()
//        }
        self.isExternalCertificationIDFilterApplied = false
        self.isExternalTypeFilterApplied = false
        self.isExternalIssuedFilterApplied = false
        self.isExternalExpireFilterApplied = false
    }
    
    @IBAction func externalTypeFilter(_ sender: Any) {
        if !isExternalTypeFilterApplied{
            self.filterExternalQualification = self.filterExternalQualification?.sorted {
                $0.sjavms_Qualification?.sjavms_type_value ?? "" < $1.sjavms_Qualification?.sjavms_type_value  ?? ""
            }
            isExternalTypeFilterApplied = true
        }else{
            self.filterExternalQualification = self.filterExternalQualification?.sorted {
                $0.sjavms_Qualification?.sjavms_type_value  ?? "" > $1.sjavms_Qualification?.sjavms_type_value  ?? ""
            }
            isExternalTypeFilterApplied = false
        }

        DispatchQueue.main.async {
            self.externalTable.reloadData()
        }
        
        self.isExternalCertificationIDFilterApplied = false
        self.isExternalQualificationFilterApplied = false
        self.isExternalIssuedFilterApplied = false
        self.isExternalExpireFilterApplied = false
    }
    
    @IBAction func externalIssuedDateFilter(_ sender: Any) {
        if !isExternalIssuedFilterApplied{
            self.filterExternalQualification = self.filterExternalQualification?.sorted {
                $0.sjavms_issuedate ?? "" < $1.sjavms_issuedate ?? ""
            }
            isExternalIssuedFilterApplied = true
        }else{
            self.filterExternalQualification = self.filterExternalQualification?.sorted {
                $0.sjavms_issuedate ?? "" > $1.sjavms_issuedate ?? ""
            }
            isExternalIssuedFilterApplied = false
        }
    
        DispatchQueue.main.async {
            self.externalTable.reloadData()
        }
        
        self.isExternalCertificationIDFilterApplied = false
        self.isExternalQualificationFilterApplied = false
        self.isExternalTypeFilterApplied = false
        self.isExternalExpireFilterApplied = false
        
    }
    
    @IBAction func externalExpireDateFilter(_ sender: Any) {
        if !isExternalExpireFilterApplied{
            self.filterExternalQualification = self.filterExternalQualification?.sorted {
                $0.sjavms_expirydate ?? "" < $1.sjavms_expirydate ?? ""
            }
            isExternalExpireFilterApplied = true
        }else{
            self.filterExternalQualification = self.filterExternalQualification?.sorted {
                $0.sjavms_expirydate ?? "" > $1.sjavms_expirydate ?? ""
            }
            isExternalExpireFilterApplied = false
        }
    
        DispatchQueue.main.async {
            self.externalTable.reloadData()
        }
        
        self.isExternalCertificationIDFilterApplied = false
        self.isExternalQualificationFilterApplied = false
        self.isExternalTypeFilterApplied = false
        self.isExternalIssuedFilterApplied = false
    }
    
    @IBAction func gainedQualificationFilter(_ sender: Any) {
        if !isGainedQualificationFilterApplied{
            self.filterSJAQualification = self.filterSJAQualification?.sorted {
                $0.bdo_qualificationsid?.bdo_name ?? "" < $1.bdo_qualificationsid?.bdo_name ?? ""
            }
            isGainedQualificationFilterApplied = true
        }else{
            self.filterSJAQualification = self.filterSJAQualification?.sorted {
                $0.bdo_qualificationsid?.bdo_name ?? "" > $1.bdo_qualificationsid?.bdo_name ?? ""
            }
            isGainedQualificationFilterApplied = false
        }
    
        DispatchQueue.main.async {
            self.SJATableview.reloadData()
        }

        self.isGainedTypeFilterApplied = false
        self.isGainedEffectiveFilterApplied = false
        self.isGainedExpireFilterApplied = false
    }
    
    @IBAction func gainedTypeFilter(_ sender: Any) {
        
//        if !isGainedTypeFilterApplied{
//            self.filterSJAQualification = self.filterSJAQualification?.sorted {
//                $0.sjavms_expirydate ?? "" < $1.sjavms_expirydate ?? ""
//            }
//            isGainedTypeFilterApplied = true
//        }else{
//            self.filterSJAQualification = self.filterSJAQualification?.sorted {
//                $0.sjavms_expirydate ?? "" > $1.sjavms_expirydate ?? ""
//            }
//            isGainedTypeFilterApplied = false
//        }
//
//        DispatchQueue.main.async {
//            self.SJATableview.reloadData()
//        }
        
        self.isGainedQualificationFilterApplied = false
        self.isGainedEffectiveFilterApplied = false
        self.isGainedExpireFilterApplied = false
    }
    
    @IBAction func gainedEffectiveFromFilter(_ sender: Any) {
        
        if !isGainedEffectiveFilterApplied{
            self.filterSJAQualification = self.filterSJAQualification?.sorted {
                $0.bdo_effectivedate ?? "" < $1.bdo_effectivedate ?? ""
            }
            isGainedEffectiveFilterApplied = true
        }else{
            self.filterSJAQualification = self.filterSJAQualification?.sorted {
                $0.bdo_effectivedate ?? "" > $1.bdo_effectivedate ?? ""
            }
            isGainedEffectiveFilterApplied = false
        }
    
        DispatchQueue.main.async {
            self.SJATableview.reloadData()
        }
        
        self.isGainedQualificationFilterApplied = false
        self.isGainedTypeFilterApplied = false
        self.isGainedExpireFilterApplied = false
    }
    
    @IBAction func gainedExpireFilter(_ sender: Any) {
        if !isGainedExpireFilterApplied{
            self.filterSJAQualification = self.filterSJAQualification?.sorted {
                $0.bdo_expirationdate ?? "" < $1.bdo_expirationdate ?? ""
            }
            isGainedExpireFilterApplied = true
        }else{
            self.filterSJAQualification = self.filterSJAQualification?.sorted {
                $0.bdo_expirationdate ?? "" > $1.bdo_expirationdate ?? ""
            }
            isGainedExpireFilterApplied = false
        }
    
        DispatchQueue.main.async {
            self.SJATableview.reloadData()
        }
        
        self.isGainedQualificationFilterApplied = false
        self.isGainedTypeFilterApplied = false
        self.isGainedEffectiveFilterApplied = false
    }
    
    func getSJAQualification(){
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "bdo_qualificationtype,bdo_expirationdate,bdo_effectivedate,_bdo_qualificationsid_value,bdo_qualificationgainedid",
            ParameterKeys.filter : "(statecode eq 0 and bdo_qualificationsource eq true and _bdo_qualifiedcontactid_value eq \(self.contactId))",
            ParameterKeys.orderby : "bdo_effectivedate asc",
            ParameterKeys.expand : "bdo_qualificationsid($select=bdo_name)"
            
        ]
        
        self.getSJAQualificationData(params: params)
        
    }
    
    
    fileprivate func getSJAQualificationData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestSJAQualification(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let qualification = response.value {
                    self.SJAQualification = qualification
                    self.filterSJAQualification = qualification
                    if (self.SJAQualification?.count == 0 || self.SJAQualification?.count == nil){
                        self.showEmptyView(tableVw: self.SJATableview)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.SJATableview.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    for i in (0..<(self.SJAQualification?.count ?? 0)){

                        let data = self.getQualificationType(self.SJAQualification?[i].bdo_qualificationtype ?? 000)
                        
                        self.SJAQualification?[i].bdo_type_value = data?.value

                    }
                    self.filterSJAQualification = self.SJAQualification
                    
                    DispatchQueue.main.async {
                        self.SJATableview.reloadData()
                    }
                }else{
                    self.showEmptyView(tableVw: self.SJATableview)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
               
                self.showEmptyView(tableVw: self.SJATableview)
                
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    func getExternalQualification(){
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "sjavms_name,_sjavms_qualification_value,sjavms_issuedate,sjavms_expirydate,sjavms_verifiedqualificationid",
            ParameterKeys.expand : "sjavms_Qualification($select=sjavms_type,sjavms_name)",
            ParameterKeys.filter : "(statecode eq 0 and _sjavms_volunteer_value eq \(self.contactId)) and (sjavms_Qualification/sjavms_visbility eq 802280001)",
            ParameterKeys.orderby : "sjavms_name desc"
            
        ]
        self.getExternalQualificationData(params: params)
    }
    
    
    fileprivate func getExternalQualificationData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestExternalQualification(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let qualification = response.value {
                    self.externalQualification = qualification
                    self.filterExternalQualification = qualification
                    if (self.externalQualification?.count == 0 || self.externalQualification?.count == nil){
                        self.showEmptyView(tableVw: self.externalTable)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.externalTable.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                        for i in (0..<(self.externalQualification?.count ?? 0)){
                            
                            let data = self.getQualificationType(self.externalQualification?[i].sjavms_Qualification?.sjavms_type ?? 000)
                            
                            self.externalQualification?[i].sjavms_Qualification?.sjavms_type_value = data?.value
                            
                        }
                    }
                    self.filterExternalQualification = self.externalQualification
                        DispatchQueue.main.async {
                            self.externalTable.reloadData()
                            
                        }
                    
                }else{
                    self.showEmptyView(tableVw: self.externalTable)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
               
                self.showEmptyView(tableVw: self.externalTable)
                
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    
    
    
    fileprivate func getQualificationType( completion: @escaping(_ status:Bool)->Void){
        
        let params : [String:Any] = [
            
          
//            ParameterKeys.filter : "(statecode eq 0 and _sjavms_volunteer_value eq \(self.contactId)) and (sjavms_Qualification/sjavms_visbility eq 802280001)",
            ParameterKeys.filter : "objecttypecode eq 'sjavms_vmsqualification' and attributename eq 'sjavms_type' and langid eq 1033"
            
            
            ]
    
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestQualificationTypes(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let qualification = response.value {
                    self.SJAQualificationTypes = qualification
                }
                DispatchQueue.main.async {
                    self.externalTable.reloadData()
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


extension QualificationCertificationVC : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView == SJATableview){
            
            return filterSJAQualification?.count ?? 0
            
        }else if (tableView == externalTable){
            
            return filterExternalQualification?.count ?? 0
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (tableView == SJATableview){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SJAQualificationTVC", for: indexPath) as! SJAQualificationTVC
            if indexPath.row % 2 == 0{
                cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
                cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
            }else{
                cell.backgroundColor = UIColor.viewLightColor
                cell.seperaterView.backgroundColor = UIColor.gray
            }
            cell.setContent(cellModel: filterSJAQualification?[indexPath.row] )
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExternalQualificationTVC", for: indexPath) as! ExternalQualificationTVC
            if indexPath.row % 2 == 0{
                cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
                cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
            }else{
                cell.backgroundColor = UIColor.viewLightColor
                cell.seperaterView.backgroundColor = UIColor.gray
            }
            
            cell.setContent(cellModel: filterExternalQualification?[indexPath.row] )
            return cell
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    
    func getQualificationType(_ qualificationType:Int)->SJAQualificationTypeDataModel?{
        
        let modelOne = SJAQualificationTypes?.filter({$0.attributevalue == qualificationType}).first
        return modelOne
        
    }
    
    
    
}
