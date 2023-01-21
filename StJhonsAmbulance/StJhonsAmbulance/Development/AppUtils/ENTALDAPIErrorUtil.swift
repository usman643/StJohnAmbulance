//
//  ENTALDAPIErrorUtil.swift
//  ENTALDO
//
//  Created by M.Usman on 25/04/2022.
//

import Foundation
import UIKit

class ENTALDAPIError {
    
    let errorObject : NSError
    let title : String
    let buttonTitle: ActionTitle
    
    init(_ title : String, _ errorObject : NSError, _ buttonTitle: ActionTitle) {
        self.title = title
        self.errorObject = errorObject
        self.buttonTitle = buttonTitle
    }
}

class ENTALDAPIErrorUtils {
    
    static let shared : ENTALDAPIErrorUtils = ENTALDAPIErrorUtils()
    
    let internetDisconnectionMessage = "internet_disconnect_msg".localized
    let genericErrorMessage = "something_wennt_wrong_msg".localized
    let networkErrorTitle = "network_error_title".localized
    let networkErrorMessage = "network_error_msg".localized
    let internalServerError = "internal_server_error_msg".localized
    
    private init() {
        
    }
    
    //MARK: Parsing Error Methods
    func parseError(requestUrl:String, requestParams:Parameters? = [:], responseData:Any?, error: Error, completion: @escaping(_ error:ENTALDAPIError)->Void) {
       
    }
    
    func getGenaricError(error:NSError) -> NSError {
        return NSError(domain: UIApplication.appName, code: 10000, userInfo: [NSLocalizedDescriptionKey: self.genericErrorMessage])
    }
    
}


extension NSError {
    func isSignoutError() -> Bool {
        return self.code == 403 || self.code == 801
    }
    func isConnectAbortError() -> Bool {
        // ==> NSPOSIXErrorDomain Code=53: Software caused connection abort
        return self.code == 53
    }
    
    // MARK: Status Range Check
    func statusCodeRange(code:Int?, minValue:Int, maxValue:Int)->Bool{
        let errorCode = code ?? self.code
        if errorCode >= minValue && errorCode <= maxValue {
            return true
        }
        return false
    }
}
