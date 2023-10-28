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
    
    func parse<D>(to type: D.Type) -> D? where D: Decodable {
        
        let data: Data = self.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        do {
            let _object = try decoder.decode(type, from: data)
            return _object
            
        } catch {
            return nil
        }
    }
    
    
    var digits: String {
            return components(separatedBy: CharacterSet.decimalDigits.inverted)
                .joined()
        }
    
    
}

extension Float {
    
    public func getFormattedNumber() -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        let formatedString = formatter.string(from: self as NSNumber)!
        return formatedString
        
    }
}


extension UILabel {
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: self.font], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}
