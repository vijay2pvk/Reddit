//
//  RedditUIImageViewExtension.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 19/08/21.
//

import UIKit

extension UIImageView {
    func setProperties(imageName: String, mode: ContentMode) -> Self {
        Self.makeAutoLayoutView()
        
        self.image = UIImage(named: imageName)
        self.clipsToBounds = true
        self.contentMode =  mode
        return self
    }
}
