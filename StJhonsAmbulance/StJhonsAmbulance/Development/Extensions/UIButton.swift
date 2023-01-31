//
//  UIButton.swift
//  WIT Edu
//
//  Created by Umair Yousaf on 14/08/2022.
//

import Foundation
import UIKit

extension  UIButton{
    
    
    func themeColorButton() {
        
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
        self.backgroundColor = UIColor.themePrimary
        self.titleLabel?.textColor = UIColor.white
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
}
