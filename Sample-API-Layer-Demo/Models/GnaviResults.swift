//
//  GnaviResults.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/18.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation

struct GnaviResults: Codable {
    var rests: [Restraunt] = []
    var page: Int = 0
    var pageOffset: Int = 0
    var count: Int = 0

    enum Key: String, CodingKey {
        case rests = "rest"
        case page = "hit_per_page"
        case pageOffset = "page_offset"
        case count = "total_hit_count"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)

        self.rests      = try container.decode([Restraunt].self, forKey: .rests)
        let page = try container.decode(String.self, forKey: .page)
        self.page = Int(page)!
        let pageOffset = try container.decode(String.self, forKey: .pageOffset)
        self.pageOffset = Int(pageOffset)!
        let count = try container.decode(String.self, forKey: .count)
        self.count = Int(count)!
    }
}

