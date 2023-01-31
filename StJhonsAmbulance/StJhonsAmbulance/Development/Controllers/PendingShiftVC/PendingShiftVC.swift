//
//  PendingShiftVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 27/01/2023.
//

import UIKit

class PendingShiftVC: ENTALDBaseViewController {
    
    var pendingShiftData : [PendingShiftModel]?

    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnSelectGroup: UIButton!
    @IBOutlet weak var btnGroupView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
 
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblShift: UILabel!
    @IBOutlet weak var lblAction: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PendingShiftTVC", bundle: nil), forCellReuseIdentifier: "PendingShiftTVC")
        
        decorateUI()
        getPendingShift()
        self.btnSelectGroup.setTitle("\(ProcessUtils.shared.selectedUserGroup?.sjavms_RoleType?.getRoleType() ?? "")", for: .normal)
    }
    
    func decorateUI(){
        
        lblTitle.font = UIFont.BoldFont(20)
        lblSubTitle.font = UIFont.BoldFont(16)
        lblName.font = UIFont.BoldFont(12)
        lblName.font = UIFont.BoldFont(12)
        lblEvent.font = UIFont.BoldFont(12)
        lblDate.font = UIFont.BoldFont(12)
        lblHours.font = UIFont.BoldFont(12)
        lblShift.font = UIFont.BoldFont(12)
        lblAction.font = UIFont.BoldFont(12)
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        
        btnSelectGroup.setTitleColor(UIColor.textWhiteColor, for: .normal)
        lblTitle.textColor = UIColor.themePrimaryColor
        lblSubTitle.textColor = UIColor.themePrimaryColor
        lblName.textColor = UIColor.themePrimaryColor
        lblName.textColor = UIColor.themePrimaryColor
        lblEvent.textColor = UIColor.themePrimaryColor
        lblDate.textColor = UIColor.themePrimaryColor
        lblHours.textColor = UIColor.themePrimaryColor
        lblShift.textColor = UIColor.themePrimaryColor
        lblAction.textColor = UIColor.themePrimaryColor
        
        tableHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        tableHeaderView.layer.borderWidth = 1.5
        
        btnGroupView.layer.cornerRadius = 3
       
        
    }
    
    

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectGroupTapped(_ sender: Any) {
        showGroupsPicker()
    }
    

    @IBAction func searchCloseTapped(_ sender: Any) {
        
    }
    
    func showGroupsPicker(list:[LandingGroupsModel] = []){
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, dataObj: ProcessUtils.shared.userGroupsList) { params, controller in
            
            if let data = params as? LandingGroupsModel {
                ProcessUtils.shared.selectedUserGroup = data
                
                self.btnSelectGroup.setTitle("\(data.msnfp_groupId?.getGroupName() ?? "")", for: .normal)
                
            }
        }
    }
    
}


extension PendingShiftVC: UITableViewDelegate,UITableViewDataSource ,UITextViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingShiftData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PendingShiftTVC", for: indexPath) as! PendingShiftTVC
        if indexPath.row % 2 == 0{
            cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
            cell.dividerView.backgroundColor = UIColor.themePrimaryColor
        }else{
            cell.mainView.backgroundColor = UIColor.viewLightColor
            cell.dividerView.backgroundColor = UIColor.gray
        }
        
        let rowModel = pendingShiftData?[indexPath.row]
        cell.setCellData(rowModel : rowModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    
    
    
    func getPendingShift(){
        
//            guard let conId = UserDefaults.standard.contactIdToken else {return}
        guard let fullName = UserDefaults.standard.userInfo?.fullname else {return}
            let params : [String:Any] = [
                
                
                ParameterKeys.select : "msnfp_name,createdon,msnfp_participationscheduleid,msnfp_schedulestatus,sjavms_start,sjavms_hours,_sjavms_volunteerevent_value,_sjavms_volunteer_value,msnfp_participationscheduleid",
                
                ParameterKeys.expand : "sjavms_Volunteer($select=fullname)",
                ParameterKeys.filter : "(Microsoft.Dynamics.CRM.In(PropertyName='sjavms_volunteerevent',PropertyValues=['{92aa2a1d-2d6c-ed11-81ac-0022486dfdbd}','{284fd341-0e4f-ed11-bba3-0022486dccc4}','{4238f255-0c86-ed11-81ac-000d3af4abef}','{9776fb59-9b80-ed11-81ad-0022486dccc4}','{d878db6d-a280-ed11-81ad-0022486dccc4}','{0243fc0b-d274-ed11-81ac-0022486dfdbd}','{7b947a1e-124f-ed11-bba3-0022486dccc4}','{29d82d41-1b78-ed11-81ac-0022486dfdbd}','{8be3303e-1c78-ed11-81ad-000d3af4aae6}','{351b55e1-4377-ed11-81ac-0022486dccc4}','{a9071130-dd91-ed11-aad1-0022486dfdbd}','{ff717a03-1278-ed11-81ac-0022486dfdbd}','{94134b71-0f39-ed11-9db1-0022486dfdbd}','{fc4d027f-0f4f-ed11-bba3-0022486dccc4}','{21523d6f-a380-ed11-81ad-0022486dccc4}','{9af211f8-514e-ed11-bba3-0022486dccc4}','{0b01ca80-554e-ed11-bba3-0022486dccc4}','{c484c86b-ee4e-ed11-bba3-0022486dccc4}','{6b11cfdc-0c4f-ed11-bba3-0022486dccc4}','{cb8ed467-124f-ed11-bba3-0022486dccc4}','{0ea28681-1078-ed11-81ac-0022486dfdbd}']))",
                ParameterKeys.orderby : "msnfp_name asc"
                
            ]
            
            self.getPendingShiftData(params: params)
        
    }
    
    fileprivate func getPendingShiftData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestPendingShifts(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let pendingShift = response.value {
                    self.pendingShiftData = pendingShift
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
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
