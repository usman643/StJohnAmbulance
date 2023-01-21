//
//  ENTALDUIImageView+Extension.swift
//  Aldar-Entertainer
//
//  Created by M.Usman on 13/05/2022.
//

import Foundation
import SDWebImage

extension UIImageView {
    
    func downloadImage(with urlString: String, placeHolderImage: UIImage? = nil, completion: ((UIImage?, Bool) -> Void)? = nil) {
        if urlString.contains("http") {
            sd_setImage(with: URL(string: urlString), placeholderImage: placeHolderImage) { (downloadedImage, _, _, _) in
                completion?(downloadedImage, downloadedImage != nil)
            }
        }
    }
    
}
