//
//  HelperUtils.swift
//  ENTALDO
//
//  Created by M.Usman on 26/04/2022.
//

import Foundation
import UIKit

class ENTALDHelperUtils {
    
    class func loadJson(fileName : String) -> [String:Any]? {
        if let filePath = Bundle.main.path(forResource: fileName, ofType: "json"), let data = NSData(contentsOfFile: filePath) {
            do {
                return try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any]
            }
            catch {
                //Handle error
            }
        }
        
        return nil
    }
    
    class func loadJsonFile(fileName : String) -> ENTALDAPICommonModel? {
        if let filePath = Bundle.main.path(forResource: fileName, ofType: "json"){
            do {
                let decoder = JSONDecoder()
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
                let model = try decoder.decode(ENTALDAPICommonModel.self, from: data)
                return model
            }catch(let error){
                print("Json File \(fileName) not loaded beacuse of \(error.localizedDescription)")
            }
            
        }
        
        return nil
    }
    
    struct ScreenSize {
        static let width = UIScreen.main.bounds.size.width
        static let height = UIScreen.main.bounds.size.height
        static let frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        static let maxWH = max(ScreenSize.width, ScreenSize.height)
    }
    struct DeviceType {
        static let iPhone4orLess = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH < 568.0
        static let iPhone5orSE   = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 568.0
        static let iPhone678     = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 667.0
        static let iPhone678p    = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 736.0
        static let iPhoneX       = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 812.0
        static let iPhoneXRMax   = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 896.0
        static var hasNotch: Bool {
            return iPhoneX || iPhoneXRMax
        }
    }
    
    class func formatNumber(_ value: NSNumber?) -> String? {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = NSLocale(localeIdentifier: "en") as Locale
        if let value = value {
            return nf.string(from: value)
        }
        return nil
    }
    
    class func getJsonString(from obj: Any) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
            let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
            return jsonString.filter { !" \n\t\r".contains($0) }
        } catch {
            return error.localizedDescription
        }
    }
    
    class func getDictionary(from str: String) -> [String: Any]? {
        if let data = str.data(using: .utf8) {
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                return dict
            } catch {
                print("Error on parsing response \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    class func getViewsFromXib(nibName : String) -> [UIView] {
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil) as! [UIView]
    }


    class func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    
    class func findSize(with text: String?, andFont font: UIFont?) -> CGFloat {
        var size: CGSize? = nil
        if let font = font {
            size = text?.size(withAttributes: [
                NSAttributedString.Key.font: font
                ])
        }
        return size?.width ?? 0.0
    }

    
    
    class func validate(_ value: String?) -> Bool {
        var value = value
        
        if value == nil {
            return false
        }
        
        let valueStr = value?.trimmingCharacters(in: CharacterSet.whitespaces)
        if (valueStr?.count ?? 0) == 0 {
            return false
        }
        value = valueStr
        return true
    }

}
