//
//  PostType.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    let total: Int
    let total_pages: Int
    
    let results: [PostItem]
}

struct PostItem: Codable {
    let id: String
    let description: String?
    let urls: Url
}

struct Url: Codable {
    let small: String
    let regular: String
}
