//
//  AdhocHourTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 15/02/2023.
//

import UIKit

class AdhocHourTVC: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblProgram: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func decorateUI(){
        lblTitle.textColor = UIColor.textBlackColor
        lblTitle.font = UIFont.RegularFont(12)
        lblProgram.textColor = UIColor.textBlackColor
        lblProgram.font = UIFont.RegularFont(12)
        lblHours.textColor = UIColor.textBlackColor
        lblHours.font = UIFont.RegularFont(12)
        lblStatus.textColor = UIColor.textBlackColor
        lblStatus.font = UIFont.RegularFont(12)
        
        
    }
    
//    func setContent(cellModel: ){
//
//
//        lblTitle.text = cellModel?.
//        lblProgram.text = cellModel?.
//        lblHours.text = cellModel?.
//        lblStatus.text = cellModel?.
//    }
    
}
