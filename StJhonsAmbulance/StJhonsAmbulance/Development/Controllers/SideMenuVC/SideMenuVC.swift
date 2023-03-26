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
    var navigation:SideMenuVC?
    var arrMenuList = ["Profile","Availability","Skills","Qualifications/Certifications","Documents","Language","Change Password","Settings","Logout"]
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
    
    func decorateUI(){
        
        lblName.font = UIFont.BoldFont(14)
        lblEmail.font = UIFont.BoldFont(14)
        lblName.textColor = UIColor.textWhiteColor
        lblEmail.textColor = UIColor.textWhiteColor
        lblName.text = UserDefaults.standard.userInfo?.fullname
        lblEmail.text = UserDefaults.standard.userInfo?.emailaddress1
        imgMainVw.layer.cornerRadius = imgMainVw.frame.size.height/2
        profileImage.image = ProcessUtils.shared.convertBase64StringToImage(imageBase64String: UserDefaults.standard.userInfo?.entityimage ?? "")
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
        
        if (ProcessUtils.shared.currentRole == "cslead"){
            self.btnSwitch.setOn(false, animated: true)
            ProcessUtils.shared.currentRole = "volunteer"
//            self.lblRole.text = "Volunteer"
            ENTALDControllers.shared.showVolunteerDashBoardScreen(type: .ENTALDPUSH, from: UIApplication.getTopViewController()) { params, controller in
            }
        }else{
            self.btnSwitch.setOn(false, animated: true)
            ProcessUtils.shared.currentRole = "cslead"
//            self.lblRole.text = "CS Lead"
            ENTALDControllers.shared.showCSDashBoardScreen(type: .ENTALDPUSH, from: UIApplication.getTopViewController()) { params, controller in
            }
        }
        
        
    }
    
}

protocol MenuControllerDelegate {
    func didSelectMenuItem(named: String)
}
