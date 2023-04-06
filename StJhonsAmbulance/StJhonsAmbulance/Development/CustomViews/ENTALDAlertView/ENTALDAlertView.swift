//
//  ENTALDAlertView.swift
//  Aldar-Entertainer
//
//  Created by M.Usman on 11/05/2022.
//

import UIKit
import SCLAlertView

class ENTALDAlertView: UIView {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var imgIcon: UIImageView!
    
    static let shared : ENTALDAlertView = ENTALDAlertView.sharedInit(.zero)
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
//    override private init(frame: CGRect) {
//        super.init(frame: frame)
//        self.sharedInit()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        self.sharedInit()
//    }
//
    class private func sharedInit(_ size:CGSize)->ENTALDAlertView{
        let view = Bundle.main.loadNibNamed("ENTALDAlertView", owner: self, options: nil)?.first as! ENTALDAlertView
        view.frame.size = size
        return view
    }
    
    func showAPIAlertWithTitle(title:String?, message:String?, actionTitle:ActionTitle, completion: @escaping(_ status:Bool)->Void){
        let appearence = SCLAlertView.SCLAppearance(
            kWindowWidth : SCREEN_WIDTH * 0.80,
            kTitleFont: UIFont.MediumFont(20.0),
            kTextFont: UIFont.RegularFont(16.0),
            showCloseButton: false,
            showCircularIcon : false
        )
        let alert = SCLAlertView(appearance: appearence)
        alert.addButton(actionTitle.getTitleString(), backgroundColor: UIColor.red, textColor: UIColor.white) {
            switch actionTitle {
            case .KRELOAD:
                completion(true)
            default:
                completion(false)
            }
        }
        
        alert.showSuccess(title ?? "", subTitle: message ?? "")
    }
    
    private func showAlertWithFrame(){
        
        var width = SCREEN_WIDTH * 0.85
        var height = 170 + self.lblTitle.bounds.size.height;
        
        if (width > 330) {
            width = 330;
        } else if (width < 250) {
            width = 250;
        }

        if (height > 320) {
            height = 200;
        } else if (width < 300) {
            height = 300;
        }
        
    }
    
    func showContactAlertWithTitle(title:String?, message:String?, actionTitle:ActionTitle, completion: @escaping(_ status:Bool)->Void){
        let appearence = SCLAlertView.SCLAppearance(
            kWindowWidth : SCREEN_WIDTH * 0.80,
            kTitleFont: UIFont.MediumFont(20.0),
            kTextFont: UIFont.RegularFont(16.0),
            showCloseButton: false,
            showCircularIcon : false
        )
        let alert = SCLAlertView(appearance: appearence)
        alert.addButton(actionTitle.getTitleString(), backgroundColor: UIColor.themeSecondry, textColor: UIColor.white) {
            switch actionTitle {
            case .KRELOAD:
                completion(true)
            default:
                completion(false)
            }
        }
        
        alert.showSuccess(title ?? "", subTitle: message ?? "")
    }
    
    func showActionAlertWithTitle(title:String?, message:String?, actionTitle:ActionTitle, completion: @escaping(_ status:Bool)->Void){
        let appearence = SCLAlertView.SCLAppearance(
            kWindowWidth : SCREEN_WIDTH * 0.80,
            kTitleFont: UIFont.MediumFont(20.0),
            kTextFont: UIFont.RegularFont(16.0),
            showCloseButton: false,
            showCircularIcon : false
        )
        let alert = SCLAlertView(appearance: appearence)
        alert.addButton(actionTitle.getTitleString(), backgroundColor: UIColor.themeSecondry, textColor: UIColor.white) {
            switch actionTitle {
            case .KOK:
                completion(true)
            default:
                completion(false)
            }
        }
        alert.addButton(actionTitle.getTitleString(), backgroundColor: UIColor.themeSecondry, textColor: UIColor.white) {
            switch actionTitle {
            case .KCANCEL:
                completion(false)
            default:
                completion(false)
            }
        }
        
        alert.showSuccess(title ?? "", subTitle: message ?? "")
    }
    
}
