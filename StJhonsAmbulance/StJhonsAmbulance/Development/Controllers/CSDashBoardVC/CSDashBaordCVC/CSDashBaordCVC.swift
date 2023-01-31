//
//  CSDashBaordCVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 24/01/2023.
//

import UIKit

class CSDashBaordCVC: UICollectionViewCell {

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }
    
    func decorateUI(){
        
        mainView.backgroundColor = UIColor.themePrimary
        mainView.layer.cornerRadius = 3
        imgView.layer.cornerRadius = imgView.frame.size.height/2
        
        lblCount.font = UIFont.RegularFont(12)
        lblTitle.font = UIFont.MediumFont(16)
        
        lblCount.textColor = UIColor.textWhiteColor
        lblTitle.textColor = UIColor.textWhiteColor
        
        lblCount.text = "22"
        lblTitle.text = "youth camp"
        
    }

}
