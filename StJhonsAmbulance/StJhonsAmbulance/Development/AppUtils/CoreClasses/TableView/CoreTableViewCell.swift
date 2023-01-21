//
//  CoreTableViewCell.swift
//  Aldar-Entertainer
//
//  Created by Muhammad Usman on 18/04/22.
//

import UIKit

class CoreTableViewCell: UITableViewCell {

    // MARK: - Properties
    static var identifier : String {
        return String(describing: self)
    }
    
    static func getNib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
    
    func commonInit() {
        selectionStyle = .none
    }
    
    // MARK: - Init Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}
