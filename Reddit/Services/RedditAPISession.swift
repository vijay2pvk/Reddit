//
//  RedditAPISession.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import Foundation

class RedditAPISession: RedditAPISessionProtocol {
    func executeDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
        dataTask.resume()
    }
}
