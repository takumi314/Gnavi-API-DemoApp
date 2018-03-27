//
//  Database.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2018/03/22.
//  Copyright © 2018年 Kohey. All rights reserved.
//

import Foundation

typealias Database = ReadableDatabase & WritableDatabase

protocol ReadableDatabase {
    typealias Query = ((Model) -> Bool)
    associatedtype Model
    func loadAllObjects() -> [Model]
    func loadObjects(matching query: Query) -> [Model]
    func loadObject(withID id: String) -> Model?
}

extension ReadableDatabase {
}

protocol WritableDatabase {
    associatedtype Model
    func save(_ object: Model) -> Bool
    func update(_ object: Model) -> Bool
    func delete(withID id: String) -> Bool
}
