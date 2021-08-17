//
//  RedditActivityIndicator.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import UIKit

struct RedditActivityIndicator {
    
    let viewForActivityIndicator = UIView()
    let view: UIView
    let activityIndicatorView = UIActivityIndicatorView()
    let loadingTextLabel = UILabel()
    let loadingFontSize: CGFloat = 17.0
    
    init(view: UIView) {
        self.view = view
    }
    
    func showActivityIndicator(with text: String? = nil) {
        viewForActivityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        viewForActivityIndicator.backgroundColor = UIColor.RedditColor.activityIndicatorBgColor
        viewForActivityIndicator.alpha = 0.8
        view.addSubview(viewForActivityIndicator)
        
        activityIndicatorView.center = CGPoint(x: self.view.frame.size.width / 2.0, y: self.view.frame.size.height / 2.0)
        
        loadingTextLabel.textColor = UIColor.RedditColor.loadingLabelColor
        loadingTextLabel.text = text ?? localizedString(forKey: "activityIndicator_Text")
        loadingTextLabel.font = UIFont(name: "AvenirNextCondensed-DemiBoldItalic", size: loadingFontSize)
        loadingTextLabel.sizeToFit()
        loadingTextLabel.center = CGPoint(x: activityIndicatorView.center.x, y: activityIndicatorView.center.y + 30)
        viewForActivityIndicator.addSubview(loadingTextLabel)
        
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.style = .large
        activityIndicatorView.color = UIColor.RedditColor.activityIndicatorColor
        viewForActivityIndicator.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    func stopActivityIndicator() {
        viewForActivityIndicator.removeFromSuperview()
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
    }
}
