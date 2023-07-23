//
//  PendingEventCell.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 23/07/2023.
//

import UIKit

class PendingEventCell: UITableViewCell {
    
    public var delegate: updatePendingEventStatusDelegate?
    var eventId : String?
    var eventData : CurrentEventsModel?
    var isFromUnpublish : Bool?

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var btnStatus: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deocrateUI()
    }
    
    func deocrateUI(){
        
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.systemGray3.cgColor
        mainView.layer.shadowColor = UIColor.systemGray4.cgColor
        mainView.layer.shadowOpacity = 0.5
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowRadius = 6
        
        mainView.layer.cornerRadius = 16
        statusView.layer.cornerRadius = 16
        statusView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        btnStatus.setTitleColor(UIColor.textWhiteColor, for: .normal)
       
        btnStatus.titleLabel?.font = UIFont.BoldFont(13)
        
        
        
        lblName.font = UIFont.BoldFont(14)
        lblLocation.font = UIFont.RegularFont(13)
        lblMax.font = UIFont.RegularFont(13)
        lblDate.font = UIFont.RegularFont(11)
        
        
        lblName.textColor = UIColor.themePrimaryWhite
        lblLocation.textColor = UIColor.themePrimaryWhite
        lblMax.textColor = UIColor.themePrimaryWhite
        lblDate.textColor = UIColor.themePrimaryWhite
      
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func changeStatusTapped(_ sender: Any) {
        if isFromUnpublish == true {
            delegate?.openViewSummaryScreen(eventdata: self.eventData!)
            return
        }
        if eventId != nil && eventId != ""{
            delegate?.updateSiglePendingEventStatus(eventId: self.eventId ?? "")
        }
        
    }
    
}
