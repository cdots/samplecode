//
//  PhotoViewModel.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import Foundation

struct PhotoViewModel {
    let post: PostItem
}

extension PhotoViewModel: PhotoViewModelType {
    var title: String {
        if let description = post.description {
            return description
        } else {
            return ""
        }
    }
    
    var image: String {
        return post.urls.small
        
//         if let description = post.description {
//                return description
//         } else {
//            return ""
//        }
    }
    
    
}
