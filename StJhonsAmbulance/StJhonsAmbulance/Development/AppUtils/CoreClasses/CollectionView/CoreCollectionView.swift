//
//  CoreCollectionView.swift
//  Aldar-Entertainer
//
//  Created by Muhammad Usman on 18/04/22.
//

import UIKit

class CoreCollectionView: UICollectionView {

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

class FlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            guard let originalAttributes = super.layoutAttributesForElements(in: rect) else {
                return nil
            }
            var leftMargin: CGFloat = 0.0
            var lastY: Int = 0
            return originalAttributes.map {
                let changedAttribute = $0
                // Check if start of a new row.
                // Center Y should be equal for all items on the same row
                if Int(changedAttribute.center.y.rounded()) != lastY {
                    leftMargin = sectionInset.left
                }
                changedAttribute.frame.origin.x = leftMargin
                lastY = Int(changedAttribute.center.y.rounded())
                leftMargin += changedAttribute.frame.width + minimumInteritemSpacing
                return changedAttribute
            }
        }
    
    
}


extension UICollectionView {
    // MARK: - Properties
    func registerCollectionViewCell(_ nibNames:[String]){
        for nibName in nibNames {
            self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
        }
    }
}
