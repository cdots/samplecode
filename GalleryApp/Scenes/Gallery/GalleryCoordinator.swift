//
//  PhotListCoordinator.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import UIKit

final class GalleryCoordinator: Coordinator {
    private static let storyboardName = "Gallery"
    private let apiClient: APIClientType
    private let navigationController: UINavigationController
    private let storyBoard = UIStoryboard(name: storyboardName,
                                          bundle: nil)
    
    private lazy var rootViewController: GalleryViewController = {
        return storyBoard.instantiateInitialViewController() as! GalleryViewController
    }()
    
    private lazy var viewModel: GalleryCollectionViewModelType =  {
        let viewModel = PhotoCollectionViewModel.init(apiClient: apiClient)
        viewModel.delegate = rootViewController
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    init(navigationController: UINavigationController, apiClient: APIClientType) {
        self.navigationController = navigationController
        self.apiClient = apiClient
    }
    
    override func start() {
        rootViewController.viewModel = viewModel
        navigationController.viewControllers = [rootViewController]
    }
    
    override func finish() {
        //TODO
    }
}

extension GalleryCoordinator: PhotoDetailCoordinatorDelegate {
    func didFinish(_ coordinator: PhotoDetailCoordinator) {
        removeChildCoordinator(coordinator)
    }
}

extension GalleryCoordinator: PostTableViewModelCoordinatorDelegate {
    func gotoPhotoDetail(post: PostItem) {
        let commentsCoordinator = PhotoDetailCoordinator(from: navigationController, post: post)
        commentsCoordinator.delegate = self
        addChildCoordinator(commentsCoordinator)
        commentsCoordinator.start()
    }
}

