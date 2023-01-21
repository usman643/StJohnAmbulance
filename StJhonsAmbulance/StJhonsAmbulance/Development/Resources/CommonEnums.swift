//
//  CommonEnums.swift
//  Aldar-Entertainer
//
//  Created by M.Usman on 11/05/2022.
//

import Foundation

enum ActionTitle {
    case KRELOAD
    case KOK
    case KCANCEL
    
    func getTitleString()->String{
        switch self {
        case .KRELOAD:
            return "reload_button".localized
        case .KOK:
            return "ok_button".localized
        case .KCANCEL:
            return "cancel_button".localized
        }
    }
    
}
