//
//  Post.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import Foundation

protocol PostType {
    
    var total: Int { get }
    var total_pages: Int { get }
    
    var results: [PostItem] { get }
}


extension Post: PostType {
  
}
