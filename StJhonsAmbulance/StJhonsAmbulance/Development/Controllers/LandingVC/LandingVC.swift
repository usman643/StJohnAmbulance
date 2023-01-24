//
//  LandingVC.swift
//  SJA
//
//  Created by ENT20121341 on 20/01/2023.
//

import UIKit

class LandingVC: ENTALDBaseViewController {

    
    @IBOutlet weak var headerLogoView: UIView!
    @IBOutlet weak var headerLogoImgView: UIImageView!
    
    @IBOutlet weak var MainVw: UIView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
    }

    func decorateUI(){
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.themeSecondry
        headerLogoView.layer.cornerRadius =  headerLogoView.frame.size.height/2
        headerLogoView.backgroundColor = UIColor.themePrimary
        MainVw.layer.cornerRadius = 40
        MainVw.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        btn1.themeColorButton()
        btn2.themeColorButton()
        btn1.titleLabel?.font = UIFont.BoldFont(14)
        btn2.titleLabel?.font = UIFont.BoldFont(14)
        lblTitle.font = UIFont.BoldFont(24)
        lblDesc.font = UIFont.BoldFont(16)
        
        lblTitle.textColor = UIColor.textWhiteColor
        lblDesc.textColor = UIColor.themePrimaryColor
        
        
    }

}
