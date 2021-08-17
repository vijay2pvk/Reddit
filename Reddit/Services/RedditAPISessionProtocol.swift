//
//  RedditAPISessionProtocol.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import Foundation

protocol RedditAPISessionProtocol {
    func executeDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}
