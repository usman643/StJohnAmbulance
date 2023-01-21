//
//  ENTALDDictionary+Extension.swift
//  ENTALDO
//
//  Created by M.Usman on 26/04/2022.
//

import Foundation

extension Dictionary {
    func bv_jsonString(withPrettyPrint prettyPrint: Bool) -> String? {
//        let error: Error?
        let jsonData: Data? = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions(rawValue: (prettyPrint ? JSONSerialization.WritingOptions.prettyPrinted.rawValue : 0)))
        
        if jsonData == nil {
            return "{}"
        } else {
            if let jsonData = jsonData {
                return String(data: jsonData, encoding: .utf8)
            }
            return nil
        }
    }
    mutating func merge(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
    var ns: NSMutableDictionary {
        let mutableDict = NSMutableDictionary(dictionary: self)
        return mutableDict
    }
    
}
extension Dictionary {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (exist index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
