//
//  RedditPostsListCell.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import UIKit

class RedditPostsListCell: UITableViewCell, RedditReusable {
    // MARK: - Properties

    /// The container view holds all the elements present in the cell.
    let containerView: UIStackView = {
        let view = UIStackView.makeAutoLayoutView()
        view.backgroundColor = UIColor.RedditPostsListColor.postsListCellContainerViewBgColor
        view.alignment = .fill
        view.axis = .vertical
        return view
    }()
    
    ///  Widget view which holds scores & comments number
    let postWidgetView: RedditPostsWidget = {
        let view = RedditPostsWidget(score: nil, numComment: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel.makeAutoLayoutView().setProperties(color: UIColor.RedditPostsListColor.postsListCellTitleColor,
                                                               font: UIFont.boldSystemFont(ofSize: 16),
                                                               lines: 0,
                                                               alignment: .left)
        return label
    }()

    let postImageView: RedditImageView = {
        let imageView = RedditImageView.makeAutoLayoutView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView.makeAutoLayoutView()
        spinner.style = .medium
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    /**
     We manipulate the dynamic height of the image through activating and deactivating the constraint.
     */
    private var heightConstraint: NSLayoutConstraint?
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Configuration
    
    func configure(with viewModel: RedditPostsListCellRepresentable?) {
        
        guard let post = viewModel else { return }
        
        titleLabel.text = post.title
        postWidgetView.scoreLabel.text = post.score
        postWidgetView.numCommentLabel.text = post.numComment
        
        /// Calculate height of imageview with respect to aspect ratio
        let imgViewHeight = self.bounds.width * CGFloat(post.imgAspectRatio)
        heightConstraint?.constant = imgViewHeight
        activityIndicator.startAnimating()
        
        postImageView.cacheImage(urlString: post.thumbnail,
                                 completion: { [weak self] in self?.activityIndicator.stopAnimating() })
    }
}

// View layoutting methods are grouped here.
private extension RedditPostsListCell {
    func setupContentView() {
        contentView.backgroundColor = UIColor.RedditPostsListColor.postsListCellContentBgColor
        setupContainer()
        setupTitleView()
        setupPostImageView()
        setupPostWidgetView()
    }

    func setupContainer() {
        contentView.addSubview(containerView)
        let viewInfo = ["containerView": containerView]
        NSLayoutConstraint.activate(
            [
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[containerView]-(10)-|",
                                               options: [],
                                               metrics: nil,
                                               views: viewInfo),
                NSLayoutConstraint.constraints(withVisualFormat: "H:|[containerView]|",
                                               options: [],
                                               metrics: nil,
                                               views: viewInfo)
            ]
            .flatMap { $0 }
        )
    }

    func setupTitleView() {
        let titleStackView = UIStackView()
        titleStackView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        titleStackView.isLayoutMarginsRelativeArrangement = true
        titleStackView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(titleStackView)
    }

    func setupPostImageView() {
        containerView.addArrangedSubview(postImageView)
        // Ignore the "150" height value this acts as a seed value and would be replaced by the api's aspect ratio.
        heightConstraint = NSLayoutConstraint(item: postImageView,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .notAnAttribute,
                                              multiplier: 1,
                                              constant: 150)
        heightConstraint?.isActive = true
        // 999 is an aribitary priority to avoid breakages in constraints when the cell is not having any height.
        // This would happen in the initial setup where the cell is about to be added to the tableview.
        heightConstraint?.priority = UILayoutPriority(rawValue: 999)
    }
    
    func setupPostWidgetView() {
        containerView.addArrangedSubview(postWidgetView)
        postWidgetView.addSubview(activityIndicator)
        postWidgetView.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor).isActive = true
        postWidgetView.centerYAnchor.constraint(equalTo: activityIndicator.centerYAnchor).isActive = true
    }
}
