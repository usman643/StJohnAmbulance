//
//  EventDetailTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 29/09/2023.
//

import UIKit

class EventDetailTVC: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblShift: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var switchChange: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        decorateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func decorateUI(){
        mainView.layer.cornerRadius = 12
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.systemGray3.cgColor
        mainView.layer.shadowColor = UIColor.systemGray4.cgColor
        mainView.layer.shadowOpacity = 0.5
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 6
    }
    
    
    @IBAction func switchAction(_ sender: Any) {
        
        
    }
    
    
}
