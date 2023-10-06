//
//  MessageTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 26/01/2023.
//

import UIKit

class MessageTVC: UITableViewCell {

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var dividerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func decorateUI(){
        lblName.font = UIFont.BoldFont(14)
        lblDate.font = UIFont.BoldFont(14)
        lblMessage.font = UIFont.BoldFont(12)
        
        lblName.textColor = UIColor.textBlackColor
        lblDate.textColor = UIColor.textBlackColor
        lblMessage.textColor = UIColor.textBlackColor
//        messageView.dropShadow(color: UIColor.gray, offSet: .zero)
        messageView.backgroundColor = UIColor.clear
        dividerView.backgroundColor = UIColor.textBlackColor
    }
//    func dropShadow() {
//            layer.masksToBounds = false
//            layer.shadowColor = UIColor.black.cgColor
//            layer.shadowOpacity = 0.5
//            layer.shadowOffset = CGSize(width: -1, height: 1)
//            layer.shadowRadius = 1
//            layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//            layer.shouldRasterize = true
//            layer.rasterizationScale = UIScreen.main.scale
//        }
}
