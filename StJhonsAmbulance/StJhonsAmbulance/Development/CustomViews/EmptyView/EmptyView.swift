//
//  EmptyView.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 03/02/2023.
//

import UIKit

class EmptyView: UIView {

    @IBOutlet weak var lblTitle: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "EmptyView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    
    override func draw(_ rect: CGRect) {
        lblTitle.font = UIFont.BoldFont(16)
    }
    

}

