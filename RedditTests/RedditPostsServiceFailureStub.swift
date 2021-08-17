//
//  RedditPostsServiceFailureStub.swift
//  RedditTests
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import XCTest
@testable import Reddit

class RedditPostsServiceFailureStub: RedditPostsServicesRequestType {

    func getPosts(afterLink: String?, completion: @escaping (Result<RedditPosts, Error>) -> Void) {
        completion(.failure(RedditAPIClientError.unknown))
    }
}
