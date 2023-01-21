//
//  CoreLabel.swift
//  Aldar-Entertainer
//
//  Created by Muhammad Usman on 18/04/22.
//

import UIKit

class CoreLabel: UILabel {
    
    // MARK: - Inspectable Properties
//    @IBInspectable var fontFamily: Int = AppFont.rubikRegular.rawValue {
//        didSet {
//            setFont()
//        }
//    }
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
    @IBInspectable var fontSize: CGFloat = 18 {
        didSet {
            setFont()
        }
    }
    @IBInspectable var localizableKey: String = "" {
        didSet {
            text = localizableKey
        }
    }
    
    // MARK: - Properties
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleSelfTap(_:)))
        return recognizer
    }()
    
    var handleSelfTap: ENTALDVoidCompletion? = nil {
        didSet {
            if handleSelfTap != nil {
                isUserInteractionEnabled = true
                addGestureRecognizer(tapGestureRecognizer)
            }
        }
    }
    
    // MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        commonInit()
    }
    
    func commonInit() {
        setFont()
    }
    
    private func setFont() {
//        if let selectedFont = AppFont(rawValue: fontFamily) {
//            font = selectedFont.getFont(withSize: fontSize)
//        }
    }
    
    @objc private func handleSelfTap(_ sender: UITapGestureRecognizer) {
        handleSelfTap?()
    }
}
