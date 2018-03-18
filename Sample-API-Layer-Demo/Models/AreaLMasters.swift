//
//  AreaLMasters.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/23.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation

struct AreaLMasters: Codable {
    let prefs: [Prefacture]

    enum Key: String, CodingKey {
        case pref = "pref"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.prefs = try container.decode([Prefacture].self, forKey: .pref)
    }

    static func organizer(_ object: Data) -> [Prefacture] {
        return try! JSONDecoder().decode([Prefacture].self, from: object)
    }

}

struct Prefacture: Codable {
    let areaCode: String
    let prefCode: String
    let prefName: String

    enum Key: String, CodingKey {
        case areaCode = "area_code"
        case prefCode = "pref_code"
        case prefName = "pref_name"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.areaCode = try container.decode(String.self, forKey: .areaCode)
        self.prefCode = try container.decode(String.self, forKey: .prefCode)
        self.prefName = try container.decode(String.self, forKey: .prefName)
    }
}


struct AreaLarge: Codable {
    let areaCodeL: String
    let areaNameL: String
    let prefs: [Prefacture]

    enum Key: String, CodingKey {
        case areaCodeL = "garea_large"
        case areaNameL = "areaname_l"
        case prefs = "pref"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)

        self.areaCodeL  = try container.decode(String.self, forKey: .areaCodeL)
        self.areaNameL  = try container.decode(String.self, forKey: .areaNameL)
        self.prefs      = try container.decode([Prefacture].self, forKey: .prefs)
    }
}
