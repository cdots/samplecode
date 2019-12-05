//
//  PhotoCollectionViewModel.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import UIKit

protocol PostTableViewModelCoordinatorDelegate: class {
    func gotoPhotoDetail(post: PostItem) -> Void
}

final class PhotoCollectionViewModel {
    private let apiClient: APIClientType
    private var posts: [PostItem] = []
    private var postLoadCompletionHandler: PhotosLoadCompletion?
    weak var delegate: PhotoCollectionViewModelDelegate?
    weak var coordinatorDelegate: PostTableViewModelCoordinatorDelegate?
    
    init(apiClient: APIClientType) {
        self.apiClient = apiClient
    }
    
    private func refresh() {
        DispatchQueue.main.async {
            [weak self] in
            if let strongSelf = self {
                strongSelf.postLoadCompletionHandler?()
                self?.handleError()
            }
        }
    }
}

//MARL:- PostTableViewModelType
extension PhotoCollectionViewModel: GalleryCollectionViewModelType {
    func loadPosts(searchQuery: String, _ completionHandler: @escaping PhotosLoadCompletion) {
        postLoadCompletionHandler = completionHandler
        self.makePostRequest(searchQuery: searchQuery)
        return
    }
    
    func numberOfPosts() -> Int {
        return self.posts.count
    }
    
    func postAt(index: Int) -> PhotoViewModelType {
        return PhotoViewModel.init(post: self.posts[index])
    }
    
    func didSelectAt(index: Int) {
        coordinatorDelegate?.gotoPhotoDetail(post: self.posts[index])
    }
    
}

//MARK:- Network
extension PhotoCollectionViewModel {
    private func makePostRequest(searchQuery: String) {
        makePostRequest(searchQuery: searchQuery) { [weak self] (posts) in
            if let posts = posts {
                self?.posts = posts.results
            }
            self?.refresh()
        }
    }
    
    private func makePostRequest(searchQuery:String, _ completion: @escaping (PostType?) -> Void) {
        apiClient.postRequest(searchQuery: searchQuery) { result in
            switch result {
            case .success(let posts):
                completion(posts)
            case .error(_):
                completion(nil)
            }
        }
    }
}

//MARK:- Error handling
extension PhotoCollectionViewModel {
    private func handleError() {
        guard self.posts.count == 0 else {
            self.delegate?.hideError()
            return
        }
        let reach = Reach()
        if reach.isConnected() {
            showNoPostsState()
        } else {
            showOfflineState()
        }
    }
    
    private func showOfflineState() {
        self.delegate?.showError(image: UIImage(named: "noInternet"),
                                 message: "You are not connected to internet")
    }
    
    private func showNoPostsState() {
        self.delegate?.showError(image: UIImage(named: "noPosts"),
                                 message: "There are no posts for you")
    }
}
