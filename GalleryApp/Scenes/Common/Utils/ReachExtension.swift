//
//  ReachExtension.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import Foundation

extension Reach {
    public func isConnected() -> Bool {
        let status = self.connectionStatus()
        var isConnected = false
        switch status {
        case .online(_):
            isConnected = true
        default:
            isConnected = false
        }
        return isConnected
    }
}
