//
//  NSBundle+Extension.swift
//  ENTALDO
//
//  Created by M.Usman on 24/04/2022.
//

import Foundation
import UIKit

extension Bundle {
    
    class func getAldarBundle()->Bundle{
        let bundle = Bundle.main
        return bundle
    }
    
    class func loadPathFromResourceAFBundleGIF(imageName:String)->String?{
        let bundle = self.getAldarBundle()
        let fileName = "\(imageName).gif"
        let path = bundle.path(forResource: fileName, ofType: nil)
        return path
    }
    
    class func loadImageFromResourceAFBundlePNG(imageName:String)->UIImage?{
        let bundle = self.getAldarBundle()
        let fileName = "\(imageName).png"
        let image = UIImage(named: fileName, in: bundle, compatibleWith: nil)
        return image
    }
    

}
