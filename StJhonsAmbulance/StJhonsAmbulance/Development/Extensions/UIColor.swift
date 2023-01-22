//
//  UIColor.swift
//  WIT Edu
//
//  Created by Umair Yousaf on 14/08/2022.
//

import Foundation
import UIKit

extension UIColor {
    
    class var themeColor:UIColor{
        return hexStringToUIColor(hex:"006633")
    }
    
    class var themeDarkColor:UIColor{
        return hexStringToUIColor(hex:"024F29")
    }
    
    class var textBlackColor:UIColor{
        return hexStringToUIColor(hex:"181818")
    }
    
    class var viewLightColor:UIColor{
        return hexStringToUIColor(hex:"FDFDFD")
    }
    
    class var viewLightGrayColor:UIColor{
        return hexStringToUIColor(hex:"E5E5E5")
    }

    class func hexStringToUIColor (hex:String) -> UIColor {
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
