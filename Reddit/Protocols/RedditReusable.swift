//
//  RedditReusable.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

protocol RedditReusable: class {
    static var reuseIdentifier: String { get }
}

extension RedditReusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
