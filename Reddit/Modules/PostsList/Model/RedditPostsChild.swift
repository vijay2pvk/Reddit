//
//  RedditPostsChild.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

struct RedditPostsChild: Decodable {
    let data: RedditPostsChildData
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decode(RedditPostsChildData.self, forKey: .data)
    }
}
