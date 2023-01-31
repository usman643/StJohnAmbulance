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
        
        lblName.text = UserDefaults.standard.userInfo?.fullname
        lblEmail.text = UserDefaults.standard.userInfo?.emailaddress1
        imgMainVw.layer.cornerRadius = imgMainVw.frame.size.height/2
        

    
    }

    
    
    // MARK: Table View Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTVC", for: indexPath) as! SideMenuTVC
        cell.lblTitle.text = arrMenuList[indexPath.row]
        cell.imageView?.image = UIImage(named: arrMenuIconList[indexPath.row])
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
            let selectedItem = arrMenuList[indexPath.row]
            self.dismiss(animated: true, completion: nil)
            //            self.tblSideMenuList.deselectRow(at: indexPath, animated: true)
            delegate?.didSelectMenuItem(named: selectedItem)
        
    }
    
    
}

protocol MenuControllerDelegate {
    func didSelectMenuItem(named: String)
}
