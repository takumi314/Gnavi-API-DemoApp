//
//  GnaviResults.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/18.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation

struct GnaviResults {
    var rests: [Restraunt] = []
    var page: Int = 0
    var pageOffset: Int = 0
    var count: Int = 0
}


extension GnaviResults {

    func organizer(_ data: Any) -> GnaviResults? {
        guard let objects = data as? [String: Any] else {
            return nil
        }

        var result = GnaviResults()

        for object in objects {
            if object.key.description == "rest" {
                let value = object.value
                result.rests = mapping(by: value)
            }
            if object.key.description == "hit_per_page" {
                let value = object.value as! String
                result.page = Int(value)!
            }
            if object.key.description == "page_offset" {
                let value = object.value as! String
                result.pageOffset = Int(value)!
            }
            if object.key.description == "total_hit_count" {
                let value = object.value as! String
                result.count = Int(value)!
            }
        }
        return result

    }

    private func mapping(by data: Any) -> [Restraunt] {
        guard let objects = data as? [[String: Any]] else {
            return []
        }

        var rests: [Restraunt] = []
        for object in objects {
            var rest = Restraunt()

            if let value = object["budget"] {
                guard let budget = value as? String else {
                    continue
                }
                rest.budget = Int(budget)!
            }
            if let value = object["id"] {
                guard let value = value as? String else {
                    continue
                }
                rest.id = value
            }
            if let value = object["image_url"] as? [String: Any] {
                guard let image1 = value["shop_image1"],
                    let url1 = image1 as? String else {
                    continue
                }
                rest.thumbnailURL = url1
            }
            if let value = object["name"] {
                guard let value = value as? String else {
                    continue
                }
                rest.name = value
            }
            if let value = object["address"] {
                guard let value = value as? String else {
                    continue
                }
                rest.address = value
            }
            if let value = object["access"] as? [String: Any] {
                guard let value1 = value["station"],
                    let station = value1 as? String else {
                    continue
                }
                rest.station = station
                guard let value2 = value["walk"],
                    let walk = value2 as? String else {
                    continue
                }
                rest.walk = walk
            }
            rests.append(rest)
        }

        return rests
    }
}
