//
//  RedditPostsChildData.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

struct RedditPostsChildData: Decodable {
    let title: String
    let score: Int
    let numComments: Int
    let thumbnail: String
    let thumbnailWidth: Int?
    let thumbnailHeight: Int?
    
    enum CodingKeys: String, CodingKey {
        case title, score
        case numComments = "num_comments"
        case thumbnail = "thumbnail"
        case thumbnailWidth = "thumbnail_width"
        case thumbnailHeight = "thumbnail_height"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        score = try values.decode(Int.self, forKey: .score)
        numComments = try values.decode(Int.self, forKey: .numComments)
        thumbnail = try values.decode(String.self, forKey: .thumbnail)
        thumbnailWidth = try values.decodeIfPresent(Int.self, forKey: .thumbnailWidth) /// Handles Null value
        thumbnailHeight = try values.decodeIfPresent(Int.self, forKey: .thumbnailHeight) /// Handles Null value
    }
}
