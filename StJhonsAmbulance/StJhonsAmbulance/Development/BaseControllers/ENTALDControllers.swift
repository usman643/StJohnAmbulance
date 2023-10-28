//
//  ENTALDControllers.swift
//  ENTALDO
//
//  Created by M.Usman on 23/04/2022.
//

import Foundation
import UIKit

enum ENTALDControllerType {
    case ENTALDPUSH
    case ENTALDPRESENT
    case ENTALDPUSH_WO_ANIM
    case ENTALDPRESENT_WO_ANIM
    case ENTALDTABBARVC
    case ENTALDMODAL_PRESENT
    case ENTALDPRESENT_OVER_CONTEXT
    case ENTALDPRESENT_POPOVER
}

class ENTALDControllers {
    static let shared : ENTALDControllers = ENTALDControllers()
    
    private init(){
        
    }
    
    func setupHomeViewController(from:UIViewController?, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?){
        self.startFlowFromSplash(from: from, dataObj, callBack: callBack)
    }
    
    func startFlowFromSplash(from:UIViewController?, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?){
//        if (UserDefaults.standard.contactIdToken != nil){
//            let difference = Date().timeIntervalSince(UserDefaults.standard.object(forKey: "tokenTime") as? Date ?? Date())
//            if difference > 20 {
//                UserDefaults.standard.authToken = nil
//                UserDefaults.standard.userInfo = nil
//                ProcessUtils.shared.refreshToken()
//            }
//        }
        if ENTALDHelperUtils.isUserLoggedIn() && UserDefaults.standard.staySignedIn {
            
            self.startFlowfromLandingScreen(from: from, callBack: callBack)
            
        }else{
            self.showLoginScreen(type: .ENTALDPUSH, from: UIApplication.getTopViewController()) { params, controller in
                
                if ENTALDHelperUtils.isUserLoggedIn() {
                    self.startFlowfromLandingScreen(from: from, callBack: callBack)
                }
            }
        }
    }
    
    func startFlowfromLandingScreen(from:UIViewController?, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?){
        
        ProcessUtils.shared.refreshToken { status in
            if status {
                DispatchQueue.main.async{
                    
                    self.showTabbarViewController(type: .ENTALDPUSH, from: from) { params, controller in
                        
                    }
                }
            }
        }
    }
    
    
    
    func showLoginScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = LoginVC.loadFromNib()
        vc.callbackToController = callBack
        let nav = ENTALDBaseNavigationController(rootViewController: vc)
        
        if let window = sceneDelegate?.window{
            window.rootViewController = nav
            window.makeKeyAndVisible()
            window.windowLevel = .normal
        }
    }
    
    func showSelectionPicker(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, pickerType:STPikerType, dataObj:Any? = nil, callBack:ControllerCallBackCompletion?){
        let vc = PickerViewController.loadFromNib()
        vc.pickerType = pickerType
        vc.dataModel = dataObj
        vc.callbackToController = callBack
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showPendingShiftStatusUpdatePicker(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, callBack:ControllerCallBackCompletion?){
        let vc = PendingStatusPickerView.loadFromNib()
        vc.dataModel = dataObj
        vc.callbackToController = callBack
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showCreateEventForm(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, callBack:ControllerCallBackCompletion?){
        let vc = CreateEventFormVC.loadFromNib()
        vc.dataModel = dataObj
        vc.callbackToController = callBack
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showEventSummaryScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, callBack:ControllerCallBackCompletion?){
        let vc = EventSummaryVC.loadFromNib()
        vc.dataModel = dataObj
        vc.callbackToController = callBack
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showLandingScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = LandingVC.loadFromNib()
        vc.callbackToController = callBack
        let nav = ENTALDBaseNavigationController(rootViewController: vc)
        
        if let window = sceneDelegate?.window{
            window.rootViewController = nav
            window.makeKeyAndVisible()
            window.windowLevel = .normal
        }
    }
    
    func showTabbarViewController(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?){
        
        let tabbar = ENTALDTabbarViewController()
        tabbar.callbackToController = callBack
        
        let nav = ENTALDBaseNavigationController(rootViewController: tabbar)
        
        if let window = sceneDelegate?.window{
            window.rootViewController = nav
            window.makeKeyAndVisible()
            window.windowLevel = .normal
        }
    }
    
    func showCSTabbarViewController(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?){
        
        let tabbar = CSLeadTabbarVC()
        tabbar.callbackToController = callBack
        
        let nav = ENTALDBaseNavigationController(rootViewController: tabbar)
        
//        let rootVC = UIApplication.shared.windows.first?.rootViewController as? UITabBarController
//        let navigationController = rootVC?.children[0] as? UINavigationController
//        rootVC?.selectedIndex = 0
        
        if let window = sceneDelegate?.window{
            window.rootViewController = tabbar
//            window.rootViewController?.navigationController = navigationController
            window.makeKeyAndVisible()
            window.windowLevel = .normal
        }
        
    }
    
    func showCSDashBoardScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        
        
//        self.showCSTabbarViewController(type: .ENTALDTABBARVC, from: UIApplication.getTopViewController()) { params, controller in
//
//        }
        let vc = CSDashBoardVC.loadFromNib()
        vc.callbackToController = callBack
        let nav = ENTALDBaseNavigationController(rootViewController: vc)

//        if let window = sceneDelegate?.window{
//            window.rootViewController = nav
//            window.makeKeyAndVisible()
//            window.windowLevel = .normal
//        }
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    
    func showVolunteerDashBoardScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = DashboardVC.loadFromNib()
        vc.callbackToController = callBack
        let nav = ENTALDBaseNavigationController(rootViewController: vc)
        
        if let window = sceneDelegate?.window{
            window.rootViewController = nav
            window.makeKeyAndVisible()
            window.windowLevel = .normal
        }
    }
    
    func showMessageScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false,  dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = MessageVC.loadFromNib()
        vc.dataModel = dataObj
        vc.callbackToController = callBack
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showVolunteerScheduleScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = ScheduleVC.loadFromNib()
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showVolunteerHourScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = VolunteerEventVC.loadFromNib()
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showVolunteerEventScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = VolunteerEventsVC.loadFromNib()
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showVolunteersScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = VounteerVC.loadFromNib()
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showEventScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = CSEventVC.loadFromNib()
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showPendingShiftScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = PendingShiftVC.loadFromNib()
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showPendingEventScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = PendingEventVC.loadFromNib()
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showEventManageScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, data:Any?, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = VolunteerDayEventVC.loadFromNib()
        vc.eventData = data as? CurrentEventsModel
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showEventDetailScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, data:Any?, eventName:String?, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = EventDetailVC.loadFromNib()
        
        if (eventName == "availableEvent"){
            vc.availableEvent = data as? CurrentEventsModel
        }else if (eventName == "scheduleEvent"){
            vc.scheduleEvent = data as? ScheduleModelThree
        }else if (eventName == "pastEvent"){
            vc.pastEvent = data as? CurrentEventsModel
        }else if (eventName == "latestEvent"){
            vc.latestEvent = data as? LatestEventDataModel
        }else if (eventName == "dashboardEvent"){
            vc.dashbaordEvent = data as?  AvailableEventModel
        }
        
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showForgetPasswordScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = ForgetVC.loadFromNib()
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
       
    func showContactInfoScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = ContactInfoVC.loadFromNib()
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showSideMenuAvailabilityScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = AvailabilityVC.loadFromNib()
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showSideMenuQualificationScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = QualificationCertificationVC.loadFromNib()
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showSideMenuSkillsScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = SkillsVC.loadFromNib()
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showLanguageScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = LanguageVC.loadFromNib()
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showChangePasswordScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = ChangePasswordVC.loadFromNib()
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showSettingScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = SettingVC.loadFromNib()
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showRegisterScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = WebViewVC.loadFromNib()
        vc.callbackToController = callBack
        vc.urlType = "register"
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showForgetScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = WebViewVC.loadFromNib()
        vc.callbackToController = callBack
        vc.urlType = "forgot"
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showUpdatePasswordScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = WebViewVC.loadFromNib()
        vc.callbackToController = callBack
        vc.urlType = "updatepass"
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showDocument(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ documentUrl:String, _ documentToken:String, callBack:ControllerCallBackCompletion?) {
        let vc = WebViewVC.loadFromNib()
        vc.callbackToController = callBack
        vc.urlType = "document"
        vc.documentURL = documentUrl
        vc.documentToken = documentToken
        self.showViewController(navRoot: isNavigationController, type: .ENTALDPUSH, destination: vc, from: from)
    }
    
    func showVolunteerDetailScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, dayEvent:Bool = false, callBack:ControllerCallBackCompletion?) {
        let vc = VolunteerDetailVC.loadFromNib()
        vc.callbackToController = callBack
        vc.dataModel = dataObj
        vc.isFromDayEventScreen = dayEvent
        vc.isFromVolunteerScreen = true
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showVolunteerMap(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = MapViewController.loadFromNib()
        vc.dataModel = dataObj
        vc.callbackToController = callBack
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showMessageDetailScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = MessagedetailAlertVC.loadFromNib()
        vc.callbackToController = callBack
        vc.dataModel = dataObj
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showSendMessageScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, _ dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = MessageDetailVC.loadFromNib()
        vc.callbackToController = callBack
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showAchivementScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, engagementType : EngagementType = .Engagement , callBack:ControllerCallBackCompletion?) {
        let vc = AchivementVC.loadFromNib()
        vc.dataModel = dataObj
        vc.engagementType = engagementType
        vc.callbackToController = callBack
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showAwardScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, engagementType : EngagementType = .Engagement , callBack:ControllerCallBackCompletion?) {
        let vc = AwardsVC.loadFromNib()
        vc.dataModel = dataObj
        vc.engagementType = engagementType
        vc.callbackToController = callBack
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showVolunteerEventDetailScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil,eventType : String, callBack:ControllerCallBackCompletion?) {
        let vc = VolunteerEventDetailVC.loadFromNib()
        vc.eventType = eventType
        vc.dataModel = dataObj
        
        vc.callbackToController = callBack
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showAddAvilabilityScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, action : String, callBack:ControllerCallBackCompletion?) {
        let vc = AddAvilabilityVC.loadFromNib()
        vc.action = action
        vc.dataModel = dataObj
        
        vc.callbackToController = callBack
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showVolunteerHourDetailScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = VolunteerHourDetailVC.loadFromNib()
        
        vc.dataModel = dataObj
        
        vc.callbackToController = callBack
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showAddAdhocHourScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = CreateAdhocHourVC.loadFromNib()
        
        vc.dataModel = dataObj
        
        vc.callbackToController = callBack
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }

    func showContactDocumentScreen(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = ContractDocumentVC.loadFromNib()
        
        vc.dataModel = dataObj
        
        vc.callbackToController = callBack
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func ShowAddEventScheduleShiftVC(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = AddEventScheduleShiftVC.loadFromNib()
        vc.dataModel = dataObj
        vc.callbackToController = callBack
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
        
    func ShowUserEngagementsVC(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = UserEngagementsVC.loadFromNib()
        vc.dataModel = dataObj
        vc.callbackToController = callBack
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    
        
    func showCalenderHourVC(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, selectedDate:Date, dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = CalenderHourVC.loadFromNib()
        vc.dataModel = dataObj
        vc.callbackToController = callBack
        vc.selectDate = selectedDate
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    func showSignalRVC(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, eventId:String, dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = SignalRVC.loadFromNib()
        vc.dataModel = dataObj
        vc.callbackToController = callBack
        vc.eventId = eventId
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
      
    func showGroupMessageVC(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = InAppMsgVC.loadFromNib()
        vc.dataModel = dataObj
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    
      
    func showCSLeadEventVC(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = CSManageEventsVC.loadFromNib()
        vc.dataModel = dataObj
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
        
      
    func showVolunteerMessagesVC(type: ENTALDControllerType, from:UIViewController?, isNavigationController:Bool = false, dataObj:Any? = nil, callBack:ControllerCallBackCompletion?) {
        let vc = VolunteerMessageVC.loadFromNib()
        vc.dataModel = dataObj
        vc.callbackToController = callBack
        
        self.showViewController(navRoot: isNavigationController, type: type, destination: vc, from: from)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    private func showViewController(navRoot: Bool, type: ENTALDControllerType, destination: ENTALDBaseViewController, from: UIViewController? = nil, isDisplayonTop:Bool = false, completion: (() -> ())? = nil) {
    
        let isAnimation = type == .ENTALDPRESENT || type == .ENTALDPUSH
        
        if navRoot {
            let navController : ENTALDBaseNavigationController = ENTALDBaseNavigationController(rootViewController: destination)
            
            if destination.definesPresentationContext == true && destination.providesPresentationContextTransitionStyle == true {
                navController.modalPresentationStyle = .overCurrentContext
            }
            
            if type == .ENTALDPUSH || type == .ENTALDPUSH_WO_ANIM {
                from?.navigationController?.pushViewController(destination, animated: isAnimation)
            } else if type == .ENTALDPRESENT || type == .ENTALDPRESENT_WO_ANIM {
                if isDisplayonTop {
                    UIApplication.getTopViewController()?.present(navController, animated: isAnimation, completion: nil)
                }else{
                    navController.modalPresentationStyle = .fullScreen
                    from?.present(navController, animated: isAnimation, completion: completion)
                }
            }else if type == .ENTALDPRESENT_OVER_CONTEXT {
                navController.modalPresentationStyle = .overCurrentContext
                from?.present(navController, animated: isAnimation, completion: completion)
            }
        } else {
            destination.modalPresentationStyle = .fullScreen
            if type == .ENTALDPUSH || type == .ENTALDPUSH_WO_ANIM {
                from?.navigationController?.pushViewController(destination, animated: isAnimation)
            }else if type == .ENTALDPRESENT || type == .ENTALDPRESENT_WO_ANIM {
                if isDisplayonTop {
                    UIApplication.getTopViewController()?.present(destination, animated: isAnimation, completion: nil)
                }else{
                    from?.present(destination, animated: isAnimation, completion: completion)
                }
            }else if type == .ENTALDMODAL_PRESENT {
//                [controller presentPanModal:actionController];
            }else if type == .ENTALDPRESENT_OVER_CONTEXT {
                destination.modalPresentationStyle = .overCurrentContext
                from?.present(destination, animated: isAnimation, completion: completion)
            }else if type == .ENTALDPRESENT_POPOVER {
                destination.modalPresentationStyle = .popover
                from?.present(destination, animated: isAnimation, completion: completion)
            }
        }
    }
    
}
