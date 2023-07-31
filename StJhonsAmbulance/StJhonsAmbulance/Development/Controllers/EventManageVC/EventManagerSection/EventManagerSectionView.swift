//
//  EventManagerSectionView.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 14/02/2023.
//


import UIKit

class EventManagerSectionView : UITableViewHeaderFooterView {
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    override func draw(_ rect: CGRect) {
        self.decorateUI()
    }
    
    func decorateUI(){
//        self.contentView.backgroundColor = UIColor.themeColorSecondry
        lblDate.font = UIFont.BoldFont(16)
        lblTime.font = UIFont.BoldFont(16)
        lblDate.textColor = UIColor.themeLight
        lblTime.textColor = UIColor.themeLight
    }
    
}

