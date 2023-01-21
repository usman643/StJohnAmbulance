//
//  CoreRefreshControl.swift
//  Aldar-Entertainer
//
//  Created by Muhammad Usman on 18/04/22.
//

import UIKit

class CoreRefreshControl: UIRefreshControl {

    var pulledToRefresh: ENTALDVoidCompletion!
    
    func commonInit() {
        addTarget(self, action: #selector(refreshStart), for: .valueChanged)
    }
    
    @objc private func refreshStart() {
        pulledToRefresh()
    }
    
    // MARK: - Init Methods
    override init() {
        super.init()
        commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

}
