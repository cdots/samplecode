//
//  AppDelegate.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/14/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator.init(window: window)
        appCoordinator.start()
        return true
    }    
}

