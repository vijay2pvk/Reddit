//
//  RedditPostsServices.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

protocol RedditPostsServicesRequestType {
    func getPosts(afterLink: String?, completion: @escaping (Result<RedditPosts, Error>) -> Void)
}

/*** Posts Api Services */
class RedditPostsServices: RedditPostsServicesRequestType {
    let apiClient: RedditAPIClientProtocol

    init(apiClient: RedditAPIClientProtocol) {
        self.apiClient = apiClient
    }

    func getPosts(afterLink: String?, completion: @escaping (Result<RedditPosts, Error>) -> Void) {
        apiClient.executeRequest(with: RedditPostsEndPoints.getPosts(after: afterLink)) { result in
            switch result {
            case .failure(let error):
                return completion(.failure(error))
            case .success(let data):
                let transformedResult = RedditJsonToModelTransformer.convert(data: data, to: RedditPosts.self)
                return completion(transformedResult)
            }
        }
    }
}
