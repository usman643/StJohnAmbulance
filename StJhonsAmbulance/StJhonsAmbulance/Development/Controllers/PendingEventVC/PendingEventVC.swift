//
//  PendingEventVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 28/01/2023.
//

import UIKit

class PendingEventVC: ENTALDBaseViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var selectGroupView: UIView!
    @IBOutlet weak var btnSelectGroup: UIButton!
    
    @IBOutlet weak var lblPending: UILabel!
    @IBOutlet weak var btnPendingFilter: UIButton!
    @IBOutlet weak var btnApprovalFilter: UIButton!
    @IBOutlet weak var lblApproval: UILabel!
   
    
    @IBOutlet weak var pendingStackView: UIStackView!
    @IBOutlet weak var approvalStackView: UIStackView!
   
    
    @IBOutlet weak var pendingHeaderView: UIView!
    @IBOutlet weak var approvalHeaderView: UIView!
   
    
    @IBOutlet weak var pendingTableView: UITableView!
    @IBOutlet weak var approvalTableView: UITableView!
  
    
    @IBOutlet weak var lblPendingName: UILabel!
    @IBOutlet weak var lblPendingLocation: UILabel!
    @IBOutlet weak var lblPendingMax: UILabel!
    @IBOutlet weak var lblPendingDate: UILabel!
    @IBOutlet weak var lblPendingStatus: UILabel!
    @IBOutlet weak var lblApprovalName: UILabel!
    @IBOutlet weak var lblApprovalLocation: UILabel!
    @IBOutlet weak var lblApprovalMax: UILabel!
    @IBOutlet weak var lblApprovalDate: UILabel!
    @IBOutlet weak var lblApprovalStatus: UILabel!
 
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pendingTableView.delegate = self
        pendingTableView.dataSource = self
        pendingTableView.register(UINib(nibName: "PendingEventTVC", bundle: nil), forCellReuseIdentifier: "PendingEventTVC")
    
        approvalTableView.delegate = self
        approvalTableView.dataSource = self
        approvalTableView.register(UINib(nibName: "PendingEventTVC", bundle: nil), forCellReuseIdentifier: "PendingEventTVC")
        decorateUI()
        
        self.btnSelectGroup.setTitle("\(ProcessUtils.shared.selectedUserGroup?.sjavms_RoleType?.getRoleType() ?? "")", for: .normal)
    }

    func decorateUI(){
        selectGroupView.layer.cornerRadius = 3
 
        pendingHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        approvalHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
     
        
        pendingHeaderView.layer.borderWidth = 1.5
        approvalHeaderView.layer.borderWidth = 1.5
      
        lblApproval.font = UIFont.BoldFont(20)
        lblApproval.textColor = UIColor.themePrimaryColor
        lblPending.font = UIFont.BoldFont(20)
        lblPending.textColor = UIColor.themePrimaryColor
       
        
        lblPendingName.font = UIFont.BoldFont(12)
        lblPendingLocation.font = UIFont.BoldFont(12)
        lblPendingMax.font = UIFont.BoldFont(12)
        lblPendingDate.font = UIFont.BoldFont(12)
        lblPendingStatus.font = UIFont.BoldFont(12)
        lblApprovalName.font = UIFont.BoldFont(12)
        lblApprovalLocation.font = UIFont.BoldFont(12)
        lblApprovalMax.font = UIFont.BoldFont(12)
        lblApprovalDate.font = UIFont.BoldFont(12)
        lblApprovalStatus.font = UIFont.BoldFont(12)
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        
        btnSelectGroup.setTitleColor(UIColor.textWhiteColor, for: .normal)
        lblPendingName.textColor = UIColor.themePrimaryColor
        lblPendingLocation.textColor = UIColor.themePrimaryColor
        lblPendingMax.textColor = UIColor.themePrimaryColor
        lblPendingDate.textColor = UIColor.themePrimaryColor
        lblPendingStatus.textColor = UIColor.themePrimaryColor
        lblApprovalName.textColor = UIColor.themePrimaryColor
        lblApprovalLocation.textColor = UIColor.themePrimaryColor
        lblApprovalMax.textColor = UIColor.themePrimaryColor
        lblApprovalDate.textColor = UIColor.themePrimaryColor
        lblApprovalStatus.textColor = UIColor.themePrimaryColor
        
        pendingTableView.clipsToBounds = false
        pendingTableView.layer.masksToBounds = false
        pendingTableView.layer.shadowColor = UIColor.lightGray.cgColor
        pendingTableView.layer.shadowOffset = CGSize(width: 0, height: 0)
        pendingTableView.layer.shadowRadius = 0.0
        pendingTableView.layer.shadowOpacity = 1.0
        
        approvalTableView.clipsToBounds = false
        approvalTableView.layer.masksToBounds = false
        approvalTableView.layer.shadowColor = UIColor.lightGray.cgColor
        approvalTableView.layer.shadowOffset = CGSize(width: 0, height: 0)
        approvalTableView.layer.shadowRadius = 0.0
        approvalTableView.layer.shadowOpacity = 1.0
        
      
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
        
    }
    
    @IBAction func selectGroupTapped(_ sender: Any) {
        showGroupsPicker()
    }
    
    @IBAction func pendingFilterTapped(_ sender: Any) {
    }
    
    @IBAction func approvalFilterTapped(_ sender: Any) {
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

extension PendingEventVC: UITableViewDelegate,UITableViewDataSource ,UITextViewDelegate, UIActionSheetDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PendingEventTVC", for: indexPath) as! PendingEventTVC
        if indexPath.row % 2 == 0{
            cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
            cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
        }else{
            cell.mainView.backgroundColor = UIColor.viewLightColor
            cell.seperaterView.backgroundColor = UIColor.gray
        }
        
//        cell.lblName.text =
//        cell.lblLocation.text =
//        cell.lblMax.text =
//        cell.lblDate.text =
//        cell.lblStatus.text =

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PendingEventTVC", for: indexPath) as! PendingEventTVC
        showActionSheet(pointView: cell.mainView, arrIndex:indexPath.row)
    }
    
   
    
    func showActionSheet(pointView:UIView, arrIndex : Int) {
        
        let alert = UIAlertController(title: "Action", message: "Please choose action", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { action in
            
            
        }))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
        }))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = pointView
            popoverController.sourceRect = pointView.bounds
        }
        
        present(alert, animated: true)
    }
    
    
}
