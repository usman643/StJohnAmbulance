//
//  EmptyEventTableCell.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 02/02/2023.
//

import UIKit

class EmptyEventTableCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.RegularFont(12)
        lblTitle.textColor = UIColor.textBlackColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
