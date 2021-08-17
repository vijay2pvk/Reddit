//
//  RedditPostsData.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

struct RedditPostsData: Decodable {
    let after: String?
    let posts: [RedditPostsChild]

    enum CodingKeys: String, CodingKey {
        case after
        case posts = "children"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        after = try values.decodeIfPresent(String.self, forKey: .after)
        posts = try values.decode([RedditPostsChild].self, forKey: .posts)
    }
}
