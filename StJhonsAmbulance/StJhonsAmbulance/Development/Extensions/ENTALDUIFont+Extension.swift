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
        let font = UIFont(name: "NunitoSans-Light", size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
        return font
    }
    
    class func RegularFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "NunitoSans-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    class func MediumFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "NunitoSans-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    class func SemiBoldFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "NunitoSans-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    class func BoldFont(_ size: CGFloat) -> UIFont {
        let font = UIFont(name: "NunitoSans-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
        return font
    }
    
    
    
    
    
    
    class func HeaderLightFont(_ size: CGFloat) -> UIFont {
        let font = UIFont(name: "Avenir-Light", size: size) ?? UIFont()
        return font
    }
    
    class func HeaderRegularFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Regular", size: size) ?? UIFont()
    }
    
    class func HeaderMediumFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Medium", size: size) ?? UIFont()
    }
    
    class func HeaderSemiBoldFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Medium", size: size) ?? UIFont()
    }
    
    class func HeaderBoldFont(_ size: CGFloat) -> UIFont {
        let font = UIFont(name: "Avenir-Heavy", size: size) ?? UIFont()
        return font
    }
    
}
