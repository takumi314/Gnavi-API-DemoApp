//
//  AreaSearchStatus.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/23.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation

enum AreaSearchStatus {
    case none
    case normal(AreaLarge)
    case noData
    case error(Error)
}

protocol AreaSearchLoadable {
    func setResult(result: AreaSearchStatus)
}
