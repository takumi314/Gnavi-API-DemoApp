//
//  NetworkManager.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/16.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Alamofire

protocol Accessable {
    static func isAvailable() -> Bool
}

class NetworkManager: Accessable {

    static func isAvailable() -> Bool {
        guard let manager = NetworkReachabilityManager() else {
            return false
        }
        manager.startListening()
        return manager.isReachable
    }

}
