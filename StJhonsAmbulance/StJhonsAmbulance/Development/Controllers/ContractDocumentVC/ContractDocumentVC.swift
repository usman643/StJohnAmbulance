//
//  ContractDocumentVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 18/04/2023.
//

import UIKit

class ContractDocumentVC: ENTALDBaseViewController,UITextFieldDelegate {

    
    let conId = UserDefaults.standard.contactIdToken ?? ""
    var participationId = ""
    var relativeurlData : [ContactDocumentModel]?
    var documents : [ContactDocumentResults]?
    var filterDocuments : [ContactDocumentResults]?
    var access_token : String = ""
    var userRetrivalURL : String = ""
    var isModifiedOnFilterApplied = false
    var isNameFilterApplied = false
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblModifiedDate: UILabel!
    @IBOutlet weak var lblAction: UILabel!
    
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var textSearch: UITextField!
    @IBOutlet weak var btnSearchClose: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textSearch.delegate = self
        decorateUI()
        registerCell()
        getDocumentToken()
        
    }
    
    func decorateUI(){
        lblTitle.textColor = UIColor.themePrimaryWhite
        lblTitle.font = UIFont.BoldFont(13)
        lblModifiedDate.textColor = UIColor.themePrimaryWhite
        lblModifiedDate.font = UIFont.BoldFont(13)
        lblAction.textColor = UIColor.themePrimaryWhite
        lblAction.font = UIFont.BoldFont(13)
        
        tableHeaderView.layer.borderWidth = 1.5
        tableHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        lblScreenTitle.font = UIFont.BoldFont(22)
        lblScreenTitle.textColor = UIColor.themePrimaryWhite
        
        searchView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        searchView.layer.borderWidth = 1.5
        searchView.isHidden = true
        textSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func registerCell(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ContactDocumentsTVC", bundle: nil), forCellReuseIdentifier: "ContactDocumentsTVC")
        
    }
    
    @IBAction func closeSearch(_ sender: Any) {
        self.searchView.isHidden = true
        textSearch.endEditing(true)
        textSearch.text = ""
//        filterPendingShiftData = pendingShiftData

        tableView.reloadData()
        
    }

    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterTapped(_ sender: Any) {
        self.searchView.isHidden = false
        self.textSearch.placeholder = "Filter Document"
        
    }
    
    @IBAction func nameFilterTapped(_ sender: Any) {
        
        if !isNameFilterApplied{
            self.filterDocuments = self.filterDocuments?.sorted {
                $0.Name ?? "" < $1.Name ?? ""
            }
            isNameFilterApplied = true
        }else{
            self.filterDocuments = self.filterDocuments?.sorted {
                $0.Name ?? "" > $1.Name ?? ""
            }
            isNameFilterApplied = false
        }
        
        isModifiedOnFilterApplied = false

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func modifiedDateFilterTapped(_ sender: Any) {
        
        if !isModifiedOnFilterApplied{
            self.filterDocuments = self.filterDocuments?.sorted {
                $0.TimeLastModified ?? "" < $1.TimeLastModified ?? ""
            }
            isModifiedOnFilterApplied = true
        }else{
            self.filterDocuments = self.filterDocuments?.sorted {
                $0.TimeLastModified ?? "" > $1.TimeLastModified ?? ""
            }
            isModifiedOnFilterApplied = false
        }
        
        isNameFilterApplied = false

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnSearchClose.isHidden = false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (textField.text != "" ){
            
            filterDocuments  =  documents?.filter({
                if let name = $0.Name, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                }
                return false
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }else{
            DispatchQueue.main.async {
                self.filterDocuments = self.documents
                self.tableView.reloadData()
               
            }
        }
        
    }
    
    
    fileprivate func getDocumentToken(){
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        let params : DynamicAuthRequest = DynamicAuthRequest(grant_type: "client_credentials", client_id: "69168eb4-986f-4198-92f5-7b3c796044ad@4eb3d202-86fa-4a81-b4de-47e3389ef4d0", resource: "00000003-0000-0ff1-ce00-000000000000/sjaasj.sharepoint.com@4eb3d202-86fa-4a81-b4de-47e3389ef4d0", client_secret: "/pbmvpnf9I2QefYYTbpBqPY7l8P1TleNGyUc7Tc8/g0=")
        
        ENTALDLibraryAPI.shared.getDocumentToken(params: params) { result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(let response):
                if let sessionToken = response.access_token {
                    self.access_token = sessionToken
                    self.getDocument()
                }
                break
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
    
    
    

    
    
    fileprivate func getDocument(){
        let params : [String:Any] = [
            ParameterKeys.select : "relativeurl",
            ParameterKeys.filter : "(_regardingobjectid_value eq \(self.conId))"
        ]
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getContactDocument(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let apiData = response.value {
                    
                    self.relativeurlData = apiData
                    if ((self.relativeurlData?.count ?? 0 ) > 0){
                        var contactId = self.conId.replacingOccurrences(of: "-", with: "")
                        
                        self.userRetrivalURL = self.relativeurlData?.filter({
                            
                            var apiContactId = $0.relativeurl?.components(separatedBy: "_")
                            if (contactId.lowercased() == apiContactId?[1].lowercased()){
                                
                                return true
                            } else{
                                return false
                            }
                            
                        }).first?.relativeurl ?? ""
                        
                        self.getDocumentTwo()
                    }else{
                        self.showEmptyView(tableVw: self.tableView)
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
    
    
    
    
    fileprivate func getDocumentTwo(){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getContactDocumentstwoEvent(participationId: self.userRetrivalURL, externalToken: self.access_token){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let apiData = response.d {
                    self.documents = apiData.results
                    self.filterDocuments = apiData.results
                    if (self.documents?.count == 0 || self.documents?.count == nil){
                        self.showEmptyView(tableVw: self.tableView)
                    }else{
                        DispatchQueue.main.async {
                            for subview in self.tableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
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

extension ContractDocumentVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterDocuments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactDocumentsTVC", for: indexPath) as! ContactDocumentsTVC
        let rowModel = self.filterDocuments?[indexPath.row]
        cell.setContent(cellModel: rowModel)
        if indexPath.row % 2 == 0{
            cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
            cell.seperatorView.backgroundColor = UIColor.themePrimary
        }else{
            cell.mainView.backgroundColor = UIColor.viewLightColor
            cell.seperatorView.backgroundColor = UIColor.gray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowModel = self.filterDocuments?[indexPath.row]
        if let serverUrl = rowModel?.ServerRelativeUrl {
            let urlStr = "https://sjaasj.sharepoint.com/sites/VMSSandbox/_api/Web/GetFileByServerRelativePath(decodedurl='\(serverUrl)')/$value"
            if let url = URL(string: urlStr.replacingOccurrences(of: " ", with: "%20")) {
                
                ENTALDHttpClient.shared.downloadFile(using: url, access_token : self.access_token, file_Name:rowModel?.Name) { data, error in
                    if error == nil {
                        ENTALDAlertView.shared.showContactAlertWithTitle(title: "File Downloaded", message: "Go to Files app in your phone, press on browse tab and select On My iPhone. You will get SJA Impact folder with downloaded files.", actionTitle: .KOK, completion: { status in })
                    }
                }
            }
        }
    }
    
}
