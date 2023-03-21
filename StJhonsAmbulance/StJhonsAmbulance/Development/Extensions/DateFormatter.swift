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
        let formatedDate = dateFormatter.date(from: date)
        
        let formatter = DateFormatter()
        formatter.dateFormat = newFormat
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
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.locale = Locale.current
        let date = date//self.userData?.date_of_birth
        return date
        //dateFormatter.date(from: date ?? "") // replace Date String
    }
    
    func getCurrentDateWithFormat(format: String?) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.locale = Locale.current
        let date = Date()//self.userData?.date_of_birth
        return dateFormatter.string(from: date)
        //dateFormatter.date(from: date ?? "") // replace Date String
    }
    
    
    
    
}

