//
//  RedditPostsListVC.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import UIKit

class RedditPostsListVC: UIViewController, RedditAlertPresentable {
    // MARK: - Properties
    
    private var activityIndicator: RedditActivityIndicator?
    private var viewModel: RedditPostsListRepresentable = RedditPostsListVM()
    
    var tableView: UITableView = {
        let tableView = UITableView.makeAutoLayoutView()
        tableView.register(cellType: RedditPostsListCell.self)
        tableView.backgroundColor = UIColor.RedditPostsListColor.postsListTableBgColor
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    // MARK: - Setup
    
    private func initialSetup() {
        activityIndicator = RedditActivityIndicator(view: self.view)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.RedditColor.navigationBarTitleColor]
        self.view.backgroundColor = UIColor.RedditPostsListColor.postsListViewBackgroundColor
        self.title = localizedString(forKey: "postsListVC_Title")
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.RedditPostsListColor.postsListTableBgColor
        tableView.separatorStyle = .none
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    // MARK: - API Request
    
    @objc
    private func fetchData() {
        self.activityIndicator?.showActivityIndicator()
        
        viewModel.fetchPostsList {[weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.activityIndicator?.stopActivityIndicator()
            
            switch result {
            case .failure(let error):
                strongSelf.showAlert(title: "Error", message: error.localizedDescription)
            case .success:
                strongSelf.tableView.reloadData()
            }
        }
    }
}

// MARK: - Extensions

extension RedditPostsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ///  Create a CellVM & inject to configure method
        let cell: RedditPostsListCell = tableView.dequeueReusableCell(for: indexPath)
        let cellViewModel = self.viewModel.viewModelForItem(at: indexPath)
        
        cell.configure(with: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.postsCount()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /// Fetch more data
        if self.viewModel.fetchMorePostsList(indexPath: indexPath) {
            self.fetchData()
        }
    }
}

