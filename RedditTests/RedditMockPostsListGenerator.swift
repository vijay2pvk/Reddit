//
//  RedditMockPostsListGenerator.swift
//  RedditTests
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import XCTest
@testable import Reddit

class RedditMockPostsListGenerator: XCTestCase {

    class func getData(fileName: String, type: String) -> Data {
        let path = Bundle(for: RedditMockPostsListGenerator.self).path(forResource: fileName, ofType: type)!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        return data
    }
    
    class func getPosts() -> RedditPosts? {
        let result = RedditJsonToModelTransformer.convert(data: getData(fileName: "PostsList", type: "json"), to: RedditPosts.self)
        switch result {
        case .failure:
            return nil
        case .success(let posts):
            return posts
        }
    }
}
