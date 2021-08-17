//
//  RedditPostsListVM.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//

import Foundation

protocol RedditPostsListRepresentable {
    var afterLink: String? { get }
    func postsCount() -> Int
    func viewModelForItem(at indexPath: IndexPath) -> RedditPostsListCellVM?
    func fetchPostsList(completion: @escaping (Result<Void, Error>) -> Void)
}

class RedditPostsListVM: RedditPostsListRepresentable {
    // MARK:- Properties
    
    var service: RedditPostsServicesRequestType = RedditPostsServices(apiClient: RedditAPIClient.shared)
    private var postsList = [RedditPostsChildData]()
    var afterLink: String?

    // MARK: - Functions
    
    func postsCount() -> Int {
        return postsList.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> RedditPostsListCellVM?{
        let postsListVM = RedditPostsListCellVM(post: postsList[indexPath.row])
        return postsListVM
    }

    private func transform(_ posts: RedditPosts) {
        self.afterLink = posts.data.after
        posts.data.posts.forEach { (postsChild) in
            postsList.append(postsChild.data)
        }
    }
    
    // MARK: - API Request
    func fetchPostsList(completion: @escaping (Result<Void, Error>) -> Void) {
        self.service.getPosts(afterLink: afterLink) { [weak self] result in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let posts):
                    weakSelf.transform(posts)
                    completion(.success(()))
                }
            }
        }
    }
}

