//
//  Favorite.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2018/03/22.
//  Copyright © 2018年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

struct FavoriteModel {
    var prefature: Prefacture
    var restraunt: Restraunt

    init(prefature: Prefacture, restraunt: Restraunt) {
        self.prefature = prefature
        self.restraunt = restraunt
    }
}

class FavoriteObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var restraunt: RestrauntObject?
    @objc dynamic var prefacture: PrefatureObject?

    override static func primaryKey() -> String? {
        return "id"
    }

    func set(id: Int, prefature: Prefacture, restraunt: Restraunt) {
        self.id = id
        self.restraunt = RestrauntObject()
        self.prefacture = PrefatureObject()
        self.restraunt?.set(restraunt)
        self.prefacture?.set(prefature)
    }

    var prefactureModel: Prefacture? {
        get {
            guard let prefacture = self.prefacture
                else { return nil }
            return Prefacture(
                areaCode: prefacture.areaCode,
                prefCode: prefacture.prefCode,
                prefName: prefacture.prefName
            )
        }
    }

    var restrauntModel: Restraunt? {
        get {
            guard let restraunt = self.restraunt
                else { return nil }
            return Restraunt(
                budget: restraunt.budget,
                id: restraunt.id,
                thumbnailURL: restraunt.thumbnailURL,
                name: restraunt.name,
                address: restraunt.address,
                station: restraunt.station,
                walk: restraunt.walk,
                tel: restraunt.tel
            )
        }
    }



}

class RestrauntObject: Object {
    @objc  dynamic var id: Int = 0
    @objc  dynamic var budget: Int = 0
    @objc  dynamic var thumbnailURL: String = ""
    @objc  dynamic var name: String = ""
    @objc  dynamic var address: String = ""
    @objc  dynamic var station: String = ""
    @objc  dynamic var walk: String = ""
    @objc  dynamic var tel: String = ""

    func set(_ restraunt: Restraunt) {
        self.budget         = restraunt.budget
        self.thumbnailURL   = restraunt.thumbnailURL
        self.name           = restraunt.name
        self.address        = restraunt.address
        self.station        = restraunt.station
        self.walk           = restraunt.walk
        self.tel            = restraunt.tel
    }
}

class PrefatureObject: Object {
    @objc dynamic var areaCode: String = ""
    @objc dynamic var prefCode: String = ""
    @objc dynamic var prefName: String = ""

    func set(_ prefacture: Prefacture) {
        self.areaCode = prefacture.areaCode
        self.prefCode = prefacture.prefCode
        self.prefName = prefacture.prefName
    }
}

