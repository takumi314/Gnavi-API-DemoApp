//
//  GnaviResults.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/18.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import Himotoki

class GnaviResults {

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

        let result = GnaviResults()
        do {
                for object in objects {
                if object.key.description == "rest" {
                    let value = object.value
                    result.rests = try doMapping(by: value)
                }
                if object.key.description == "hit_per_page" {
                    let value = object.value as! String
                    result.page = try Int(value)!
                }
                if object.key.description == "page_offset" {
                    let value = object.value as! String
                    result.pageOffset = try Int(value)!
                }
                if object.key.description == "total_hit_count" {
                    let value = object.value as! String
                    result.count = try Int(value)!
                }
            }
        } catch {
            print("error")
        }
        return result

    }

    private func doMapping(by data: Any) -> [Restraunt] {
        guard let objects = data as? [[String: Any]] else {
            return []
        }

        var rests: [Restraunt] = []
        for object in objects {
            var rest = Restraunt()

            if let value = object["budget"] {
                guard let value = value as? String else {
                    continue
                }
                rest.budget = Int(value)!
            }
            if let value = object["id"] {
                guard let value = value as? String else {
                    continue
                }
                rest.id = value
            }
            if let value = object["thumbnailURL"] {
                guard let value = value as? String else {
                    continue
                }
                rest.thumbnailURL = value
            }
            if let value = object["name"] {
                guard let value = value as? String else {
                    continue
                }
                rest.name = value
            }
            if let value = object["adress"] {
                guard let value = value as? String else {
                    continue
                }
                rest.adress = value
            }
            if let value = object["station"] {
                guard let value = value as? String else {
                    continue
                }
                rest.station = value
            }
            if let value = object["walk"] {
                guard let value = value as? String else {
                    continue
                }
                rest.walk = Int(value)!
            }
            rests.append(rest)
        }

        return rests
    }
}
