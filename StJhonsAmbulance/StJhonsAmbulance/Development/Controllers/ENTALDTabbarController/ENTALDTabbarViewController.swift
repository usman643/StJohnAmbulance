//
//  ENTALDTabbarViewController.swift
//  Aldar-Entertainer
//
//  Created by M.Usman on 13/05/2022.
//

import UIKit
import IQKeyboardManagerSwift

class ENTALDTabbarViewController: UITabBarController {
    
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()

    var callbackToController : ControllerCallBackCompletion?
    var screenBaseModel: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.tabBar.tintColor = .themePrimaryColor
        self.tabBar.barTintColor = .themeWhiteText
        UITabBar.appearance().barTintColor = .white
//        UITabBar.appearance().selectionIndicatorImage = Bundle.loadImageFromResourceAFBundlePNG(imageName: "tab_bg")
//        self.navigationController?.navigationBar.isHidden = true
        self.setupTabbarshadow()
        
        self.loadTabbarControllers()
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true;
        // Do any additional setup after loading the view.
    }
    
    func setupTabbarshadow(){
        tabBar.layer.shadowColor = UIColor.gray.cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 5
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = false
        self.tabBar.clipsToBounds = false
        self.tabBar.backgroundColor = UIColor.hexString(hex: "F0F0F0")
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -8)
        
    }
    
    override func viewDidLayoutSubviews() {
        let newTabBarHeight = defaultTabBarHeight + 20
        ProcessUtils.shared.tabbarHeight = newTabBarHeight
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        
        tabBar.frame = newFrame
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let items = self.tabBar.items {
            for item in items {
                item.imageInsets = UIEdgeInsets(top: -15, left: 0, bottom: -15, right: 0)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        rootViewController.tabBarItem.title = title
        rootViewController.tabBarItem.image = image
        rootViewController.tabBarItem.selectedImage = image
        rootViewController.navigationItem.title = title
        let navController = ENTALDBaseNavigationController(rootViewController: rootViewController)
        
        return navController
    }
    
    private func loadTabbarControllers(){
        
        let homeVC = DashboardVC.loadFromNib()
        let homeImg = "tabHome".templatedImage
        let homeImgUnselected = "tabHomeUnselected".templatedImage
        
        let eventVC = VolunteerEventsVC.loadFromNib()
        let eventImg = "ai-navigation-spark".templatedImage
        
//        let checkinVC = MapViewController.loadFromNib()
//        let checkinImg = "tabLocation".templatedImage
        
        let hourVC = VolunteerEventVC.loadFromNib()
        let hourImg = "hourglass-alternate".templatedImage
        
        let scheduleVC = ScheduleVC.loadFromNib()
        let scheduleImg = "tabCalender".templatedImage
//
//        let messageVC = InAppMsgVC.loadFromNib()
//        let messageImg = "tabMessage".templatedImage
       
        viewControllers = [
            self.createNavController(for: homeVC, title: "Home".localized, image: homeImg),
            self.createNavController(for: eventVC, title: "Events".localized, image: eventImg),
            self.createNavController(for: hourVC, title: "Hours".localized, image: hourImg),
            self.createNavController(for: scheduleVC, title: "Schedule".localized, image: scheduleImg),
            
           
//            self.createNavController(for: messageVC, title: "", image: messageImg)
        ]
    }
    
    
    override var selectedIndex: Int { // Mark 1
        didSet {
            guard let selectedViewController = viewControllers?[selectedIndex] else {
                return
            }
            selectedViewController.tabBarItem.setTitleTextAttributes([.font: UIFont.HeavyFont(9)], for: .normal)
        }
    }
    
    override var selectedViewController: UIViewController? { // Mark 2
        didSet {
            
            guard let viewControllers = viewControllers else {
                return
            }
            
            for viewController in viewControllers {
                if viewController == selectedViewController {
                    viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.HeavyFont(9)], for: .normal)
                } else {
                    viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.HeavyFont(9)], for: .normal)
                }
            }
        }
    }
}
