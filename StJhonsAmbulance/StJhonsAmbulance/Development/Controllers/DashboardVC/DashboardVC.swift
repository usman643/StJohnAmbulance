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
    var gridData : [DashBoardGridModel]?
    var awardData : [VolunteerAwardModel]?
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var awardNumView: UIView!
    @IBOutlet weak var lblAward: UILabel!
    @IBOutlet weak var btnSideMenu: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblActiveDate: UILabel!
    @IBOutlet weak var lblTotalHours: UILabel!
    @IBOutlet weak var lblServiceYears: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var campView: UIView!
    @IBOutlet weak var campImgView: UIImageView!
    @IBOutlet weak var lblCamp: UILabel!
    @IBOutlet weak var lblCampNum: UILabel!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageImgView: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblMessageNum: UILabel!
    
    @IBOutlet weak var checkInView: UIView!
    @IBOutlet weak var checkInImgView: UIImageView!
    @IBOutlet weak var lblCheckIn: UILabel!
    
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var calenderImgView: UIImageView!
    @IBOutlet weak var lblCalender: UILabel!
    @IBOutlet weak var lblCalenderNum: UILabel!
    
    @IBOutlet weak var hourView: UIView!
    @IBOutlet weak var hourImgView: UIImageView!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var lblHourNum: UILabel!
    
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var eventImgView: UIImageView!
    @IBOutlet weak var lblEvent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
        setSideMenu()
        setupContent()
        getVolunteerAward()
//        gridData = [
//                    DashBoardGridModel(title: "", subTitle: "", bgColor: UIColor.darkBlueColor, icon: "ic_camp"),
//                    DashBoardGridModel(title: "Messages", subTitle: "02", bgColor: UIColor.orangeRedColor, icon: "ic_message"),
//                    DashBoardGridModel(title: "Volunteer", subTitle: "02", bgColor: UIColor.orangeColor, icon: "ic_communication"),
//                    DashBoardGridModel(title: "Events", subTitle: "02", bgColor: UIColor.darkFrozeColor, icon: "ic_event"),
//                    DashBoardGridModel(title: "Pending Shifts", subTitle: "02", bgColor: UIColor.lightBlueColor, icon: "ic_hour"),
//                    DashBoardGridModel(title: "Pending Events", subTitle: "06", bgColor: UIColor.themePrimaryColor, icon: "ic_pendingEvent")
//                ]
        
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
        
        lblCamp.font = UIFont.BoldFont(16)
        lblCampNum.font = UIFont.BoldFont(16)
        lblMessage.font = UIFont.BoldFont(16)
        lblMessageNum.font = UIFont.BoldFont(16)
        lblCheckIn.font = UIFont.BoldFont(16)
        lblCalender.font = UIFont.BoldFont(16)
        lblCalenderNum.font = UIFont.BoldFont(16)
        lblHour.font = UIFont.BoldFont(16)
        lblHourNum.font = UIFont.BoldFont(16)
        lblEvent.font = UIFont.BoldFont(16)
        
        lblCamp.textColor = UIColor.textWhiteColor
        lblCampNum.textColor = UIColor.textWhiteColor
        lblMessage.textColor = UIColor.textWhiteColor
        lblMessageNum.textColor = UIColor.textWhiteColor
        lblCheckIn.textColor = UIColor.textWhiteColor
        lblCalender.textColor = UIColor.textWhiteColor
        lblCalenderNum.textColor = UIColor.textWhiteColor
        lblHour.textColor = UIColor.textWhiteColor
        lblHourNum.textColor = UIColor.textWhiteColor
        lblEvent.textColor = UIColor.textWhiteColor
        awardNumView.backgroundColor = UIColor.red
        awardNumView.layer.cornerRadius = awardNumView.frame.size.height/2
        awardNumView.isHidden = true;
        lblAward.isHidden = true;
//        campView.backgroundColor = UIColor.hexString(hex: "203152")
//        messageView.backgroundColor = UIColor.hexString(hex: "DE5D41")
//        checkInView.backgroundColor = UIColor.hexString(hex: "AC41DE")
//        calenderView.backgroundColor = UIColor.hexString(hex: "2DD0DA")
        
        lblName.textColor = UIColor.themeColorSecondry
        lblActiveDate.textColor = UIColor.colorGrey72
        lblTotalHours.textColor = UIColor.colorGrey72
        lblServiceYears.textColor = UIColor.colorGrey72
        
        lblName.font = UIFont.BoldFont(24)
        lblActiveDate.font = UIFont.BoldFont(12)
        lblTotalHours.font = UIFont.BoldFont(12)
        lblServiceYears.font = UIFont.BoldFont(12)
        
    }
    
    func setupContent(){
        
        let date = DateFormatManager.shared.formatDateStrToStr(date: UserDefaults.standard.userInfo?.sjavms_activedate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
        let hours = String(format: "%.2f", UserDefaults.standard.userInfo?.msnfp_totalengagementhours ?? 0)
        lblName.text = UserDefaults.standard.userInfo?.fullname ?? ""
        lblActiveDate.text = "Active Date: \(date)"
        lblServiceYears.text = "Year of Service: \(UserDefaults.standard.userInfo?.sjavms_yearsofservice ?? 0)"
        lblTotalHours.text = "Total Hours: \(hours)"
        
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
    
  
    
    @IBAction func currentEventTapped(_ sender: Any) {
        
        
    }
    
    @IBAction func messagTapped(_ sender: Any) {
        let vc = MessageVC(nibName: "MessageVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func checkInTapped(_ sender: Any) {
    }
    @IBAction func scheduleTapped(_ sender: Any) {
        
        let vc = ScheduleVC(nibName: "ScheduleVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    @IBAction func eventTapped(_ sender: Any) {
    }
    
    @IBAction func hoursTapped(_ sender: Any) {
        
        let vc = VolunteerHoursVC(nibName: "VolunteerHoursVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func getVolunteerAward(){
        
        guard let contactId = UserDefaults.standard.contactIdToken  else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_groupmembershipid,msnfp_groupmembershipname,_msnfp_groupid_value",
            ParameterKeys.expand : "msnfp_groupId",
            ParameterKeys.filter : "(statuscode eq 1 and _msnfp_contactid_value eq \(contactId)) and (msnfp_groupId/statecode eq 0)",
            ParameterKeys.orderby : "msnfp_groupmembershipname asc"
        ]
        
        self.getVolunteerAwardData(params: params)
    }
    
    fileprivate func getVolunteerAwardData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerAward(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let award = response.value {
                    self.awardData = award
        
                        self.lblAward.text = "\(award.count)"
                        self.awardNumView.isHidden = false
                        self.lblAward.isHidden = false
                    
                }else{
                    self.awardNumView.isHidden = true
                    self.lblAward.isHidden = true
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
