//
//  RedditPostsListCellVM.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import Foundation

protocol RedditPostsListCellRepresentable {
    var title: String { get }
    var score: String { get }
    var thumbnail: String { get }
    var numComment: String { get }
    var imgAspectRatio: Float { get }
}

struct RedditPostsListCellVM: RedditPostsListCellRepresentable, Decodable {
    // MARK:- Properties

    var title: String
    var score: String
    var thumbnail: String
    var numComment: String
    var imgAspectRatio: Float = 1.0

    // MARK:- Initializer

    init(post: RedditPostsChildData) {
        title = post.title
        score = (post.score >= 1000 ? String(format: "%.1fk", Double(post.score)/1000) : "\(post.score)")
        
        if let url = URL(string: post.thumbnail), url.pathExtension.hasSuffix("jpg") {
            thumbnail = post.thumbnail
        } else {
            thumbnail = ""
        }
        numComment = (post.numComments >= 1000 ? String(format: "%.1fk", Double(post.numComments)/1000) : "\(post.numComments)")
        
        if let width = post.thumbnailWidth, let height = post.thumbnailHeight {
            let value = Float(width) / Float(height)
            imgAspectRatio = round(value * 10) / 10.0
        }
    }
}
