//
//  ENTALDString+Extension.swift
//  Aldar-Entertainer
//
//  Created by M.Usman on 11/05/2022.
//

import Foundation
import UIKit

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: "ENTALDLocalizable", bundle: Bundle.getAldarBundle(), value: "", comment: "")
    }
    
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var templatedImage: UIImage {
        return UIImage(named: self)?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    var originalImage: UIImage {
        return UIImage(named: self)?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    }
    
    func flippedImage(doKeepOriginal: Bool = true) -> UIImage {
        let image = (doKeepOriginal ? originalImage : templatedImage)
        return image
    }
    
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
    
    func getStringContentSize(with font:UIFont)->CGSize{
        return self.size(withAttributes: [NSAttributedString.Key.font: font])

    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
}
