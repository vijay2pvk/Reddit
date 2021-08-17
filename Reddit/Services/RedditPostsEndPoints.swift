//
//  RedditPostsEndPoints.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import Foundation

/// All HTTP mmethods
enum RedditHTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    
    var type: String {
        return self.rawValue
    }
}

/// Base EndPointType
protocol RedditEndPointType {
    var baseURLString: String { get }
    var path: String { get }
    var contentType: String { get }
    var httpMethod: RedditHTTPMethod { get }
    var parameters: [String: Any]? { get }
}

extension RedditEndPointType {
    /// Protocol optionals definition
    var contentType: String {
        return "application/json"
    }
    
    var finalURL: URL? {
        return URL(string: baseURLString + path)
    }
}

/// EndPoints definition
enum RedditPostsEndPoints: RedditEndPointType {
    
    case getPosts(after: String?)
    
    var baseURLString: String {
        return "http://www.reddit.com"
    }
    
    var path: String {
        switch self {
        case .getPosts(let link):
            if let afterLink = link {
                return "/.json?after=\(afterLink)"
            }
            return "/.json"
        }
    }
    
    var httpMethod: RedditHTTPMethod {
        var methodType: RedditHTTPMethod
        
        switch self {
        case .getPosts(_):
            methodType = .get
        }
        return methodType
    }
    
    var parameters: [String : Any]? {
        switch self {
        default:
            return nil
        }
    }
}
