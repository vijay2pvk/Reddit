//
//  RedditPostsWidget.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import UIKit

class RedditPostsWidget: UIView {
    // MARK: - Properties
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel.makeAutoLayoutView().setProperties(color: UIColor.RedditPostsListColor.postsListCellWidgetTextColor,
                                                               font: UIFont.boldSystemFont(ofSize: 12),
                                                               lines: 1,
                                                               alignment: .left)
        addSubview(label)
        return label
    }()
    
    lazy var numCommentLabel: UILabel = {
        let label = UILabel.makeAutoLayoutView().setProperties(color: UIColor.RedditPostsListColor.postsListCellWidgetTextColor,
                                                               font: UIFont.boldSystemFont(ofSize: 12),
                                                               lines: 1,
                                                               alignment: .left)
        addSubview(label)
        return label
    }()
    
    private lazy var scoreImgView: UIImageView = {
        let imgView = UIImageView.makeAutoLayoutView().setProperties(imageName: "upDownIcon", mode: .scaleAspectFit)
        addSubview(imgView)
        return imgView
    }()
    
    private lazy var numCommentImgView: UIImageView = {
        let imgView = UIImageView.makeAutoLayoutView().setProperties(imageName: "commentIcon", mode: .scaleAspectFit)
        addSubview(imgView)
        return imgView
    }()
    
    // MARK: - Initializers

    init(score: String? = nil, numComment: String? = nil) {
        super.init(frame: CGRect.zero)
        
        scoreLabel.text = score
        numCommentLabel.text = numComment
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Setup
    
    private func setupConstraints() {
        
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
