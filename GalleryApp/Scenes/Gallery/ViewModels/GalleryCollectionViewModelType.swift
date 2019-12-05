//
//  GalleryCollectionViewModelType.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import Foundation

typealias PhotosLoadCompletion = () -> Void
protocol GalleryCollectionViewModelType {
    func loadPosts(searchQuery:String, _ completionHandler: @escaping PhotosLoadCompletion) -> Void
    func numberOfPosts() -> Int
    func postAt(index: Int) -> PhotoViewModelType
    func didSelectAt(index: Int) -> Void
}
