//
//  ENTALDOnBoardingCVC.swift
//  Aldar-Entertainer
//
//  Created by M.Usman on 13/05/2022.
//

import UIKit

struct ENTALDOnBoardingCVCViewModel {
    let model : ENTALDOnBoardingSectionModel
}

class ENTALDOnBoardingCVC: CoreCollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var forwadImg: UIImageView!
    @IBOutlet weak var btnNext: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.btnNext.setTitle("", for: .normal)
        self.lbltitle.font = UIFont.ENTALDBoldFont(32.0)
        self.lblDesc.font = UIFont.ENTALDRegularFont(16.0)
        self.btnNext.titleLabel?.font = UIFont.ENTALDBoldFont(16.0)
        self.lbltitle.numberOfLines = 2
        self.lblDesc.numberOfLines = 0
        self.btnNext.backgroundColor = UIColor.clear
        self.btnView.layer.cornerRadius = 8
        self.lbltitle.textColor = UIColor.appThemeColor
        self.lblDesc.textColor = .appBlack
        self.btnView.backgroundColor = .appThemeColor
        self.btnNext.setTitleColor(.appWhite, for: .normal)
        
    }
    
    func configure(_ viewModel:ENTALDOnBoardingCVCViewModel){
        self.lbltitle.text = viewModel.model.title
        self.lblDesc.text = viewModel.model.detail
        self.btnNext.setTitle(viewModel.model.btn_title, for: .normal)
        if let imageName = viewModel.model.image_bg {
            self.imgView.image = Bundle .loadImageFromResourceAFBundlePNG(imageName: "\(imageName).png")
        }
        
    }
    
    
}
