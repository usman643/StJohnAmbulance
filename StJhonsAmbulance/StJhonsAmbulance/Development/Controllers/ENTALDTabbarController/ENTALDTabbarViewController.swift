//
//  ENTALDTabbarViewController.swift
//  Aldar-Entertainer
//
//  Created by M.Usman on 13/05/2022.
//

import UIKit

class ENTALDTabbarViewController: UITabBarController {
    
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()

    var callbackToController : ControllerCallBackCompletion?
    var screenBaseModel: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.tabBar.tintColor = .themePrimary
        self.tabBar.barTintColor = .white
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().selectionIndicatorImage = Bundle.loadImageFromResourceAFBundlePNG(imageName: "tab_bg")

        self.setupTabbarshadow()
        
        self.loadTabbarControllers()

        // Do any additional setup after loading the view.
    }
    
    func setupTabbarshadow(){
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 5
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = false
        self.tabBar.backgroundColor = UIColor.white
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -8)
        
    }
    
    override func viewDidLayoutSubviews() {
        let newTabBarHeight = defaultTabBarHeight + 20
        
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
    
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = ENTALDBaseNavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = image
        rootViewController.navigationItem.title = title
        return navController
    }
    
    private func loadTabbarControllers(){
        
        let homeVC = ENTALDHomeViewController.loadFromNib()
        
        let homeImg = "hometab".templatedImage
        
        let offersVC = ENTALDOffersViewController.loadFromNib()
        
        let offersImg = "offerstab".templatedImage
        
        viewControllers = [
            self.createNavController(for: homeVC, title: "Home", image: homeImg),
            self.createNavController(for: offersVC, title: "Offer", image: offersImg)
        ]
    }
    
    
    override var selectedIndex: Int { // Mark 1
        didSet {
            guard let selectedViewController = viewControllers?[selectedIndex] else {
                return
            }
            selectedViewController.tabBarItem.setTitleTextAttributes([.font: UIFont.ENTALDBoldFont(12)], for: .normal)
        }
    }
    
    override var selectedViewController: UIViewController? { // Mark 2
        didSet {
            
            guard let viewControllers = viewControllers else {
                return
            }
            
            for viewController in viewControllers {
                if viewController == selectedViewController {
                    viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.ENTALDBoldFont(12)], for: .normal)
                } else {
                    viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.ENTALDRegularFont(12)], for: .normal)
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
