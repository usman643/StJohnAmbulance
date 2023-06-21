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
    
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblCSLead: UILabel!
    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var lblYearsOfService: UILabel!
    @IBOutlet weak var lblCurrentYearHours: UILabel!
    @IBOutlet weak var lblLastYearHours: UILabel!
    @IBOutlet weak var lblLifetimeHours: UILabel!
    
    
    var navigation:SideMenuVC?
//    var arrMenuList = ["Profile","Availability","Skills","Qualifications/Certifications","Documents","Language","Change Password","Settings","Logout"]
    var arrMenuList = ["Profile","Availability","Honours & Awards","Qualifications/Certifications","Documents","Language","Change Password","Settings","Logout"]
//    var arrMenuIconList = ["ic_profile","ic_availability","ic_skill","ic_Qualification","ic_document","ic_language","ic_passKey","ic_setting","ic_logout"]
    var arrMenuIconList = ["ic_profile","ic_availability","ic_skill","ic_Qualification","ic_document","ic_language","ic_passKey","ic_setting","ic_logout"]
    public var delegate: MenuControllerDelegate?
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource =  self
        self.tableView.register(UINib(nibName: "SideMenuTVC", bundle: nil), forCellReuseIdentifier: "SideMenuTVC")
        decorateUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func decorateUI(){
        
        lblName.font = UIFont.BoldFont(14)
        lblEmail.font = UIFont.BoldFont(14)
        lblYearsOfService.font = UIFont.BoldFont(14)
        lblCurrentYearHours.font = UIFont.BoldFont(14)
        lblLastYearHours.font = UIFont.BoldFont(14)
        lblLifetimeHours.font = UIFont.BoldFont(14)
        lblName.textColor = UIColor.textWhiteColor
        lblEmail.textColor = UIColor.textWhiteColor
        lblYearsOfService.textColor = UIColor.textWhiteColor
        lblCurrentYearHours.textColor = UIColor.textWhiteColor
        lblLastYearHours.textColor = UIColor.textWhiteColor
        lblLifetimeHours.textColor = UIColor.textWhiteColor
        
        lblName.text = UserDefaults.standard.userInfo?.fullname
        lblEmail.text = UserDefaults.standard.userInfo?.emailaddress1
        
        lblYearsOfService.text = "Years of Service : \(UserDefaults.standard.userInfo?.sjavms_qualifiedyearsofservice?.getFormattedNumber() ?? "")"
        lblCurrentYearHours.text = "Hours Current Year : \(UserDefaults.standard.userInfo?.sjavms_totalhourscompletedthisyear?.getFormattedNumber() ?? "")"
        lblLastYearHours.text = "Last Year Hours : \(UserDefaults.standard.userInfo?.sjavms_totalhourscompletedpreviousyear?.getFormattedNumber() ?? "")"
        lblLifetimeHours.text = "Lifetime Hours : \(UserDefaults.standard.userInfo?.msnfp_totalengagementhours?.getFormattedNumber() ?? "")"
        
        imgMainVw.layer.cornerRadius = imgMainVw.frame.size.height/2
        profileImage.image = ProcessUtils.shared.convertBase64StringToImage(imageBase64String: UserDefaults.standard.userInfo?.entityimage ?? "") ?? UIImage(named: "ic_profile")
        lblRole.font = UIFont.RegularFont(14)
        lblRole.textColor = UIColor.textWhiteColor
        lblCSLead.font = UIFont.RegularFont(14)
        lblCSLead.textColor = UIColor.textWhiteColor
        
        if (ProcessUtils.shared.currentRole == "cslead"){
//            self.lblRole.text = "CS Lead"
            self.btnSwitch.setOn(true, animated: true)
        }else{
            self.btnSwitch.setOn(false, animated: true)
//            self.lblRole.text = "Volunteer"
        }
        
        btnSwitch.onTintColor = UIColor.themePrimaryColor
        
        if ProcessUtils.shared.userGroupsList.count == 0 {
            self.btnSwitch.isHidden = true
            lblCSLead.isHidden = true
            return
        }
        
    }

    
    
    // MARK: Table View Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTVC", for: indexPath) as! SideMenuTVC
        cell.lblTitle.text = arrMenuList[indexPath.row]
        cell.icon.image = UIImage(named: arrMenuIconList[indexPath.row])
        cell.icon.image = cell.icon.image?.withRenderingMode(.alwaysTemplate)
        cell.icon.tintColor  = UIColor.textWhiteColor
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
            let selectedItem = arrMenuList[indexPath.row]
            self.dismiss(animated: true, completion: nil)
            //            self.tblSideMenuList.deselectRow(at: indexPath, animated: true)
            delegate?.didSelectMenuItem(named: selectedItem)
        
    }
    
    @IBAction func switchRole(_ sender: Any) {
        
        if ProcessUtils.shared.userGroupsList.count == 0 {
            return
        }
        
        
        if (ProcessUtils.shared.currentRole == "cslead"){
            self.btnSwitch.setOn(false, animated: true)
            ProcessUtils.shared.currentRole = "volunteer"
//            self.lblRole.text = "Volunteer"
//            ENTALDControllers.shared.showVolunteerDashBoardScreen(type: .ENTALDPUSH, from: UIApplication.getTopViewController()) { params, controller in
//            }
//            self.navigationController?.popViewController(animated: true)
            ENTALDControllers.shared.startFlowfromLandingScreen(from: UIApplication.getTopViewController()) { params, controller in
                
            }
            
            
            
        }else{
            self.btnSwitch.setOn(true, animated: true)
            ProcessUtils.shared.currentRole = "cslead"
//            self.lblRole.text = "CS Lead"
//            self.navigationController?.popViewController(animated: false)
            self.dismiss(animated: true, completion: nil)
            if let vc = UIApplication.shared.windows.first?.rootViewController as? ENTALDBaseNavigationController, let child = vc.children.first as? ENTALDTabbarViewController, let nvc = child.viewControllers?[child.selectedIndex] as? ENTALDBaseNavigationController, let avc = nvc.children.first  {
                ENTALDControllers.shared.showCSDashBoardScreen(type: .ENTALDPUSH, from: avc) { params, controller in
                    
                    
                }
                
            }
        }
    }
}



protocol MenuControllerDelegate {
    func didSelectMenuItem(named: String)
}
