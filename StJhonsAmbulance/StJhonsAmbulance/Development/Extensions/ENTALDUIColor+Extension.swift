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
    
 
    //    <color name="colorThemeGreen2">#01733A</color>
    //    <color name="colorLightGreen">#EFFFF7</color>
    
    class var themeColorSecondry:UIColor{
        return hexString(hex:"006633")
    }
    
    class var themeColorLight:UIColor{
        return hexString(hex:"EFFFF7")
    }
    
    class var themePrimaryColor:UIColor{
        return hexString(hex:"024F29")
    }
    
    class var colorGreen01733A:UIColor{
        return hexString(hex:"01733A")
    }
    
    class var menuBarColor:UIColor{
        return hexString(hex:"E2EAE6")
    }
    
    class var textWhiteColor:UIColor{
        return hexString(hex:"FFFFFF")
    }
    
    class var offWhiteColor:UIColor{
        return hexString(hex:"F6F4F4")
    }
    
    class var textBlackColor:UIColor{
        return hexString(hex:"000000")
    }
    
    class var viewLightColor:UIColor{
        return hexString(hex:"FDFDFD")
    }
    
    class var textGrayColor:UIColor{
        return hexString(hex:"707070")
    }
    
    class var textLightGrayColor:UIColor{
        return hexString(hex:"ADADAD")
    }
    
    class var viewLightGrayColor:UIColor{
        return hexString(hex:"E5E5E5")
    }
    
    class var colorGreyF6F4F4:UIColor{
        return hexString(hex:"F6F4F4")
    }

    class var colorGreyC6:UIColor{
        return hexString(hex:"C6C6C6")
    }
    class var colorGrey72:UIColor{
        return hexString(hex:"727272")
    }
    
    class var darkBlueColor:UIColor{
        return hexString(hex:"203152")
    }
    
    class var lightBlueColor:UIColor{
        return hexString(hex:"4151DE")
    }
    
    class var orangeColor:UIColor{
        return hexString(hex:"DE8341")
    }
    
    class var darkFrozeColor:UIColor{
        return hexString(hex:"009DAE")
    }
    
    class var lightFrozeColor:UIColor{
        return hexString(hex:"2DD0DA")
    }
    
    class var purpelColor:UIColor{
        return hexString(hex:"AC41DE")
    }
    
    class var orangeRedColor:UIColor{
        return hexString(hex:"DE5D41")
    }
    
    class var redPinkColor:UIColor{
        return hexString(hex:"ED386A")
    }
    
    class var themeBlackColor:UIColor{
        return hexString(hex:"151515")
    }
    
    class var iconColor:UIColor{
        return hexString(hex:"CFCFCF")
    }
    
    class var unselectedTabColor:UIColor{
        return hexString(hex:"6E6E6E")
    }
    
    class var selectedTabColor:UIColor{
        return hexString(hex:"2D3934")
    }
    
    class var navBarGrayColor:UIColor{
        return hexString(hex:"F0F0F0")
    }
    
    class var navBarLabelColor:UIColor{
        return hexString(hex:"646464")
    }
    
    class var themeLightGrayColor:UIColor{
        return hexString(hex:"F2F2F2")
    }
    
    class var hourGreenColor:UIColor{
        return hexString(hex:"1B6544")
    }
    
    class var pageTitleColor:UIColor{
        return hexString(hex:"234135")
    }
    
    class var SJAGreenColor:UIColor{
        return hexString(hex:"18573A")
    }
    
    class var headerTitleColor:UIColor{
        return hexString(hex:"18573A")
    }
    
    
    

    @nonobjc class var headerGreen: UIColor {
        return UIColor(named: "headerGreen")!
    }
    
    @nonobjc class var themePrimary: UIColor {
        return UIColor(named: "themePrimary")!
    }
    @nonobjc class var themeBlackText: UIColor {
        return UIColor(named: "themeBlackText")!
    }
    @nonobjc class var themeWhiteText: UIColor {
        return UIColor(named: "themeWhiteText")!
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
    @nonobjc class var themePrimaryWhite: UIColor {
        return UIColor(named: "themePrimaryWhite")!
    }
    @nonobjc class var themeSecondryWhite: UIColor {
        return UIColor(named: "themeSecondryWhite")!
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


//SJA green: #18573A

