//
//  Restraunt.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/17.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import Himotoki

protocol JSONMappable {
    associatedtype ModelType
    func mapping(at object: Any, URLResponse: HTTPURLResponse?) throws -> ModelType?
}


struct Restraunt {
    var budget: Int = 0
    var id: String = ""
    var thumbnailURL: String = ""
    var name: String = ""
    var adress: String = ""
    var station: String = ""
    var walk: Int = 0
    var tel: String = ""
}

extension Restraunt: Decodable {

    static func decode(_ e: Extractor) throws -> Restraunt {
        return try Restraunt(
            budget: e <| "budget",
            id: e <| "id",
            thumbnailURL: e <| ["image_url", "shop_image1"],
            name: e <| "name",
            adress: e <| "address",
            station: e <| ["access", "station"],
            walk: e <| ["access", "walk"],
            tel: e <| "tel"
        )
    }

}

extension Restraunt {

    static func organizer(_ object: Any) -> [Restraunt] {
        guard let objects = object as? [String: Any],
            let first = objects.first?.value,
            let rests = first as? [[String: Any]] else {
                return []
        }
        return mapping(with: rests)
    }

    private static func mapping(with restraunts: [[String: Any]]) -> [Restraunt] {
        return restraunts.flatMap {
                return try? Restraunt.decodeValue($0)
        }
    }

}


