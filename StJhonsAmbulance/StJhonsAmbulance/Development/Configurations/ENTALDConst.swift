//
//  ENTALDConst.swift
//  ENTALDO
//
//  Created by M.Usman on 23/04/2022.
//

import UIKit

let IS_DEBUG = true
let IS_ENCRYPTION_ALLOWED = false
let IS_NEW_RELIC_ENABLE = true

let IS_KOCHAVA_ENABLE = false
let IS_Branch_Event_ENABLE = false

//callback Types
typealias ControllerCallBackCompletion = ((_ params:Any?, _ controller:UIViewController?) -> Void)
typealias ControllerPresentCompletion = (() -> Void)

typealias ENTALDShowErrorAlertCallback = ((_ title:String?, _ message:String?, _ args:Any?) -> Void)
typealias ENTALDVoidCompletion = (() -> Void)


let DEFAULTS                = UserDefaults.standard
let APPDELEGATE             = UIApplication.shared.delegate as! AppDelegate
let NOTIFICATIONCENTER      = NotificationCenter.default
let APPLICATION             = UIApplication.shared
let USERINTERFACEIDIOM      = UIDevice.current.userInterfaceIdiom
let sceneDelegate = UIApplication.shared.connectedScenes
        .first?.delegate as? SceneDelegate


//Screen Sizes
let DEVICE_OFFSET = UIScreen.main.bounds.width / 320
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)
let IS_IPHONE = (UIDevice().userInterfaceIdiom == USERINTERFACEIDIOM)
let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH < 568.0
let IS_IPHONE_5_GREATER = IS_IPHONE && SCREEN_MAX_LENGTH > 568.0
let IS_IPHONE_5 = IS_IPHONE && SCREEN_MAX_LENGTH == 568.0
let IS_IPHONE_6 = IS_IPHONE && SCREEN_MAX_LENGTH == 667.0
let IS_IPHONE_6P = IS_IPHONE && SCREEN_MAX_LENGTH == 736.0
let IS_IPHONE_X = IS_IPHONE && UIScreen.main.bounds.size.height == 812.0
let IS_IPHONE_XS = IS_IPHONE && UIScreen.main.bounds.size.height == 812.0
let IS_IPHONE_XR = IS_IPHONE && UIScreen.main.bounds.size.height == 896.0
let IS_IPHONE_XS_MAX = IS_IPHONE && UIScreen.main.bounds.size.height == 896.0
let IS_IPHONE_WITH_NOTCH_DEVICES = IS_IPHONE_X || IS_IPHONE_XR || IS_IPHONE_XS || IS_IPHONE_XS_MAX

let IS_RETINA = UIScreen.main.scale >= 2.0
let IPHONE_6_DEVICE_OFFSET = UIScreen.main.bounds.width / 375


