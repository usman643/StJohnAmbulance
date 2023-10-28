//
//  EventDetailHeaderView.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 29/10/2023.
//

import UIKit

class EventDetailHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var lblShift: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var headerview: UIView!
    
    override func draw(_ rect: CGRect) {
        self.decorateUI()
    }
    
    func decorateUI(){
//        self.contentView.backgroundColor = UIColor.themeColorSecondry
        lblShift.font = UIFont.BoldFont(16)
        lblTime.font = UIFont.BoldFont(16)
        lblShift.textColor = UIColor.themeLight
        lblTime.textColor = UIColor.themeLight
        headerview.backgroundColor = UIColor.headerGreen
        headerview.layer.cornerRadius = 12
        headerview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
}

