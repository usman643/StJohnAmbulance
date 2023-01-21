//
//  CoreControls.swift
//  Aldar-Entertainer
//
//  Created by Muhammad Usman on 18/04/22.
//

import UIKit

class CoreSegment: UISegmentedControl {
    
    var handleTap: ((_ sender: Int) -> Void)? = nil {
        didSet {
            if handleTap != nil {
                addTarget(self, action: #selector(didTapSelf(_:)), for: .touchUpInside)
                addTarget(self, action: #selector(didTapSelf(_:)), for: .valueChanged)
            }
        }
    }
    
    @objc private func didTapSelf(_ sender: CoreSegment) {
        handleTap?(sender.selectedSegmentIndex)
    }
}

class CoreDatePicker: UIDatePicker {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapSelf(_ sender: CoreDatePicker) {
        handleTap?(sender.date)
    }
    
    private func setupView() {
        datePickerMode = .time
        if #available(iOS 13.4, *) {
            preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        /*if #available(iOS 14.0, *) {
            preferredDatePickerStyle = .inline
        }
        if #available(iOS 13.4, *) {
            preferredDatePickerStyle = .compact
        } else {
            // Fallback on earlier versions
        }*/
    }
    
    var handleTap: ((_ date: Date) -> Void)? = nil {
        didSet {
            if handleTap != nil {
                addTarget(self, action: #selector(didTapSelf(_:)), for: .valueChanged)
            }
        }
    }
}

class CoreToolbar : UIToolbar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        fatalError("init(coder:) has not been implemented")
    }
    
    func setItems(_ items: [UIBarButtonItem]? ) {
        self.items = items
    }
    
    fileprivate func setupView() {
        barStyle = .default
        /*items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: nil),
        ]*/
        isUserInteractionEnabled = true
        isTranslucent = true
        //sizeToFit()
    }
    
    /*@objc func cancelPressed() {
        //Cancel
    }
    @objc func donePressed() {
        //Done
    }
    
    @objc private func didTapSelf(_ sender: CoreButton) {
        handleTap?()
    }
    
    var handleTap: (() -> Void)? = nil {
        didSet {
            if handleTap != nil {
                
            }
        }
    }*/
}
