//
//  PhotoCollectionViewModelDelegate.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import UIKit

protocol PhotoCollectionViewModelDelegate: class {
    func showError(image: UIImage?, message: String) -> Void
    func hideError() -> Void
}
