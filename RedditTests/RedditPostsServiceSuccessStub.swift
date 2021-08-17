//
//  RedditPostsServiceSuccessStub.swift
//  RedditTests
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import XCTest
@testable import Reddit

class RedditPostsServiceSuccessStub: RedditPostsServicesRequestType {
    
    func getPosts(afterLink: String?, completion: @escaping (Result<RedditPosts, Error>) -> Void) {
        let models = RedditMockPostsListGenerator.getPosts()!
        completion(.success(models))
    }
}
