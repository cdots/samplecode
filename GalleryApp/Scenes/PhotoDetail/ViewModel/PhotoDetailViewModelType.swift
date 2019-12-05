
//
//  CommentListViewModelType.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/16/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import Foundation

typealias PhotoLoadCompletion = (_ post: PostItem) -> Void
protocol PhotoDetailViewModelType {
    func loadPhoto(_ completionHandler: @escaping PhotoLoadCompletion) -> Void
}

