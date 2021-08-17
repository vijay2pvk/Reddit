//
//  RedditAPIClient.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import Foundation

class RedditAPIClient: RedditAPIClientProtocol{
    // MARK: - Properties
    
    static let shared = RedditAPIClient()
    let apiSession: RedditAPISessionProtocol = RedditAPISession()
    
    private init() { }

    // MARK: - Methods
    
    func executeRequest(with endpoint: RedditEndPointType, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = endpoint.finalURL else {
            let result: Result<Data, Error> = .failure(RedditAPIClientError.cannotFormURL)
            completion(result)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.type

        if (endpoint.httpMethod == .put || endpoint.httpMethod == .post),
            let parameters = endpoint.parameters {
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
        }

        request.addValue(endpoint.contentType, forHTTPHeaderField: "Content-Type")

        apiSession.executeDataTask(with: request) { (data, response, error) in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
                else {
                    completion(.failure(RedditAPIClientError.serverError))
                    return
            }

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(RedditAPIClientError.unknown))
                return
            }
            completion(.success(data))
        }
    }
}
