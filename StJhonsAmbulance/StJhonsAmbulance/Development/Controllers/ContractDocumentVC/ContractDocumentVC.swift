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
    var access_token : String = ""
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblModifiedDate: UILabel!
    @IBOutlet weak var lblAction: UILabel!
    
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
        lblTitle.font = UIFont.BoldFont(12)
        lblModifiedDate.textColor = UIColor.themePrimaryWhite
        lblModifiedDate.font = UIFont.BoldFont(12)
        lblAction.textColor = UIColor.themePrimaryWhite
        lblAction.font = UIFont.BoldFont(12)
        
        
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

    
    
    @IBAction func filterTapped(_ sender: Any) {
        self.searchView.isHidden = false
        self.textSearch.placeholder = "Filter Document"
        
    }
    
    @IBAction func nameFilterTapped(_ sender: Any) {
    }
    
    @IBAction func modifiedDateFilterTapped(_ sender: Any) {
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnSearchClose.isHidden = false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
//        if (textField.text != "" ){
//            
//            filterPendingShiftData  =  pendingShiftData?.filter({
//                if let name = $0.sjavms_Volunteer?.fullname, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
//                    return true
//                }
//                return false
//            })
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }else{
//            DispatchQueue.main.async {
//                self.filterPendingShiftData = self.pendingShiftData
//                self.tableView.reloadData()
//               
//            }
//        }
        
    }
    
    
    fileprivate func getDocumentToken(){
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        let params : DynamicAuthRequest = DynamicAuthRequest(grant_type: "client_credentials", client_id: "69168eb4-986f-4198-92f5-7b3c796044ad@4eb3d202-86fa-4a81-b4de-47e3389ef4d0", resource: "00000003-0000-0ff1-ce00-000000000000/sjaasj.sharepoint.com@4eb3d202-86fa-4a81-b4de-47e3389ef4d0", client_secret: "/pbmvpnf9I2QefYYTbpBqPY7l8P1TleNGyUc7Tc8/g0=")
        
        ENTALDLibraryAPI.shared.getDocumentToken(params: params){ result in
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
                    self.getDocumentTwo()
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
        
        guard let retrivalURL =  self.relativeurlData?[0].relativeurl else {return }
        
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getContactDocumentstwoEvent(participationId: retrivalURL, externalToken: self.access_token){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let apiData = response.d {
                    self.documents = apiData.results
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
        return self.documents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactDocumentsTVC", for: indexPath) as! ContactDocumentsTVC
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowModel = self.documents?[indexPath.row]
        if let serverUrl = rowModel?.ServerRelativeUrl {
            let urlStr = "https://sjaasj.sharepoint.com/sites/VMSSandbox/_api/Web/GetFileByServerRelativePath(decodedurl='\(serverUrl)')/$value"
            ENTALDControllers.shared.showDocument(type: .ENTALDPUSH, from: self, urlStr, self.access_token) { params, controller in
                
            }
        }
        
    }
    
}
