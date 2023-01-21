//
//  ENTALDUIFont+Extension.swift
//  Aldar-Entertainer
//
//  Created by M.Usman on 11/05/2022.
//

import Foundation
import UIKit

extension UIFont {
    
    class func ENTALDLightFont(_ size: CGFloat) -> UIFont {
        let font = UIFont(name: "Montserrat-Light", size: size) ?? UIFont()
        return font
    }
    
    class func ENTALDRegularFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: size) ?? UIFont()
    }
    
    class func ENTALDMediumFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Medium", size: size) ?? UIFont()
    }
    
    class func ENTALDSemiBoldFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-SemiBold", size: size) ?? UIFont()
    }
    
    class func ENTALDBoldFont(_ size: CGFloat) -> UIFont {
        let font = UIFont(name: "Montserrat-Bold", size: size) ?? UIFont()
        return font
    }
    
    class func ENTALDBlackFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Black", size: size) ?? UIFont()
    }
    
}
