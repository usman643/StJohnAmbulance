//
//  DashboardVC.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 23/01/2023.
//

import UIKit
import SideMenu

class DashboardVC: ENTALDBaseViewController,MenuControllerDelegate {
    
    var sideMenu: SideMenuVC?
    var menu: SideMenuNavigationController?
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var btnSideMenu: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblActiveDate: UILabel!
    @IBOutlet weak var lblTotalHours: UILabel!
    @IBOutlet weak var lblServiceYears: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var campView: UIView!
    @IBOutlet weak var campImgView: UIImageView!
    @IBOutlet weak var lblCamp: UILabel!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageImgView: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var checkInView: UIView!
    @IBOutlet weak var checkInImgView: UIImageView!
    @IBOutlet weak var lblCheckIn: UILabel!
    
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var calenderImgView: UIImageView!
    @IBOutlet weak var lblCalender: UILabel!
    
    @IBOutlet weak var hourView: UIView!
    @IBOutlet weak var hourImgView: UIImageView!
    @IBOutlet weak var lblHour: UILabel!
    
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var eventImgView: UIImageView!
    @IBOutlet weak var lblEvent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
        setSideMenu()
        
    }

    func setSideMenu(){
        
        self.sideMenu = SideMenuVC()
        if let list = sideMenu {
            
            list.delegate = self
            self.menu = SideMenuNavigationController(rootViewController: list)
            self.menu?.leftSide = false
            self.menu?.setNavigationBarHidden(true, animated: true)
            self.menu?.menuWidth = view.bounds.width * 0.8
            SideMenuManager.default.leftMenuNavigationController = menu
            SideMenuManager.default.addPanGestureToPresent(toView: self.view)
            
        }
    }

    func decorateUI(){
        
        profileImg.layer.cornerRadius = profileImg.frame.size.height/2
        campImgView.layer.cornerRadius = campImgView.frame.size.height/2
        messageImgView.layer.cornerRadius = messageImgView.frame.size.height/2
        checkInImgView.layer.cornerRadius = checkInImgView.frame.size.height/2
        calenderImgView.layer.cornerRadius = calenderImgView.frame.size.height/2
        hourImgView.layer.cornerRadius = hourImgView.frame.size.height/2
        eventImgView.layer.cornerRadius = eventImgView.frame.size.height/2
        
        campView.backgroundColor = UIColor.hexString(hex: "203152")
        messageView.backgroundColor = UIColor.hexString(hex: "DE5D41")
        checkInView.backgroundColor = UIColor.hexString(hex: "AC41DE")
        calenderView.backgroundColor = UIColor.hexString(hex: "2DD0DA")
        hourView.backgroundColor = UIColor.hexString(hex: "4151DE")
        eventView.backgroundColor = UIColor.hexString(hex: "41B8DE")
        
        lblCamp.font = UIFont.RegularFont(14)
        lblMessage.font = UIFont.RegularFont(14)
        lblCheckIn.font = UIFont.RegularFont(14)
        lblCalender.font = UIFont.RegularFont(14)
        lblHour.font = UIFont.RegularFont(14)
        lblEvent.font = UIFont.RegularFont(14)
        
        lblCamp.textColor = UIColor.themeLight
        lblMessage.textColor = UIColor.themeLight
        lblCheckIn.textColor = UIColor.themeLight
        lblCalender.textColor = UIColor.themeLight
        lblHour.textColor = UIColor.themeLight
        lblEvent.textColor = UIColor.themeLight
        
//        campView.backgroundColor = UIColor.hexString(hex: "203152")
//        messageView.backgroundColor = UIColor.hexString(hex: "DE5D41")
//        checkInView.backgroundColor = UIColor.hexString(hex: "AC41DE")
//        calenderView.backgroundColor = UIColor.hexString(hex: "2DD0DA")
        
        lblName.textColor = UIColor.themePrimary
        lblActiveDate.textColor = UIColor.hexString(hex: "727272")
        lblTotalHours.textColor = UIColor.hexString(hex: "727272")
        lblServiceYears.textColor = UIColor.hexString(hex: "727272")
        
        lblName.font = UIFont.BoldFont(24)
        lblActiveDate.font = UIFont.RegularFont(12)
        lblTotalHours.font = UIFont.RegularFont(12)
        lblServiceYears.font = UIFont.RegularFont(12)
        
    }
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        present(menu!, animated: true)
        
    }
    
    func didSelectMenuItem(named: String) {
        
        if (named == "Home") {
            dismiss(animated: true)
//            let vc = HomeVC(nibName: "HomeVC", bundle: nil)
//            self.navigationController?.pushViewController(vc , animated: true)
        }else if(named == "Logout"){
           
//            UserDefaultManger.shared.logout()
            self.navigationController?.popToRootViewController(animated: true)
            let loginvc = LoginVC(nibName: "LoginVC", bundle: nil)
            self.navigationController?.pushViewController(loginvc, animated: true)
            
        }else{
            
            dismiss(animated: true)
        }
    }
    
}
