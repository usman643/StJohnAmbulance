//
//  CoreButton.swift
//  Aldar-Entertainer
//
//  Created by Muhammad Usman on 18/04/22.
//

import UIKit

class CoreButton: UIButton {
    
//    @IBInspectable var fontFamily: Int = AppFont.rubikMedium.rawValue {
//        didSet {
//            setFont()
//        }
//    }
    
    @IBInspectable var fontSize: CGFloat = 24 {
        didSet {
            setFont()
        }
    }
    
    @IBInspectable var doShowBorder: Bool = false {
        didSet {
            setupBorder()
        }
    }
    @IBInspectable var btnBorderColor: UIColor = .lightGray {
        didSet {
            setupBorder()
        }
    }
    @IBInspectable var localizableKey: String = "" {
        didSet {
            setTitle(localizableKey, for: .normal)
        }
    }
    
    var handleTap: (() -> Void)? = nil {
        didSet {
            if handleTap != nil {
                addTarget(self, action: #selector(didTapSelf(_:)), for: .touchUpInside)
            }
        }
    }
    
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
    
    private func setupBorder() {
        layer.borderWidth = doShowBorder ? 1 : 0
        layer.borderColor = btnBorderColor.cgColor
    }
    
    private func setFont() {
//        if let selectedFont = AppFont(rawValue: fontFamily) {
//            titleLabel?.font = selectedFont.getFont(withSize: fontSize)
//        }
    }
    
    @objc private func didTapSelf(_ sender: CoreButton) {
        handleTap?()
    }
}

class CoreSwitch : UISwitch {
    
    var handleTap: ((_ isOn: Bool) -> Void)? = nil {
        didSet {
            if handleTap != nil {
                addTarget(self, action: #selector(didTapSelf(_:)), for: .touchUpInside)
            }
        }
    }
    
    @objc private func didTapSelf(_ sender: CoreSwitch) {
        handleTap?(sender.isOn)
    }
}
