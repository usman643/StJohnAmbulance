//
//  SideMenuVC.swift
//  WIT Edu
//
//  Created by Umair Yousaf on 14/08/2022.
//

import UIKit
import SideMenu


class SideMenuVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // MARK: Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgMainVw: UIView!
    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var lblYearsOfService: UILabel!
    @IBOutlet weak var lblCurrentYearHours: UILabel!
    @IBOutlet weak var lblLastYearHours: UILabel!
    @IBOutlet weak var lblLifetimeHours: UILabel!
    
    @IBOutlet weak var lblSJAImpact: UILabel!
    
    var navigation:SideMenuVC?

//    var arrMenuList = ["Profile","Availability","Honours & Awards","Qualifications/Certifications","Documents","Language","Change Password","Settings","Logout"]
//    var arrMenuIconList = ["ic_profile","ic_availability","ic_skill","ic_Qualification","ic_document","ic_language","ic_passKey","ic_setting","ic_logout"]
//
    
    var arrMenuList = ["Qualifications", "Documents", "Awards", "Settings","Logout"]
    var arrMenuIconList = ["ic_Qualification","ic_document","ic_skill","ic_setting","ic_logout"]
    
    var leadMenuList = ["Qualifications","Documents","Awards","Shifts","Event","Volunteers","Settings","Logout"]
    var leadMenuIconList = ["ic_Qualification","ic_document","ic_skill","time-clock-nine-to-twelve","manageEvent","presentation-audience", "ic_setting","ic_logout"]
    
    
    
    public var delegate: MenuControllerDelegate?
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource =  self
        self.tableView.register(UINib(nibName: "SideMenuTVC", bundle: nil), forCellReuseIdentifier: "SideMenuTVC")
        self.tableView.register(UINib(nibName: "SideMenuShiftTVC", bundle: nil), forCellReuseIdentifier: "SideMenuShiftTVC")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        decorateUI()
    }
    
    func decorateUI(){
        
        lblName.font = UIFont.BoldFont(14)
        lblEmail.font = UIFont.BoldFont(14)
        lblName.textColor = UIColor.textWhiteColor
        lblEmail.textColor = UIColor.textWhiteColor
        lblName.text = UserDefaults.standard.userInfo?.fullname
        lblEmail.text = UserDefaults.standard.userInfo?.emailaddress1
        imgMainVw.layer.cornerRadius = imgMainVw.frame.size.height/2
        profileImage.image = ProcessUtils.shared.convertBase64StringToImage(imageBase64String: UserDefaults.standard.userInfo?.entityimage ?? "") ?? UIImage(named: "ic_profile")
        lblSJAImpact.text = "SJA Impact".localized
    }

    @IBAction func ProfileBtnTapped(_ sender: Any) {
        
        let selectedItem = "Profile"
        self.dismiss(animated: true, completion: nil)
        //            self.tblSideMenuList.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectMenuItem(named: selectedItem)
    }
    
    
    // MARK: Table View Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ProcessUtils.shared.userGroupsList.count == 0 {
            return arrMenuList.count
            
        }else{
            return leadMenuList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var title : String!
        var icon : String!
        if ProcessUtils.shared.userGroupsList.count == 0 {
            title = arrMenuList[indexPath.row]
            icon = arrMenuIconList[indexPath.row]
        }else{
            title = leadMenuList[indexPath.row]
            icon = leadMenuIconList[indexPath.row]
        }
        if (title == "Shifts"){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuShiftTVC", for: indexPath) as! SideMenuShiftTVC
            cell.lblTitle.text = title.localized
            cell.icon.image = UIImage(named:icon)
            cell.icon.image = cell.icon.image?.withRenderingMode(.alwaysTemplate)
            cell.icon.tintColor  = UIColor.textWhiteColor
            return cell;
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTVC", for: indexPath) as! SideMenuTVC
            cell.lblTitle.text = title.localized
            if (title == "Volunteers"){
                cell.seperatorView.isHidden = false
            }else{
                cell.seperatorView.isHidden = true
            }
            cell.icon.image = UIImage(named: icon)
            cell.icon.image = cell.icon.image?.withRenderingMode(.alwaysTemplate)
            cell.icon.tintColor  = UIColor.textWhiteColor
            return cell;
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedItem : String!
        if ProcessUtils.shared.userGroupsList.count == 0 {
            selectedItem = arrMenuList[indexPath.row]
        }else{
            selectedItem = leadMenuList[indexPath.row]
        }
 
//            selectedItem = arrMenuList[indexPath.row]
            self.dismiss(animated: true, completion: nil)
            //            self.tblSideMenuList.deselectRow(at: indexPath, animated: true)
            delegate?.didSelectMenuItem(named: selectedItem)
        
    }
}



protocol MenuControllerDelegate {
    func didSelectMenuItem(named: String)
}
