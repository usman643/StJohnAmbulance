//
//  CoreTableView.swift
//  Aldar-Entertainer
//
//  Created by Muhammad Usman on 18/04/22.
//


import UIKit

class CoreTableView: UITableView {

    // MARK: - Controls
    private let collectionRefreshControl = CoreRefreshControl()
    
    // MARK: - Properties
    var didPullToRefresh: ((_ control: UIRefreshControl) -> Void)? {
        didSet {
            if didPullToRefresh != nil {
                refreshControl = collectionRefreshControl
                collectionRefreshControl.pulledToRefresh = {
                    self.didPullToRefresh?(self.collectionRefreshControl)
                }
            }
        }
    }
    var blockForTouchesBegan: ((_ touches: Set<UITouch>, _ event: UIEvent?) -> Void)?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        blockForTouchesBegan?((touches), event)
    }
    // MARK: - Init Methods
    func commonInit() {
        self.tableFooterView = UIView()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func setScrollIndicatorColor(on scrollView: UIScrollView, color: UIColor = .lightGray) {
        let position = (scrollView.subviews.count - 1)
        if scrollView.subviews.count > position, let scrollIndicatorView = scrollView.subviews[position].subviews.first {
            scrollIndicatorView.backgroundColor = color
        }
    }
}

extension UITableView {
    // MARK: - Properties
    func registerTableViewCell(_ nibNames:[String]){
        for nibName in nibNames {
            self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        }
    }
}
