//
//  RedditPosts.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

struct RedditPosts: Decodable {
    let data: RedditPostsData
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decode(RedditPostsData.self, forKey: .data)
    }
}
