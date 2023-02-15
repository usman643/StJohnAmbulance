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
    
    
    @IBOutlet weak var menuSelectedsImg: UIImageView!
    @IBOutlet weak var lblTabTitle: UILabel!
    
    
    
    
    
    
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
                    DashBoardGridModel(title: "Messages", subTitle: "", bgColor: UIColor.orangeRedColor, icon: "ic_message"),
                    DashBoardGridModel(title: "Volunteer", subTitle: "", bgColor: UIColor.orangeColor, icon: "ic_communication"),
                    DashBoardGridModel(title: "Events", subTitle: "", bgColor: UIColor.darkFrozeColor, icon: "ic_event"),
                    DashBoardGridModel(title: "Pending Shifts", subTitle: "", bgColor: UIColor.lightBlueColor, icon: "ic_hour"),
                    DashBoardGridModel(title: "Pending Events", subTitle: "", bgColor: UIColor.themePrimaryColor, icon: "ic_pendingEvent")
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
        }else if(named == "Profile"){
            
            self.navigationController?.popToRootViewController(animated: true)
            ENTALDControllers.shared.showContactInfoScreen(type: .ENTALDPUSH, from: self, callBack: nil)
                        
        }else if(named == "Logout"){
            
            UserDefaults.standard.signOut()

        }else{
            
            dismiss(animated: true)
        }
    }

    func decorateUI(){
        self.btnMainView.backgroundColor = UIColor.themePrimaryColor
        self.btnMainView.layer.cornerRadius = 3
        lblLogoTitle.textColor = UIColor.themePrimaryColor
        lblTabTitle.textColor = UIColor.themePrimaryColor
        lblTabTitle.font = UIFont.BoldFont(14)
        
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
    
    
    @IBAction func openVolunteerScreen(_ sender: Any) {
        
        self.openNextScreecn(controller: 2)
    }
    
    @IBAction func openEventScreen(_ sender: Any) {
        self.openNextScreecn(controller: 3)
        
    }
    
    @IBAction func openPendingShiftsScreen(_ sender: Any) {
        self.openNextScreecn(controller: 4)
        
    }
    
    @IBAction func openMessagesScreen(_ sender: Any) {
        self.openNextScreecn(controller: 5)
        
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
                    
                        if (self.latestEvent?.count != 0){
                            let date = DateFormatManager.shared.formatDateStrToStr(date: self.latestEvent?[0].msnfp_startingdate ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "MMMM dd")
                            self.gridData?[0].title = self.latestEvent?[0].msnfp_engagementopportunitytitle ?? ""
                            self.gridData?[0].subTitle = date
                            
                            
                        }else{
                            self.gridData?[0].title =  ""
                            self.gridData?[0].subTitle = ""
                        }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
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
        
        let cell = collectionView.cellForItem(at: indexPath) as! CSDashBaordCVC
        
        UIView.transition(from: cell.mainView,
                          to: cell.mainView,
                          duration: 0.7,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews]) { status in
            if status {
                self.openNextScreecn(controller:indexPath.row)
            }
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
    
    func openNextScreecn(controller:Int?){
        if controller == 0 {
            if (self.latestEvent?[0] != nil){
                ENTALDControllers.shared.showEventManageScreen(type: .ENTALDPUSH, from: self, data: self.latestEvent?[0]) { params, controller in
                    self.openNextScreecn(controller: params as? Int)
                }
            }
        }else if controller == 1 {
            
            ENTALDControllers.shared.showMessageScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreecn(controller: params as? Int)
            }
        }else if controller == 2 {
            
            ENTALDControllers.shared.showVolunteersScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreecn(controller: params as? Int)
            }
        }else if controller == 3 {
            
            ENTALDControllers.shared.showEventScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreecn(controller: params as? Int)
            }
        }else if controller == 4 {
            
            ENTALDControllers.shared.showPendingShiftScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreecn(controller: params as? Int)
            }
        }else if controller == 5 {
            
            ENTALDControllers.shared.showPendingEventScreen(type: .ENTALDPUSH, from: self) { params, controller in
                self.openNextScreecn(controller: params as? Int)
            }
        }
    }
 
}
