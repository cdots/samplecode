//
//  APIEndPoint.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import Foundation


enum APIEndPoint: APIConfiguration {
    
    case posts(searchQuery: String)
    
    var path: String {
        switch self {
        case .posts:
            return "/search/photos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .posts:
            return .GET
        }
    }
    
    var queryParam: [URLQueryItem]? {
        switch self {
        case .posts(let searchQuery):
            return [URLQueryItem.init(name: Constants.APIParameterKey.client_id, value: Constants.CLIENT_KEY),
                    URLQueryItem.init(name: Constants.APIParameterKey.orientation, value: Constants.Orientation.PORTRAIT.rawValue),
                    URLQueryItem.init(name: Constants.APIParameterKey.per_page, value: String(Constants.PAGE)),
                    URLQueryItem.init(name: Constants.APIParameterKey.query, value: searchQuery)
                
            ]
        }
    }
    
    func asURLRequest() -> URLRequest? {
        guard var urlComponent = URLComponents(string: Constants.Server.basePath) else {
            return nil
        }
        if let queryParams = queryParam {
            urlComponent.queryItems = queryParams
        }
        urlComponent.path = path
        guard let url = urlComponent.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HTTPHeaderKey.acceptType.rawValue)
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HTTPHeaderKey.contentType.rawValue)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
