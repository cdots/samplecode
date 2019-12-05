//
//  Constants.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import Foundation

enum Constants {
    static let CLIENT_KEY = "cbc37acddf6ea66fe539aa4cb270a95b03fb0ef4948e23f32d1a98d4908c9480"
    static let PAGE = 30
}

extension Constants {
    enum Orientation: String {
        case PORTRAIT = "portrait"
        case LANDSCAPE = "landscape"
        case SQUARISH = "squarish"
    }
}

//MARK:- Network constants
extension Constants {
    enum APIParameterKey {
//        static let postId = "postId"
        static let client_id = "client_id"
        static let orientation = "orientation"
        static let per_page = "per_page"
        static let query = "query"
        static let page = "page"
        
    }
    
    enum HTTPHeaderKey: String {
        case acceptType = "Accept"
        case contentType = "Content-Type"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
}

//MARK:- Base url
extension Constants {
    enum Server {
        static let basePath = "https://api.unsplash.com/"
    }
}
