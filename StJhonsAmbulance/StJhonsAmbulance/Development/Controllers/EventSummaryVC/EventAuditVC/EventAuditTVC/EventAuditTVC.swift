//
//  EventAuditTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/03/2023.
//

import UIKit
import Foundation



class EventAuditTVC: UITableViewCell {

    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblChangeDate: UILabel!
    @IBOutlet weak var lblChangeBy: UILabel!
    @IBOutlet weak var lblChangeEvent: UILabel!
    @IBOutlet weak var lblChangeField: UILabel!
    @IBOutlet weak var lblOldValue: UILabel!
    @IBOutlet weak var lblNewValue: UILabel!
    
    
    @IBOutlet weak var seperterView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func decorateUI(){
        lblChangeDate.textColor = UIColor.textBlackColor
        lblChangeBy.textColor = UIColor.textBlackColor
        lblChangeEvent.textColor = UIColor.textBlackColor
        lblChangeField.textColor = UIColor.textBlackColor
        lblOldValue.textColor = UIColor.textBlackColor
        lblNewValue.textColor = UIColor.textBlackColor
        
        lblChangeDate.font = UIFont.BoldFont(11)
        lblChangeBy.font = UIFont.BoldFont(11)
        lblChangeEvent.font = UIFont.BoldFont(11)
        lblChangeField.font = UIFont.BoldFont(11)
        lblOldValue.font = UIFont.BoldFont(11)
        lblNewValue.font = UIFont.BoldFont(11)
    }
    
    func setContent(cellModel : AuditModel?){
        
        if let date = cellModel?.changedata {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
            lblChangeDate.text = start
        }else{
            lblChangeDate.text = ""
        }
        
        lblChangeBy.text = cellModel?.userid_value_formatted_value ?? ""
        lblChangeEvent.text = cellModel?.objectid_formatted_value ?? ""
        
        
        do {
            let data = Data((cellModel?.changedata?.utf8)!)
            let str = try JSONDecoder().decode(ChangeAttributeModel.self, from: data)
            lblChangeField.text = str.changedAttributes[0].logicalName ?? ""
            lblOldValue.text = str.changedAttributes[0].oldValue ?? ""
            lblNewValue.text = str.changedAttributes[0].newValue ?? ""
        } catch {
            print("Error on parsing response")
        }
    }

}
