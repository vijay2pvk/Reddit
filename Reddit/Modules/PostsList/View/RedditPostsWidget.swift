//
//  RedditPostsWidget.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import UIKit

class RedditPostsWidget: UIView {
    // MARK: - Properties
    
    var scoreLabel: UILabel!
    var numCommentLabel: UILabel!
    
    private var scoreImgView: UIImageView!
    private var numCommentImgView: UIImageView!
    
    // MARK: - Initializers

    init(score: String, numComment: String) {
        super.init(frame: CGRect.zero)
        
        scoreLabel = setupLabel(value: score)
        numCommentLabel = setupLabel(value: numComment)
        scoreImgView = setupImageView(iconName: "upDownIcon")
        numCommentImgView = setupImageView(iconName: "commentIcon")
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Setup

    private func setupLabel(value: String) -> UILabel {
        let label = UILabel.makeAutoLayoutView()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = value
        label.textColor = UIColor.RedditColor.postsListCellWidgetTextColor
        label.numberOfLines = 1
        label.sizeToFit()
        label.textAlignment = .left

        addSubview(label)
        return label
    }
    
    private func setupImageView(iconName: String) -> UIImageView {
        let imgView = UIImageView.makeAutoLayoutView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: iconName)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imgView)
        return imgView
    }
    
    private func setupConstraints() {
        guard let scoreLabel = self.scoreLabel, let numCommentLabel = self.numCommentLabel,
              let scoreImgView = self.scoreImgView, let numCommentImgView = self.numCommentImgView else {
            return
        }
        
        let viewInfo = [ "scoreLabel": scoreLabel,
                         "numCommentLabel": numCommentLabel,
                         "scoreImgView": scoreImgView,
                         "numCommentImgView": numCommentImgView
                       ]
        /// Vertical constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scoreImgView]|",
                                                      options: .alignAllCenterY,
                                                      metrics: nil,
                                                      views: viewInfo))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[numCommentImgView]|",
                                                      options: .alignAllCenterY,
                                                      metrics: nil,
                                                      views: viewInfo))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scoreLabel]|",
                                                      options: .alignAllCenterY,
                                                      metrics: nil,
                                                      views: viewInfo))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[numCommentLabel]|",
                                                      options: .alignAllCenterY,
                                                      metrics: nil,
                                                      views: viewInfo))
        /// Horizontal constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(16)-[scoreImgView(24)]-[scoreLabel(50)]",
                                                      options: [],
                                                      metrics: nil,
                                                      views: viewInfo))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[numCommentImgView(24)]-[numCommentLabel(50)]-(16)-|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: viewInfo))
    }
}
