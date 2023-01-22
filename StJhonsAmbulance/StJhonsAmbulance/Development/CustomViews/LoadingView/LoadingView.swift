//
//  LoadingView.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/22/23.
//

import Foundation
import UIKit

class LoadingView: NSObject {
    
    // MARK: - Controls
    static let transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return view
    }()
    
    static let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }()
    
    static let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - Methods
    class func show() {
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            
            window.addSubview(transparentView)
            window.addConstraintsWithFormat("H:|[v0]|", views: transparentView)
            window.addConstraintsWithFormat("V:|[v0]|", views: transparentView)
            
            window.addSubview(activityIndicatorView)
            window.addConstraints([
                NSLayoutConstraint(item: activityIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: window, attribute: .centerY, multiplier: 1, constant: 0)
            ])
            let heightWidth: CGFloat = 150
            activityIndicatorView.heightAnchor.constraint(equalToConstant: heightWidth).isActive = true
            activityIndicatorView.widthAnchor.constraint(equalToConstant: heightWidth).isActive = true
            window.bringSubviewToFront(activityIndicatorView)
            activityIndicatorView.color = .lightGray //UserDefaults.standard.isDarkMode ? .white : .black
            activityIndicatorView.startAnimating()
        }
    }
    
    class func hide() {
        transparentView.removeFromSuperview()
        activityIndicatorView.removeFromSuperview()
    }
    
}
