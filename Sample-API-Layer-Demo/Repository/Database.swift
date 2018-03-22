//
//  Database.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2018/03/22.
//  Copyright © 2018年 Kohey. All rights reserved.
//

import Foundation

typealias Database = ReadableDatabase & WritableDatabase
typealias Query = (() -> Bool)

protocol Model { }

protocol ReadableDatabase {
    func loadAllObjects<T: Model>() -> [T]
    func loadObjects<T: Model>(matching query: Query) -> [T]
    func loadObject<T: Model>(withID id: String) -> T?
}

protocol WritableDatabase {
    func save<T: Model>(_ object: T) -> Bool
    func update<T: Model>(_ object: T) -> Bool
    func delete(withID id: String) -> Bool
}


