//
//  AppCoordinator.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow?
    
    private lazy var apiClient: APIClientType = {
        return APIClient()
    }()

    init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() {
        
        guard let window = window else {
            return
        }
        let navigationController = UINavigationController()
        let postCoordinator = GalleryCoordinator(navigationController: navigationController, apiClient: apiClient)
        addChildCoordinator(postCoordinator)
        window.rootViewController = navigationController
        postCoordinator.start()
        window.makeKeyAndVisible()
    }
    override func finish() {
        //Emoty implementaion
    }
}
