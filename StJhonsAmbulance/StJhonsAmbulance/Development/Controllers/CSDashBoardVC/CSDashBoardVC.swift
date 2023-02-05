//
//  CSDashBoardVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 24/01/2023.
//

import UIKit
import SideMenu


class CSDashBoardVC: ENTALDBaseViewController,MenuControllerDelegate {
 
    var sideMenu: SideMenuVC?
    var menu: SideMenuNavigationController?
    var gridData : [DashBoardGridModel]?
    var latestEvent : [CurrentEventsModel]?
    
    @IBOutlet weak var btnSideMenu: UIButton!
    @IBOutlet weak var lblGroupName: UILabel!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var btnMainView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnGroup: UIButton!
    @IBOutlet weak var lblLogoTitle: UILabel!
    
    @IBOutlet weak var btnGroupSelectView: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
       
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        collectionView.register(UINib(nibName: "CSDashBaordCVC", bundle: nil), forCellWithReuseIdentifier: "CSDashBaordCVC")
        decorateUI()
        setSideMenu()
        
        gridData = [
                    DashBoardGridModel(title: "", subTitle: "", bgColor: UIColor.darkBlueColor, icon: "ic_camp"),
                    DashBoardGridModel(title: "Messages", subTitle: "02", bgColor: UIColor.orangeRedColor, icon: "ic_message"),
                    DashBoardGridModel(title: "Volunteer", subTitle: "02", bgColor: UIColor.orangeColor, icon: "ic_communication"),
                    DashBoardGridModel(title: "Events", subTitle: "02", bgColor: UIColor.darkFrozeColor, icon: "ic_event"),
                    DashBoardGridModel(title: "Pending Shifts", subTitle: "02", bgColor: UIColor.lightBlueColor, icon: "ic_hour"),
                    DashBoardGridModel(title: "Pending Events", subTitle: "06", bgColor: UIColor.themePrimaryColor, icon: "ic_pendingEvent")
                ]
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        btnGroup.setTitle(ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupName() ?? "", for: .normal)
        if ( self.latestEvent?.count == 0 || ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() != self.latestEvent?[0].msnfp_engagementopportunityid){
            getLatestUpcomingEvent()
        }
        
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
    
    func didSelectMenuItem(named: String) {
        
        if (named == "Home") {
            dismiss(animated: true)
//            let vc = HomeVC(nibName: "HomeVC", bundle: nil)
//            self.navigationController?.pushViewController(vc , animated: true)
        }else if(named == "Logout"){
            
            UserDefaults.standard.signOut()
//            self.navigationController?.popToRootViewController(animated: true)
//            let loginvc = LoginVC(nibName: "LoginVC", bundle: nil)
//            self.navigationController?.pushViewController(loginvc, animated: true)
            
        }else{
            
            dismiss(animated: true)
        }
    }

    func decorateUI(){
        self.btnMainView.backgroundColor = UIColor.themePrimaryColor
        self.btnMainView.layer.cornerRadius = 3
        lblLogoTitle.textColor = UIColor.themePrimaryColor
        
        btnGroupSelectView.layer.cornerRadius = 3
        btnGroup.setTitleColor(UIColor.white, for: .normal)
        btnGroup.titleLabel?.font = UIFont.BoldFont(14)
        btnGroup.backgroundColor = UIColor.themePrimary
        
        lblGroupName.font = UIFont.BoldFont(16)
        lblGroupName.textColor = UIColor.themeBlackText
        self.view.backgroundColor = UIColor.themeWhiteText
        self.collectionView.backgroundColor = UIColor.themeWhiteText
    }

    @IBAction func selectGroupTapped(_ sender: Any) {
        showGroupsPicker()
    }
    @IBAction func sideMenuTapped(_ sender: Any) {
        present(menu!, animated: true)
    }
    
    func getLatestUpcomingEvent(){
        guard let groupId = ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() else {return}
        guard let currentDate = DateFormatManager.shared.getCurrentDateWithFormat(format: "yyyy-MM-dd") else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_engagementopportunitystatus,msnfp_minimum,msnfp_maximum,msnfp_endingdate,msnfp_startingdate,msnfp_engagementopportunityid,_sjavms_contact_value,_sjavms_program_value",
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(msnfp_groupid eq \(groupId)))",
            ParameterKeys.filter : "(statecode eq 0 and Microsoft.Dynamics.CRM.OnOrAfter(PropertyName='msnfp_endingdate',PropertyValue='\(currentDate)') and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_engagementopportunitystatus',PropertyValues=['844060003','844060002'])) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/msnfp_groupid eq \(groupId))))",
            ParameterKeys.orderby : "msnfp_startingdate asc,msnfp_engagementopportunitytitle asc",
            ParameterKeys.top : "1"
            
        ]
        
        self.getLatestUpcomingEventData(params: params)
    }
    
    fileprivate func getLatestUpcomingEventData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestLatestUpcomingEvent(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let eventData = response.value {
                    self.latestEvent = eventData
                    DispatchQueue.main.async {
                        if (self.latestEvent?.count != 0){
                            let date = DateFormatManager.shared.formatDateStrToStr(date: self.latestEvent?[0].msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "MMMM dd")
                            self.gridData?[0].title = self.latestEvent?[0].msnfp_engagementopportunitytitle ?? ""
                            self.gridData?[0].subTitle = date
                            
                            self.collectionView.reloadData()
                        }else{
                            self.gridData?[0].title =  ""
                            self.gridData?[0].subTitle = ""
                        }
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

extension CSDashBoardVC : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CSDashBaordCVC", for: indexPath) as! CSDashBaordCVC
        cell.lblTitle.text = gridData?[indexPath.item].title
        cell.lblCount.text = gridData?[indexPath.item].subTitle
        cell.imgView.image = UIImage(named: gridData?[indexPath.item].icon ?? "")
        cell.mainView.backgroundColor = gridData?[indexPath.item].bgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         let cellWidth = (UIScreen.main.bounds.size.width - 6)/2

        let height = (self.collectionView.frame.size.height - 4 - 22) / 3
        
        return CGSizeMake(cellWidth, height )
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if indexPath.row == 0 {
            let vc = EventManageVC.loadFromNib()
            self.navigationController?.pushViewController(vc, animated: true)
        }else
        if indexPath.row == 1 {
            let vc = MessageVC.loadFromNib()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2 {
            let vc = VounteerVC.loadFromNib()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 3 {
            let vc = EventVC.loadFromNib()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 4 {
            let vc = PendingShiftVC.loadFromNib()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 5 {
            let vc = PendingEventVC.loadFromNib()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showGroupsPicker(list:[LandingGroupsModel] = []){
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, dataObj: ProcessUtils.shared.userGroupsList) { params, controller in
            
            if let data = params as? LandingGroupsModel {
                ProcessUtils.shared.selectedUserGroup = data
                self.getLatestUpcomingEvent()
                self.btnGroup.setTitle("\(data.msnfp_groupId?.getGroupName() ?? "")", for: .normal)
                
            }
        }
    }
    
    
    
}

//
//    <color name="teal_200">#FF03DAC5</color>
//    <color name="teal_700">#FF018786</color>
//
//
//    <color name="colorLightRed">#E2364B</color>
//    <color name="colorRed">#D9011A</color>
//    <color name="colorScheduleEr">#DA542D</color>
//    <color name="colorScheduleErBackground">#FDDDD4</color>
//    <color name="colorScheduleNormal">#188A5C</color>
//    <color name="colorScheduleNormalBackground">#CEFEEB</color>
//
//
//
//    <color name="colorBlack">#000000</color>
//    <color name="colorThemeBlack">#000000</color>
//    <color name="colorThemeBlack1">#151515</color>

//    <color name="colorTransparent">#80000000</color>
