//
//  RedditStringExtension.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 19/08/21.
//

import Foundation

extension String {
    func checkIfValidImageUrl() -> Bool {
        let imageFormats = ["jpg", "jpeg", "png", "gif"]

        if let url = URL(string: self), imageFormats.contains(url.pathExtension) {
            return true
        }
        return false
    }
}
