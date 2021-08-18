//
//  RedditUILabelExtension.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 19/08/21.
//

import UIKit
import Foundation

extension UILabel {
    func setProperties(color: UIColor, font: UIFont, lines: Int, alignment: NSTextAlignment) -> Self {
        self.font = font
        self.textColor =  color
        self.numberOfLines = lines
        self.textAlignment = alignment
        self.sizeToFit()
        return self
    }
}
