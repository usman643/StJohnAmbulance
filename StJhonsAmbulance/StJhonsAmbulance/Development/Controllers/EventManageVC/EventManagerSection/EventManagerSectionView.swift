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
    
//    class func instanceFromNib() -> UIView {
//        return UINib(nibName: "EventManagerSectionView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
//    }
    
    
    override func draw(_ rect: CGRect) {
        self.decorateUI()
    }
    
    func decorateUI(){
        lblDate.font = UIFont.BoldFont(14)
        lblTime.font = UIFont.BoldFont(14)
        
        lblDate.textColor = UIColor.orangeColor
        lblTime.textColor = UIColor.red
    }
    
}

