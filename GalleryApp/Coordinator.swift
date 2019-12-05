//
//  Coordinator.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import UIKit

class Coordinator: NSObject {
    private(set) var childCoordinators: [Coordinator] = []
    
    func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }
    
    func finish() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.index(where: {$0 === coordinator}) {
            childCoordinators.remove(at: index)
        }
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
    
    func showViewController(_ viewController: UIViewController,
                            from: UIViewController, animated: Bool) {
        if from is UINavigationController {
            let navViewController = from as! UINavigationController
            navViewController.pushViewController(viewController, animated: animated)
        } else {
            from.present(viewController, animated: animated, completion: nil)
        }
    }
}
