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
    
    @nonobjc class var appThemeColor: UIColor {
        return UIColor(named: "appTheme")!
    }
    @nonobjc class var appBlack: UIColor {
        return UIColor(named: "appBlack")!
    }
    @nonobjc class var appWhite: UIColor {
        return UIColor(named: "appWhite")!
    }
    @nonobjc class var borderGray: UIColor {
        return UIColor(named: "borderGray")!
    }
    @nonobjc class var appDarkGray102: UIColor {
        return UIColor(named: "appDarkGray102")!
    }
    @nonobjc class var appLightGray237: UIColor {
        return UIColor(named: "appLightGray237")!
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
