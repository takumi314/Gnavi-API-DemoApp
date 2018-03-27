//
//  FavoriteTableViewDataSource.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2018/03/25.
//  Copyright © 2018年 Kohey. All rights reserved.
//

import UIKit

class FavoriteTableViewDataSource: NSObject, UITableViewDataSource {

    var favorites: [FavoriteModel]

    init(_ favorites: [FavoriteModel]) {
        self.favorites = favorites
    }
    
    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "rest") as? RestrauntTableViewCell
            else { return RestrauntTableViewCell() }
        let rest = favorites[indexPath.row].restraunt
        cell.displayContent(of: rest)
        return cell
    }

}
