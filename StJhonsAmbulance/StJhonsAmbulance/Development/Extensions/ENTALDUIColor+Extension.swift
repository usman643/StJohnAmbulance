//
//  ENTALDUIColor+Extension.swift
//  Aldar-Entertainer
//
//  Created by M.Usman on 13/05/2022.
//

import Foundation
import UIKit

extension UIColor {
    
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum < 0.50
    }
    
    class var themeColor:UIColor{
        return hexString(hex:"006633")
    }
    
    class var themeDarkColor:UIColor{
        return hexString(hex:"024F29")
    }
    
    class var textGrayColor:UIColor{
        return hexString(hex:"707070")
    }
    
    class var textLightGrayColor:UIColor{
        return hexString(hex:"ADADAD")
    }
    
    class var textWhiteColor:UIColor{
        return hexString(hex:"FFFFFF")
    }
    
    class var textBlackColor:UIColor{
        return hexString(hex:"000000")
    }
    
    class var viewLightColor:UIColor{
        return hexString(hex:"FDFDFD")
    }
    
    class var viewLightGrayColor:UIColor{
        return hexString(hex:"E5E5E5")
    }
    
    @nonobjc class var themePrimary: UIColor {
        return UIColor(named: "themePrimary")!
    }
    @nonobjc class var themeSecondry: UIColor {
        return UIColor(named: "themeSecondry")!
    }
    @nonobjc class var themeternary: UIColor {
        return UIColor(named: "themeternary")!
    }
    @nonobjc class var themeLight: UIColor {
        return UIColor(named: "themeLight")!
    }
    
    class func hexString(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
