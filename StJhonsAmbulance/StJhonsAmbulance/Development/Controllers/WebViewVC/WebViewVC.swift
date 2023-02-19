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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
        super.viewWillAppear(animated)
        if (self.urlType == "register"){
            let link = Foundation.URL(string:ProcessUtils.shared.registerURL)!
            let request = URLRequest(url: link)
            webview.load(request)
        }else if (self.urlType == "forgot"){
            let link = Foundation.URL(string:ProcessUtils.shared.registerURL)!
            let request = URLRequest(url: link)
            webview.load(request)
        }
        
    
        
        
       
    }


 

}
