//
//  LanguageCVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 11/03/2023.
//

import UIKit

class LanguageCVC: UICollectionViewCell {

    
    
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    var index : Int!
    public var delegate: OtherLanguageCloseDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainContentView.layer.cornerRadius = 5
        mainContentView.layer.borderWidth = 0.5
        mainContentView.layer.borderColor = UIColor.lightGray.cgColor
        
    }

    @IBAction func closeTapped(_ sender: Any) {
        if index != nil {
            delegate?.otherLanguageClose(index: self.index)
        }
    }
}
