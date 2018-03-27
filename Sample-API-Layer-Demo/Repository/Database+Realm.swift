//
//  Database+Realm.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2018/03/22.
//  Copyright © 2018年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager<U>: Database {
    typealias Model = U

    private let realm = try! Realm()

    // MARK: - ReadableDatabase

    func loadAllObjects() -> [Model] {
        switch Model.self {
        case is FavoriteModel.Type:
            let result = realm.objects(FavoriteObject.self)
            return Array(result).flatMap({
                guard let pref = $0.prefactureModel, let rest = $0.restrauntModel
                    else { return nil }
                return FavoriteModel(prefature: pref, restraunt: rest) as? Model
            })
        default:
            fatalError()
        }
    }

    func loadObjects(matching query: Query) -> [Model] {
        return loadAllObjects().lazy.filter(query)
    }

    func loadObject(withID id: String) -> Model? {
        let id = Int(id)!
        switch Model.self {
        case is FavoriteModel.Type:
            guard let result = realm.objects(FavoriteObject.self).first(where: { $0.id == id })
                else { return nil }
            guard let prefactureModel = result.prefactureModel, let restrauntModel = result.restrauntModel
                else { return nil }
            return FavoriteModel(prefature: prefactureModel, restraunt: restrauntModel) as? Model
        default:
            fatalError()
        }
    }

    // MARK: - WritableDatabase

    func save(_ object: Model) -> Bool {
        switch object {
        case let object as FavoriteModel:
            return transaction { realm in
                let favorite = FavoriteObject()
                favorite.set(
                    id: nextId,
                    prefature: object.prefature,
                    restraunt: object.restraunt
                )
                realm.add(favorite)
            }
        default:
            fatalError()
        }
    }

    func update(_ object: Model) -> Bool {
        switch object {
        case let object as FavoriteModel:
            return transaction { realm in
                let favorite = FavoriteObject()
                favorite.set(
                    id: nextId,
                    prefature: object.prefature,
                    restraunt: object.restraunt,
                    update: true
                )
                realm.add(favorite, update: true)
            }
        default:
            fatalError()
        }
    }

    func delete(withID id: String) -> Bool {
        switch Model.self {
        case is FavoriteModel.Type:
            guard let result = realm.object(ofType: objectType, forPrimaryKey: id)
                else { return false }
            return transaction { (realm) in
                realm.delete(result)
            }
        default:
            fatalError()
        }
    }

    // MARK: - Private

    private func transaction(_ handler: (Realm) throws -> ()) -> Bool {
        do {
            try realm.write {
                try handler(realm)
            }
            return true
        } catch {
            print(error.localizedDescription)
            fatalError()
        }
    }

    private var nextId: Int {
        if let last = realm.objects(FavoriteObject.self).last {
            return last.id + 1
        } else {
            return 0
        }
    }

    private var objectType: Object.Type {
        switch Model.self {
        case is FavoriteModel.Type:
            return FavoriteObject.self
        default:
            fatalError()
        }
    }

}
