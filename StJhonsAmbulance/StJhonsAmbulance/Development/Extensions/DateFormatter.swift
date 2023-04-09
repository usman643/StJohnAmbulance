//
//  DateFormatter.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 31/01/2023.
//

import Foundation

class DateFormatManager{
    
    private init() {}
    static let shared : DateFormatManager = DateFormatManager()
    
    func unixTimeconvert(time: String) ->String {
        
        if let timeResult = (Double(time)) {
            let date = Date(timeIntervalSince1970: timeResult)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            //dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            return localDate
        }
        return ""
    }
    
    func unixDateConvert(time: String) ->String {
        
        if let timeResult = (Double(time)) {
            let date = Date(timeIntervalSince1970: timeResult)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
//            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            return localDate
        }
        return ""
    }
    
    func formatDateStrToStr(date: String, oldFormat: String, newFormat:String )->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = oldFormat
        dateFormatter.timeZone = TimeZone(identifier: "UTC")

        var formatedDate = dateFormatter.date(from: date)
        
//        formatedDate = Calendar.current.date(byAdding: .hour, value: -5, to: formatedDate ?? Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = newFormat
        formatter.timeZone = TimeZone(identifier: "America/New_York")
        if (date != "" ){
            return formatter.string(from: formatedDate ?? Date() )
        }else{
            return ""
        }
    }
    
    func formatDateStrToStrWithoutTimeZone(date: String, oldFormat: String, newFormat:String )->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = oldFormat
//        dateFormatter.timeZone = TimeZone(identifier: "UTC")

        var formatedDate = dateFormatter.date(from: date)
        
//        formatedDate = Calendar.current.date(byAdding: .hour, value: -5, to: formatedDate ?? Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = newFormat
        formatter.timeZone = TimeZone(identifier: "America/New_York")
        if (date != "" ){
            return formatter.string(from: formatedDate ?? Date() )
        }else{
            return ""
        }
    }
    
    
    func formatDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return formatter.string(from: date)
    }
    
//
//    func formatDate(date: Date) -> String
//    {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd/MM/yyyy"
//        return formatter.string(from: date)
//    }
//
    func getDate(date: String?) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
//        dateFormatter.locale = Locale.current
        let date = date//self.userData?.date_of_birth
        return date
        //dateFormatter.date(from: date ?? "") // replace Date String
    }
    
    func getCurrentDateWithFormat(format: String?) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")

        let date = Date()//self.userData?.date_of_birth
        return dateFormatter.string(from: date)
        //dateFormatter.date(from: date ?? "") // replace Date String
    }
    
    
    func isDatePassed(date:String , format: String) -> Bool{
        
 
        
        let dateFormat = DateFormatter()
        dateFormat.timeZone = TimeZone(identifier: "America/New_York")
        let currentdate = Date()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let cDate = dateFormat.string(from: currentdate)
        
        if (date <  cDate){
            return false
        }
        return true
    }
    
    func getDateFromUnixCode(date: String) ->Date {
        
        if let timeResult = (Double(date)) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
            let date = Date(timeIntervalSince1970: timeResult)
            let exptDate = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
//            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
//            
            return dateFormatter.date(from: exptDate) ?? Date()
        }
        return Date()
    }
    
//    func getDateAndTime(timeZoneIdentifier: String) -> String? {
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
//        dateFormatter.timeZone = TimeZone(identifier: timeZoneIdentifier)
//
//        return dateFormatter.string(from: Date())
//    }
//
//    print(getDateAndTime(timeZoneIdentifier: "UTC"))
//    
//    
}

