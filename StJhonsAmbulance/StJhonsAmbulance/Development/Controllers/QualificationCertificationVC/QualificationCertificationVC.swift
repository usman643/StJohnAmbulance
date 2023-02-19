//
//  QualificationCertificationVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 16/02/2023.
//

import UIKit

class QualificationCertificationVC: ENTALDBaseViewController {
    
    var externalQualification : [ExternalQualificationDataModel]?
    var SJAQualification : [SJAQualificationDataModel]?
    let contactId = UserDefaults.standard.contactIdToken ?? ""
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        decorateUI()
        getSJAQualification()
        getExternalQualification()
        
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
        self.SJAQualification = self.SJAQualification?.reversed()
        DispatchQueue.main.async {
            self.SJATableview.reloadData()
        }
    }
    
    @IBAction func qualificationFilterTapped(_ sender: Any) {
        
        self.externalQualification = self.externalQualification?.reversed()
        DispatchQueue.main.async {
            self.externalTable.reloadData()
        }
    }
    
    
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
    
    
    
    func getSJAQualification(){
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "bdo_qualificationtype,bdo_expirationdate,bdo_effectivedate,_bdo_qualificationsid_value,bdo_qualificationgainedid",
            ParameterKeys.filter : "(statecode eq 0 and bdo_qualificationsource eq true and _bdo_qualifiedcontactid_value eq \(self.contactId))",
            ParameterKeys.orderby : "bdo_effectivedate asc"
            
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
                    if (self.SJAQualification?.count == 0 || self.SJAQualification?.count == nil){
                        self.showEmptyView(tableVw: self.SJATableview)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.SJATableview.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
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
            ParameterKeys.expand : "sjavms_Qualification($select=sjavms_type)",
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
                    if (self.externalQualification?.count == 0 || self.externalQualification?.count == nil){
                        self.showEmptyView(tableVw: self.externalTable)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.externalTable.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
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
    
    
    
}


extension QualificationCertificationVC : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView == SJATableview){
            
            return SJAQualification?.count ?? 0
            
        }else if (tableView == externalTable){
            
            return externalQualification?.count ?? 0
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
            cell.setContent(cellModel: SJAQualification?[indexPath.row] )
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
            cell.setContent(cellModel: externalQualification?[indexPath.row] )
            return cell
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    
    
}
