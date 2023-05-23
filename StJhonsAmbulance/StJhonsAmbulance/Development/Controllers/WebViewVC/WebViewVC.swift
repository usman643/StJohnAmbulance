//
//  WebViewVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 19/02/2023.
//

import UIKit
import WebKit

class WebViewVC: ENTALDBaseViewController {
    
    var urlType : String!

    @IBOutlet weak var webview: WKWebView!
    
    var documentURL : String?
    var documentToken : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        super.viewWillAppear(animated)
        if (self.urlType == "register"){
            let link = Foundation.URL(string:ProcessUtils.shared.registerURL)!
            let request = URLRequest(url: link)
            webview.load(request)
        }else if (self.urlType == "forgot"){
            let link = Foundation.URL(string:"https://sjasandbox.b2clogin.com/sjasandbox.onmicrosoft.com/oauth2/v2.0/authorize?p=B2C_1_VolunteerEngagementpasswordreset_1&client_id=86d0acb3-3740-41ef-b0e2-cf2e9f77fdb7&nonce=defaultNonce&redirect_uri=https%3A%2F%2Foauth.pstmn.io%2Fv1%2Fcallback&scope=openid&response_type=id_token&prompt=login")!
            let request = URLRequest(url: link)
            webview.load(request)
        }else if (self.urlType == "updatepass"){
            let link = Foundation.URL(string:ProcessUtils.shared.changePassURL)!
            let request = URLRequest(url: link)
            webview.load(request)
        }else if (self.urlType == "document"){
            if let docUrlStr = self.documentURL, let token = self.documentToken {
                let urlStr = docUrlStr.replacingOccurrences(of: " ", with: "%20")
                guard let url = URL(string: urlStr) else { return}
                var request = URLRequest(url: url)
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                request.method = .get
                webview.load(request)
            }
        }
    }
}
