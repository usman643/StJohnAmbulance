//
//  CoreTableHeaderFooterView.swift
//  Aldar-Entertainer
//
//  Created by Muhammad Usman on 18/04/22.
//

import UIKit

class CoreTableHeaderFooterView: UITableViewHeaderFooterView {

    // MARK: - Properties
    static var identifier: String {
        return String(describing: self)
    }
    
    static func getNib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleSelfTap(_:)))
        return recognizer
    }()
    
    var handleTapOnSelf: ENTALDVoidCompletion? {
        didSet {
            if handleTapOnSelf != nil {
                addGestureRecognizer(tapGestureRecognizer)
            }
        }
    }
    
    // MARK: - Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
    
    func commonInit() {
    }
    
    @objc func handleSelfTap(_ sender: UITapGestureRecognizer) {
        handleTapOnSelf?()
    }
    
    // MARK: - Init Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}
