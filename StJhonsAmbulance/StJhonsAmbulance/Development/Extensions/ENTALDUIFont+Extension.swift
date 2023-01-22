//
//  ENTALDUIFont+Extension.swift
//  Aldar-Entertainer
//
//  Created by M.Usman on 11/05/2022.
//

import Foundation
import UIKit

extension UIFont {
    
    class func LightFont(_ size: CGFloat) -> UIFont {
        let font = UIFont(name: "Quicksand-Light", size: size) ?? UIFont()
        return font
    }
    
    class func RegularFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Quicksand-Regular", size: size) ?? UIFont()
    }
    
    class func MediumFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Quicksand-Medium", size: size) ?? UIFont()
    }
    
    class func SemiBoldFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Quicksand-SemiBold", size: size) ?? UIFont()
    }
    
    class func BoldFont(_ size: CGFloat) -> UIFont {
        let font = UIFont(name: "Quicksand-Bold", size: size) ?? UIFont()
        return font
    }
    
}
