//
//  RedditAPIClientProtocol.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import Foundation

protocol RedditAPIClientProtocol {
    func executeRequest(with endpoint: RedditEndPointType, completion: @escaping (Result<Data, Error>) -> Void)
}

enum RedditAPIClientError: Error {
    case cannotFormURL
    case serverError
    case unknown
}
