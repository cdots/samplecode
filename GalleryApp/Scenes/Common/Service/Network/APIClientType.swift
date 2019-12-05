//
//  APIClientType.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(String)
}

protocol APIClientType {
    func postRequest(searchQuery:String, _ completionHandler: @escaping (Result<Post>) -> Void) -> Void    
}
