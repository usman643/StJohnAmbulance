//
//  EventVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 27/01/2023.
//

import UIKit

class EventVC: ENTALDBaseViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var selectGroupView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSelectGroup: UIButton!
    @IBOutlet weak var btnCreateEvent: UIButton!
    @IBOutlet weak var lblCurrent: UILabel!
    @IBOutlet weak var btnCurrentFilter: UIButton!
    @IBOutlet weak var btnUpcomingFilter: UIButton!
    @IBOutlet weak var btnPastFilter: UIButton!
    @IBOutlet weak var lblUpcoming: UILabel!
    @IBOutlet weak var lblPast: UILabel!
    
    @IBOutlet weak var currentStackView: UIStackView!
    @IBOutlet weak var upcomingStackView: UIStackView!
    @IBOutlet weak var pastStackView: UIStackView!
    
    @IBOutlet weak var currentHeaderView: UIView!
    @IBOutlet weak var upcomingHeaderView: UIView!
    @IBOutlet weak var pastHeaderView: UIView!
    
    @IBOutlet weak var currentTableView: UITableView!
    @IBOutlet weak var upcomingTableView: UITableView!
    @IBOutlet weak var pastTableView: UITableView!
    
    @IBOutlet weak var lblCurrentEvent: UILabel!
    @IBOutlet weak var lblCurrentLocation: UILabel!
    @IBOutlet weak var lblCurrentStart: UILabel!
    @IBOutlet weak var lblCurrentEnd: UILabel!
    @IBOutlet weak var lblCurrentNeeded: UILabel!
    @IBOutlet weak var lblUpcomingEvent: UILabel!
    @IBOutlet weak var lblUpcomingLocation: UILabel!
    @IBOutlet weak var lblUpcomingStart: UILabel!
    @IBOutlet weak var lblUpcomingEnd: UILabel!
    @IBOutlet weak var lblUpcomingNeeded: UILabel!
    @IBOutlet weak var lblPastEvent: UILabel!
    @IBOutlet weak var lblPastLocation: UILabel!
    @IBOutlet weak var lblPastDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentTableView.delegate = self
        currentTableView.dataSource = self
        currentTableView.register(UINib(nibName: "EventTVC", bundle: nil), forCellReuseIdentifier: "EventTVC")
        
        upcomingTableView.delegate = self
        upcomingTableView.dataSource = self
        upcomingTableView.register(UINib(nibName: "EventTVC", bundle: nil), forCellReuseIdentifier: "EventTVC")
        
        pastTableView.delegate = self
        pastTableView.dataSource = self
        pastTableView.register(UINib(nibName: "PastEventTVC", bundle: nil), forCellReuseIdentifier: "PastEventTVC")
        
        self.btnSelectGroup.setTitle("\(ProcessUtils.shared.selectedUserGroup?.sjavms_RoleType?.getRoleType() ?? "")", for: .normal)
        
        decorateUI()
        
        
    }

    func decorateUI(){
        selectGroupView.layer.cornerRadius = 3
        btnSelectGroup.layer.cornerRadius = 3
        btnCreateEvent.layer.cornerRadius = 3
        lblTitle.font = UIFont.BoldFont(20)
        lblTitle.textColor = UIColor.themePrimaryColor
        
        currentHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        upcomingHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        pastHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        currentHeaderView.layer.borderWidth = 1.5
        upcomingHeaderView.layer.borderWidth = 1.5
        pastHeaderView.layer.borderWidth = 1.5
        lblUpcoming.font = UIFont.BoldFont(16)
        lblUpcoming.textColor = UIColor.themePrimaryColor
        lblCurrent.font = UIFont.BoldFont(16)
        lblCurrent.textColor = UIColor.themePrimaryColor
        lblPast.font = UIFont.BoldFont(16)
        lblPast.textColor = UIColor.themePrimaryColor
        btnSelectGroup.titleLabel?.font = UIFont.BoldFont(14)
        btnCreateEvent.titleLabel?.font = UIFont.BoldFont(12)
        
        btnSelectGroup.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnCreateEvent.setTitleColor(UIColor.textWhiteColor, for: .normal)
        lblCurrentEvent.font = UIFont.BoldFont(12)
        lblCurrentLocation.font = UIFont.BoldFont(12)
        lblCurrentStart.font = UIFont.BoldFont(12)
        lblCurrentEnd.font = UIFont.BoldFont(12)
        lblCurrentNeeded.font = UIFont.BoldFont(12)
        lblUpcomingEvent.font = UIFont.BoldFont(12)
        lblUpcomingLocation.font = UIFont.BoldFont(12)
        lblUpcomingStart.font = UIFont.BoldFont(12)
        lblUpcomingEnd.font = UIFont.BoldFont(12)
        lblUpcomingNeeded.font = UIFont.BoldFont(12)
        lblPastEvent.font = UIFont.BoldFont(12)
        lblPastLocation.font = UIFont.BoldFont(12)
        lblPastDate.font = UIFont.BoldFont(12)
        
        lblCurrentEvent.textColor = UIColor.themePrimaryColor
        lblCurrentLocation.textColor = UIColor.themePrimaryColor
        lblCurrentStart.textColor = UIColor.themePrimaryColor
        lblCurrentEnd.textColor = UIColor.themePrimaryColor
        lblCurrentNeeded.textColor = UIColor.themePrimaryColor
        lblUpcomingEvent.textColor = UIColor.themePrimaryColor
        lblUpcomingLocation.textColor = UIColor.themePrimaryColor
        lblUpcomingStart.textColor = UIColor.themePrimaryColor
        lblUpcomingEnd.textColor = UIColor.themePrimaryColor
        lblUpcomingNeeded.textColor = UIColor.themePrimaryColor
        lblPastEvent.textColor = UIColor.themePrimaryColor
        lblPastLocation.textColor = UIColor.themePrimaryColor
        lblPastDate.textColor = UIColor.themePrimaryColor
        
        currentTableView.clipsToBounds = false
        currentTableView.layer.masksToBounds = false
        currentTableView.layer.shadowColor = UIColor.lightGray.cgColor
        currentTableView.layer.shadowOffset = .zero
        currentTableView.layer.shadowRadius = 0
        currentTableView.layer.shadowOpacity = 0.5
        
        upcomingTableView.clipsToBounds = false
        upcomingTableView.layer.masksToBounds = false
        upcomingTableView.layer.shadowColor = UIColor.lightGray.cgColor
        upcomingTableView.layer.shadowOffset = .zero
        upcomingTableView.layer.shadowRadius = 0
        upcomingTableView.layer.shadowOpacity = 0.5
        
        pastTableView.clipsToBounds = false
        pastTableView.layer.masksToBounds = false
        pastTableView.layer.shadowColor = UIColor.lightGray.cgColor
        pastTableView.layer.shadowOffset = .zero
        pastTableView.layer.shadowRadius = 0
        pastTableView.layer.shadowOpacity = 0.5
       
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
        
    }
    
    @IBAction func selectGroupTapped(_ sender: Any) {
        showGroupsPicker()
    }
    
    @IBAction func currentFilterTapped(_ sender: Any) {
        
    }
    
    @IBAction func upcomingFilterTapped(_ sender: Any) {
        
    }
    
    @IBAction func pastFilterTapped(_ sender: Any) {
        
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


extension EventVC: UITableViewDelegate,UITableViewDataSource ,UITextViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "PastEventTVC", for: indexPath)
        
        if (tableView == self.pastTableView){
           let  cell = tableView.dequeueReusableCell(withIdentifier: "PastEventTVC", for: indexPath) as! PastEventTVC
            if indexPath.row % 2 == 0{
                cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
                cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
            }else{
                cell.mainView.backgroundColor = UIColor.viewLightColor
                cell.seperaterView.backgroundColor = UIColor.gray
            }
            return cell
        }else{
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTVC", for: indexPath) as! EventTVC
            if indexPath.row % 2 == 0{
                cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
                cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
            }else{
                cell.mainView.backgroundColor = UIColor.viewLightColor
                cell.seperaterView.backgroundColor = UIColor.gray
            }
            return cell
        }
        
        
        
//        cell.lblEvent.text =
//        cell.lblLocation.text =
//        cell.lblStart.text =
//        cell.lblEnd.text =
//        cell.lblNeeded.text =
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    
}
