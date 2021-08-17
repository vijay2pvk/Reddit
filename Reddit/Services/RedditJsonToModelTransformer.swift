//
//  RedditJsonToModelTransformer.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import Foundation

///  Converts Json to passed in Model
struct RedditJsonToModelTransformer {
    static func convert<T: Decodable>(data: Data, to modelType: T.Type = T.self) -> Result<T, Error> {
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return .success(model)
        } catch let error {
            return .failure(error)
        }
    }
}
