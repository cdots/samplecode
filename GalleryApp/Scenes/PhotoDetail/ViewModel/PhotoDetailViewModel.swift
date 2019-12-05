//
//  PhotoDetailViewModel.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/16/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import UIKit

final class PhotoDetailViewModel {
    let post: PostItem
    private var photoLoadCompletionHandler: PhotoLoadCompletion?
    
    
    init(post: PostItem) {
        self.post = post
    }
    
    private func refresh() {
        DispatchQueue.main.async {
            [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.photoLoadCompletionHandler?((self?.post)!)
        }
    }
}

extension PhotoDetailViewModel: PhotoDetailViewModelType {
    func loadPhoto(_ completionHandler: @escaping PhotoLoadCompletion) {
        photoLoadCompletionHandler = completionHandler
        self.refresh()
    }
    
}

