//
//  RedditIntExtension.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 26/08/21.
//

import Foundation

extension Int {
    // Convert's 1000's into a friendly K's & M's
    func formatUsingAbbrevation () -> String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}
