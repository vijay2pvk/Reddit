//
//  RedditViewExtension.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import UIKit

extension UIView {
    static func makeAutoLayoutView() -> Self {
        let view =  Self.init(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
