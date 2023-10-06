//
//  PendingEventTVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 28/01/2023.
//

import UIKit

class PendingEventTVC: UITableViewCell {
    
    public var delegate: updatePendingEventStatusDelegate?
    var eventId : String?
    var eventData : CurrentEventsModel?
    var isFromUnpublish : Bool?

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var seperaterView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deocrateUI()
    }
    
    func deocrateUI(){
        
        lblName.font = UIFont.BoldFont(11)
        lblLocation.font = UIFont.BoldFont(11)
        lblMax.font = UIFont.BoldFont(11)
        lblDate.font = UIFont.BoldFont(11)
        lblStatus.font = UIFont.BoldFont(11)
        
        lblName.textColor = UIColor.textBlackColor
        lblLocation.textColor = UIColor.textBlackColor
        lblMax.textColor = UIColor.textBlackColor
        lblDate.textColor = UIColor.textBlackColor
        lblStatus.textColor = UIColor.textBlackColor
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
