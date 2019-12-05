//
//  APIConfiguration.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import Foundation

protocol URLRequestConvertible {
    func asURLRequest() -> URLRequest?
}

enum HTTPMethod: String {
    case GET
    case POST
}

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var queryParam: [URLQueryItem]? { get }
}
