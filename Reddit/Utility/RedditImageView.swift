//
//  RedditImageView.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class RedditImageView: UIImageView {
    
    var imgUrlStr: String?
    
    func cacheImage(urlString: String?, completion: @escaping () -> Void) {
        
        guard let urlStr = urlString, let url = URL(string: urlStr) else {
            self.image = #imageLiteral(resourceName: "placeHolderImage")
            completion()
            return
        }
        
        imgUrlStr = urlStr
        self.image = nil
        
        /// Return image from cache if exists
        if let imageFromCache = imageCache.object(forKey: urlStr as NSString) {
            self.image = imageFromCache
            completion()
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let data = data, let imageToCache = UIImage(data: data) {
                DispatchQueue.main.async {
                    /// Check if the requested URL is same to avoid mismatch of image after download
                    if self.imgUrlStr == urlStr {
                        self.image = imageToCache
                    }
                    
                    imageCache.setObject(imageToCache, forKey: urlStr as NSString)
                    completion()
                }
            }
        }.resume()
    }
}

