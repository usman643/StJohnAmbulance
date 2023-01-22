//
//  NSString.swift
//  WIT Edu
//
//  Created by Umair Yousaf on 21/08/2022.
//

import Foundation
import UIKit

extension String {
    public func getViewController() -> UIViewController? {
        if let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            if let viewControllerType = Bundle.main.classNamed("\(appName).\(self)") as? UIViewController.Type {
                return viewControllerType.init()
            }
        }
        return nil
    }
}
