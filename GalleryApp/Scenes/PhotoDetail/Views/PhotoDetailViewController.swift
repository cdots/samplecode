//
//  PhotoDetailViewController.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/16/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var imageViewPhoto: UIImageView!
    
    var viewModel: PhotoDetailViewModelType?
    var externalWindow: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.loadPhoto({ (post) in
                self.imageViewPhoto.sd_setImage(with: URL(string: post.urls.regular), placeholderImage: nil, options: SDWebImageOptions.progressiveDownload, completed: nil)
        })
        
        setupUI()
    }

    func setupUI() {
        let rightButtonItem = UIBarButtonItem.init(
            title: ". . .",
            style: .done,
            target: self,
            action: #selector(externalDisplayOptions)
        )
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func externalDisplayOptions() {
        showActionSheet()
    }
    }
//#MARK: Actionsheet

extension PhotoDetailViewController {
    
    func showActionSheet()  {
        let alert = UIAlertController(title: "Select Your External Device", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        }
        let externalDisplay = UIAlertAction(title: "External Display", style: UIAlertActionStyle.default) { (okSelected) -> Void in
            if UIScreen.screens.count > 1 {
                self.setupExternalScreen(UIScreen.screens[1])
            }
        }
        
        let chromeCast = UIAlertAction(title: "Chrome Cast", style: UIAlertActionStyle.default) { (okSelected) -> Void in
            if UIScreen.screens.count > 1 {
                self.setupExternalScreen(UIScreen.screens[1])
            }
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (cancelSelected) -> Void in
        }
        
        alert.addAction(externalDisplay)
        alert.addAction(chromeCast)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true, completion: nil)
        
    }
}

//#MARK: External Display
extension PhotoDetailViewController {
    
    fileprivate func setupExternalScreen(_ screen: UIScreen) {
    let sb = UIStoryboard(name: "Airplay" , bundle: nil)
    guard externalWindow == nil,
        let vc = sb.instantiateViewController(withIdentifier: "Airplay") as? AirplayViewController else {
            return
    }
    vc.image = self.imageViewPhoto.image!
    externalWindow = UIWindow(frame: screen.bounds)
    externalWindow!.rootViewController = vc
    externalWindow!.screen = screen
    externalWindow!.isHidden = false
}

fileprivate func teardownExternalScreen() {
    guard let ew = externalWindow else { return }
    
    ew.isHidden = true
    externalWindow = nil
}

@objc func externalScreenDidConnect(_ notification: Notification) {
    guard let screen = notification.object as? UIScreen else {
        return
    }
    
    setupExternalScreen(screen)
}

@objc func externalScreenDidDisconnect(_ notification: Notification) {
    guard let _ = notification.object as? UIScreen else {
        return
    }
    teardownExternalScreen()
}

fileprivate func setupScreenNotifications() {
    let center = NotificationCenter.default
    
    center.addObserver(self, selector: #selector(PhotoDetailViewController.externalScreenDidConnect(_:)), name: NSNotification.Name.UIScreenDidConnect, object: nil)
    center.addObserver(self, selector: #selector(PhotoDetailViewController.externalScreenDidDisconnect(_:)), name: NSNotification.Name.UIScreenDidDisconnect, object: nil)
    }
}


