//
//  VolunteerMessageVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 19/10/2023.
//

import UIKit

class VolunteerMessageVC: ENTALDBaseViewController {
        
        var volunteerData : [InAppVolunteerDataModel]?
        var filterVolunteerData : [InAppVolunteerDataModel]?
        
        @IBOutlet weak var headerView: UIView!
        @IBOutlet weak var lblTitle: UILabel!
        @IBOutlet weak var volunteerTableView: UITableView!
        @IBOutlet weak var volunteerView: UIView!
        @IBOutlet weak var searchView: UIView!
        @IBOutlet weak var searchImg: UIImageView!
        @IBOutlet weak var textSearch: UITextField!
        
    @IBOutlet weak var btnMessage: UIButton!
    override func viewDidLoad() {
            super.viewDidLoad()
            decorateUI()
            registerCell()
            getVolunteers()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            self.navigationController?.navigationBar.isHidden = true
        }
        
        
        func decorateUI(){
            headerView.addBottomShadow()
            lblTitle.font = UIFont.HeaderBoldFont(18)
            lblTitle.textColor = UIColor.headerGreen
            textSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            
            searchImg.image = searchImg.image?.withRenderingMode(.alwaysTemplate)
            searchImg.tintColor = UIColor.lightGray
            let originalImage = UIImage(named: "messages-bubble-square-text")!
            let tintedImage = ProcessUtils.shared.tintImage(originalImage)
            btnMessage.setImage(tintedImage, for: .normal)   
        }
 
        func registerCell(){
            volunteerTableView.delegate = self
            volunteerTableView.dataSource = self
            volunteerTableView.register(UINib(nibName: "VolunteerMessageTVC", bundle: nil), forCellReuseIdentifier: "VolunteerMessageTVC")
        }
        
        @IBAction func backTapped(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            
            if (textField.text != ""){
                
                filterVolunteerData  =  volunteerData?.filter({
                    if let name = $0.fullname, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                        return true
                    }
                    return false
                })
                DispatchQueue.main.async {
                    self.volunteerTableView.reloadData()
                }
            }
        }
        
        //==================== Schedule API =====================
        
        
        func getVolunteers(){
            let groupList =   ProcessUtils.shared.groupListValue ?? ""
            let params : [String:Any] = [
                
                ParameterKeys.select : "contactid,fullname",
    //            ParameterKeys.expand : "",
                ParameterKeys.filter : "(msnfp_volunteer eq true and statuscode eq 1)",
                ParameterKeys.orderby : "fullname asc"
            ]
            
            self.getVolunteersData(params: params)
        }
        
        
        
        fileprivate func getVolunteersData(params : [String:Any]){
            DispatchQueue.main.async {
                LoadingView.show()
            }
            
            ENTALDLibraryAPI.shared.getVolunteersData(params: params){ result in
                DispatchQueue.main.async {
                    LoadingView.hide()
                }
                
                switch result{
                case .success(value: let response):
                    
                    if var volunteers = response.value {
                        let loggedInContact = "\(UserDefaults.standard.userInfo?.contactid ?? "")"
                        volunteers.removeAll(where: {$0.contactid == loggedInContact})
                        self.volunteerData = volunteers
                        self.filterVolunteerData = volunteers
                        if (self.volunteerData?.count == 0 || self.volunteerData?.count == nil){
                            self.showEmptyView(tableVw: self.volunteerTableView)
                        }else{
                            
                            DispatchQueue.main.async {
                                for subview in self.volunteerTableView.subviews {
                                    subview.removeFromSuperview()
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.volunteerTableView.reloadData()
                        }
                    }else{
                        self.showEmptyView(tableVw: self.volunteerTableView)
                    }
                    
                case .error(let error, let errorResponse):
                    var message = error.message
                    if let err = errorResponse {
                        message = err.error
                    }
                    self.showEmptyView(tableVw: self.volunteerTableView)
                    DispatchQueue.main.async {
                        ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                    }
                }
            }
        }
        
   
        fileprivate func getCheckInData(eventOppId:String, completion:@escaping((_ model : CheckInResponseModel?) -> Void )){
            
            let params : [String:Any] = [
                
                ParameterKeys.select : "fullname,telephone1,_ownerid_value,emailaddress1,bdo_province,address1_postalcode,address1_city,bdo_contactid,_parentcustomerid_value,contactid,entityimage",
                ParameterKeys.expand : "sjavms_contact_msnfp_participationschedule_Volunteer($select=sjavms_checkedin,sjavms_checkedinlatitude,sjavms_checkedinlongitude,sjavms_checkedinlatitudevalue,sjavms_checkedinlongitudevalue,sjavms_checkedinat,sjavms_checkedinlocation;$filter=(_sjavms_volunteerevent_value eq \(eventOppId) and msnfp_schedulestatus eq 335940000))",
                ParameterKeys.filter : "(sjavms_contact_msnfp_participationschedule_Volunteer/any(o1:(o1/_sjavms_volunteerevent_value eq \(eventOppId) and o1/msnfp_schedulestatus eq 335940000)))",
                ParameterKeys.orderby : "fullname asc"
            ]
            
            DispatchQueue.main.async {
                LoadingView.show()
            }
            
            ENTALDLibraryAPI.shared.requestCheckInData(params: params){ result in
                DispatchQueue.main.async {
                    LoadingView.hide()
                }
                
                switch result{
                case .success(value: let response):
                    completion(response)
                    
                    //                if let checkInData = response.value {
                    //                    self.checkInData = checkInData
                    //                    if ((self.checkInData?.count ?? 0) > 0){
                    //                        self.mapData.append(contentsOf: (checkInData))
                    //                    }
                    //                }
                    
                case .error(let error, let errorResponse):
                    //                completion(nil)
                    var message = error.message
                    if let err = errorResponse {
                        message = err.error
                    }
                    print("Error Message \(message)")
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


    extension VolunteerMessageVC : UITableViewDelegate,UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return filterVolunteerData?.count ?? 0
            
            
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "VolunteerMessageTVC", for: indexPath) as! VolunteerMessageTVC
                cell.lblName.text = filterVolunteerData?[indexPath.row].fullname ?? ""
//                    cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
        
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                ENTALDControllers.shared.showSignalRVC(type: .ENTALDPUSH, from: self, eventId: filterVolunteerData?[indexPath.row].contactid ?? "", dataObj: filterVolunteerData?[indexPath.row] , eventType : "volunteer" , callBack: nil)
        }
        
    }

