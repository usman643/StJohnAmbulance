//
//  ENTALDBaseNavigationController.swift
//  ENTALDO
//
//  Created by M.Usman on 23/04/2022.
//

import UIKit

class ENTALDBaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    var navigationBarTintColor: UIColor = .blue {
        didSet {
            navigationBar.barTintColor = navigationBarTintColor
        }
    }
    var navigationTintColor: UIColor = .blue {
        didSet {
            navigationBar.tintColor = navigationTintColor
        }
    }
    
    var navigationBarTitleColor: UIColor = .white {
        didSet {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : navigationBarTitleColor]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}
