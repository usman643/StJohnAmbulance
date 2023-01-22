//
//  Validate.swift
//  WIT Edu
//
//  Created by Umair Yousaf on 20/08/2022.
//

import Foundation

class Validate{
    
    func isValidName(testStr:String) -> Bool {
        
       let regexExp =  "^[0-9a-zA-Z ]{1,}$"
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", regexExp)
        let result = predicateTest.evaluate(with: testStr)
        if result == true{
            return true
        }
        else{
            return false
        }
    }
    
    func isValidPassword(testStr:String) -> Bool {
        
        let regexExp = "[A-Z0-9a-z._%+-]{6,64}"
        let predicateTest = NSPredicate(format:  "SELF MATCHES %@ ", regexExp)
        let result = predicateTest.evaluate(with: testStr)
        if result == true{
            return true
        }
        else{
            return false
        }
    }
    
    func isEmailValid(emailStr: String) -> Bool {
        
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: emailStr, options: [], range: NSRange(location: 0, length: emailStr.count)) == nil {
                return false
            }
        } catch {
            return false
        }
        return true
    }
    
    
    func IsValidCNIC(cnicStr:String) -> Bool {
        
        let regexExp = "^[0-9]{13,13}$"
        let predicateTest = NSPredicate(format:  "SELF MATCHES %@ ", regexExp)
        let result = predicateTest.evaluate(with: cnicStr)
        if result == true{
            return true
        }
        else{
            return false
        }
    }
    

    func isValidDate(dateString: String) -> Bool {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"
        let someDate = dateString
        if dateFormatterGet.date(from: someDate) != nil {
            return true
        } else {
            return false
        }
   }
    
    func isValidPhone(testStr:String) -> Bool{
        
        let regexExp = "^[+]{1}[0-9]{12}$"
        let predicateTest = NSPredicate(format:  "SELF MATCHES %@ ", regexExp)
        let result = predicateTest.evaluate(with: testStr)
        if result == true{
            return true
        }
        else{
            return false
        }
    }
    func isValidAddress(testStr:String) -> Bool {
        
        let regexExp =  "^[0-9a-zA-Z#.,/ -]{1,}$"
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", regexExp)
        let result = predicateTest.evaluate(with: testStr)
        if result == true{
            return true
        }
        else{
            return false
        }
    }
}
