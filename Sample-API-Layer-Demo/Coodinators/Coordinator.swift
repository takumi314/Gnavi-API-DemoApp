//
//  Coordinator.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2018/03/28.
//  Copyright © 2018年 Kohey. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    func run()
    func start(with option: DeepLinkOption?)
}

extension Coordinator { }

struct DeepLinkURLConstants {
    static let Onboarding = "onboarding"
    static let Items = "items"
    static let Item = "item"
    static let Settings = "settings"
}

enum DeepLinkOption {
    case onboarding
    case items
    case settings
    case item(String?)

    static func build(with id: String, params: [String : AnyObject]?) -> DeepLinkOption? {
        let itemID = params?["item_id"] as? String
        switch id {
        case DeepLinkURLConstants.Onboarding:
            return .onboarding
        case DeepLinkURLConstants.Items:
            return .items
        case DeepLinkURLConstants.Item:
            return .item(itemID)
        case DeepLinkURLConstants.Settings:
            return .settings
        default:
            return nil
        }
    }
}
