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


enum ApiError: Error {

    case unauthorise            //Status Code 401
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
    case unknownError           //Status code not known
    case invalidJson            //if the response is not in json format
    case requestFailed
    var message: String {

        switch self {
        case .unauthorise: return "Your session has been expired."
        case .internalServerError: return "Internal Server Error. Please try again later"
        case .invalidJson: return "JSON Parsing Failure"
        case .requestFailed: return "Request failed"
        default: return "Sorry, something went wrong. Please try again later."

        }
    }

}

struct ErrorResponse {
    
    let error: String
    let error_description: String
    
    init?(dictionary: [String:Any]) {
        if let errorTitle = dictionary["error"] as? String,
            let message = dictionary["error_description"] as? String{
            self.error = errorTitle
            self.error_description = message
            
        } else {
            return nil
        }
        
    }
}
