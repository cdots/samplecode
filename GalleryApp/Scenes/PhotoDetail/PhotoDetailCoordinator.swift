//
//  PhotoDetailCoordinator.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/16/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import UIKit

protocol PhotoDetailCoordinatorDelegate: class {
    func didFinish(_ coordinator: PhotoDetailCoordinator) -> Void
}

final class PhotoDetailCoordinator: Coordinator {
    
    private static let storyboardName = "PhotoDetail"
    private let fromViewController: UIViewController
    private let storyBoard = UIStoryboard(name: storyboardName , bundle: nil)
    weak var delegate: PhotoDetailCoordinatorDelegate?
    private var post: PostItem
    
    private lazy var photoDetailViewController: PhotoDetailViewController = {
        return storyBoard.instantiateInitialViewController() as! PhotoDetailViewController
    }()
    
    private lazy var viewModel: PhotoDetailViewModelType = {
        let vm = PhotoDetailViewModel(post: post)
        return vm
    }()
    
    init(from: UIViewController, post: PostItem) {
        fromViewController = from
        self.post = post
    }
    
    override func start() {
        if let navVC = fromViewController as? UINavigationController {
            navVC.delegate = self
        }
        photoDetailViewController.viewModel = viewModel
        showViewController(photoDetailViewController, from: fromViewController, animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(self)
    }
}

//MARK:- UINavigationControllerDelegate
extension PhotoDetailCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController) else {
                return
        }
        
//        if fromViewController is GalleryViewController {
            finish()
//        }
    }
}
