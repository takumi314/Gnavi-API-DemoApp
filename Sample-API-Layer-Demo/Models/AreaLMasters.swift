//
//  AreaLMasters.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/23.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import Himotoki

struct AreaLMasters {

    static func organizer(_ object: Any) -> [Prefacture] {
        guard let objects = object as? [String: Any],
            let first = objects.first?.value,
            let prefs = first as? [[String: Any]] else {
                return []
        }
        return mapping(with: prefs)
    }

    private static func mapping(with prefactures: [[String: Any]]) -> [Prefacture] {
        return prefactures
                .flatMap {
                    return try? Prefacture.decodeValue($0)
                }
    }

}

struct Prefacture {
    let areaCode: String
    let prefCode: String
    let prefName: String
}

extension Prefacture: Decodable {
    static func decode(_ e: Extractor) throws -> Prefacture {
        return try Prefacture(
            // パースされた順に並べる
            areaCode: e.value("area_code"),
            prefCode: e.value("pref_code"),
            prefName: e.value("pref_name")
        )
    }
}

struct AreaLarge {
    let areaCodeL: String
    let areaNameL: String
    let prefs: [Prefacture]
}

extension AreaLarge: Decodable {
    static func decode(_ e: Extractor) throws -> AreaLarge {
        return try AreaLarge(
            areaCodeL: e.value(["garea_large", ""]),
            areaNameL: e.value(["garea_large", "areaname_l"]),
            prefs: e.array(["garea_large", "pref"])
        )
    }
}
