//
//  RedditStringExtension.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import Foundation

func localizedString(forKey key: String) -> String {
    var result = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
    
    if result == key {
        result = Bundle.main.localizedString(forKey: key, value: nil, table: "Default")
    }
    
    return result
}
