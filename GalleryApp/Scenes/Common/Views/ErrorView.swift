//
//  ErrorView.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import UIKit

final class ErrorView: UIView {
    private let messageLabel = UILabel()
    private let imageView = UIImageView()
    private var aspectRatioConstraint: NSLayoutConstraint?
    var image: UIImage? {
        didSet {
            imageView.image = image
            setNeedsUpdateConstraints()
        }
    }
    var message: String? {
        didSet {
            messageLabel.text = message
        }
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        setup()
        setupConstrints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        updateAspectRatioConstraint()
    }
}

//MARK:- Layout
extension ErrorView {
    private func setup() {
        imageView.contentMode = .scaleAspectFit
        messageLabel.font = UIFont.boldSystemFont(ofSize: 18)
        messageLabel.textColor = UIColor.lightGray
        addSubview(imageView)
        addSubview(messageLabel)
    }
    
    private func setupConstrints() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let messageCenterX = messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        let messageCenterY = messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        let imageViewBottom = imageView.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -20)
        let imageViewCenterX = imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        let imageViewHeight = imageView.heightAnchor.constraint(equalToConstant: 200)
        NSLayoutConstraint.activate([messageCenterX, messageCenterY, imageViewBottom, imageViewCenterX, imageViewHeight])
    }
    
    private func updateAspectRatioConstraint() {
        var aspectRatio: CGFloat = 1
        if let image = image {
            aspectRatio = image.size.width/image.size.height
        }
        aspectRatioConstraint?.isActive = false
        aspectRatioConstraint = imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: aspectRatio)
        aspectRatioConstraint?.isActive = true
    }
}
