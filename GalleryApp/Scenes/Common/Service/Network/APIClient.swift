//
//  APIClient.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import Foundation

final class APIClient {
    private let session = URLSession(configuration: .default)
    private let networkQueue = DispatchQueue(label: "com.queue.network")
    private let reach = Reach()
    private func performRequest<T:Codable>(_ urlRequest: URLRequestConvertible,
                                           completionHandler: @escaping (Result<T>) -> Void) {
        
        guard reach.isConnected() == true else {
            completionHandler(Result.error("No Internet"))
            return
        }
        networkQueue.async {
            guard let urlRequest = urlRequest.asURLRequest() else {
                completionHandler(.error("Malformed URL"))
                return
            }
            
            self.session.dataTask(with: urlRequest) { data, response, error in
                switch (data, response, error) {
                case let (_, _, error?):
                    completionHandler(.error(error.localizedDescription))
                case let (data?, response?, nil):
                    if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        self.decode(data, completionHandler: completionHandler)
                    } else {
                        completionHandler(.error("Something went wrong"))
                    }
                default:
                    preconditionFailure("expected either Data and URLResponse, or Error")
                }
                }.resume()
        }
    }
    
}

//MARK:- Decode
extension APIClient {
    private func decode<T: Codable>(_ data: Data, completionHandler: @escaping (Result<T>) -> Void) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completionHandler(.success(result))
        } catch {
            completionHandler(.error(error.localizedDescription))
        }
    }
}

//MARK:- APIClientType conformance
extension APIClient: APIClientType {
    func postRequest(searchQuery: String, _ completionHandler: @escaping (Result<Post>) -> Void) {
        performRequest(APIEndPoint.posts(searchQuery: searchQuery), completionHandler: completionHandler)
    }
}
