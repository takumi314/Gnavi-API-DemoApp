//
//  Restraunt.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/17.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation

protocol JSONMappable {
    associatedtype ModelType
    func mapping(at object: Any, URLResponse: HTTPURLResponse?) throws -> ModelType?
}


struct Restraunt: Codable {
    var budget: Int = 0
    var id: String = ""
    var thumbnailURL: String = ""
    var name: String = ""
    var address: String = ""
    var station: String = ""
    var walk: String = ""
    var tel: String = ""

    enum Key: String, CodingKey {
        case budget = "budget"
        case id = "id"
        case image = "image_url"
        case name = "name"
        case address = "address"
        case access = "access"
        case walk = "walk"
        case tel = "tel"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)

        let budget         = try container.decode(String.self, forKey: .budget)
        self.budget = Int(budget)!

        self.id             = try container.decode(String.self, forKey: .id)

        let image = try container.decode(ImageURL.self, forKey: .image)
        self.thumbnailURL = image.image1 ?? ""

        self.name           = try container.decode(String.self, forKey: .name)
        self.address        = try container.decode(String.self, forKey: .address)

        let access = try container.decode(Access.self, forKey: .access)
        self.station = access.station ?? ""
        self.walk    = access.walk ?? ""

        self.tel            = try container.decode(String.self, forKey: Key.tel)
    }
}

struct ImageURL: Codable {
    var image1: String? = ""
    var image2: String? = ""
    var qrcode: String? = ""

    enum Key: String, CodingKey {
        case image1 = "shop_image1"
        case image2 = "shop_image2"
        case qrcode = "qrcode"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)

        self.image1 = try? container.decode(String.self, forKey: .image1)
        self.image2 = try? container.decode(String.self, forKey: .image2)
        self.qrcode = try? container.decode(String.self, forKey: .qrcode)
    }

}

struct Access: Codable {
    var line: String? = ""
    var station: String? = ""
    var exit: String? = ""
    var walk: String? = ""
    var note: String? = ""

    enum Key: String, CodingKey {
        case line = "line"
        case station = "station"
        case exit = "station_exit"
        case walk = "walk"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)

        self.line = try? container.decode(String.self, forKey: .line)
        self.station = try? container.decode(String.self, forKey: .station)
        self.exit = try? container.decode(String.self, forKey: .exit)
        self.walk = try? container.decode(String.self, forKey: .walk)
    }

}

