//
//  FavoriteViewController.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2018/03/25.
//  Copyright © 2018年 Kohey. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {


    private var dataSource: FavoriteTableViewDataSource
    private var tableView: UITableView?

    // MARK: - Initialier

    init() {
        let manager = RealmManager<FavoriteModel>()
        let favorites = manager.loadAllObjects()
        dataSource = FavoriteTableViewDataSource(favorites)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        tableView = registerNib(for: UITableView(frame: self.view.frame, style: .plain))
        view.addSubview(tableView!)
        tableView?.dataSource = dataSource
        tableView?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        let manager = RealmManager<FavoriteModel>()
        let favorites = manager.loadAllObjects()
        dataSource = FavoriteTableViewDataSource(favorites)
        tableView?.dataSource = dataSource
        tableView?.delegate = self
        tableView?.reloadData()
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func registerNib(for tableView: UITableView?) -> UITableView {
        guard let tableView = tableView
            else { return UITableView() }
        let nib = UINib(nibName: master(of: .restraunt), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "rest")
        return tableView
    }

    private func master(of type: APIMasterType) -> String {
        switch type {
        case .prefacture:
            return "PrefactureTableViewCell"
        case .restraunt:
            return "RestrauntTableViewCell"
        }
    }



}

extension FavoriteViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let clearButton = UITableViewRowAction(style: .destructive, title: "Clear") {
            (action, index) in
            let favorite = self.dataSource.favorites[indexPath.row]
            if RealmManager<FavoriteModel>().delete(withID: String(favorite.id)) {
                self.dataSource.favorites.remove(at: indexPath.row)
                self.tableView?.deleteRows(at: [indexPath], with: .fade)
            }
        }
        return [clearButton]
    }

    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let clear = UIContextualAction(style: .normal, title: "Clear") {
            (action, sourceView, completionHandler) in
            completionHandler(true)
            let favorite = self.dataSource.favorites[indexPath.row]
            if RealmManager<FavoriteModel>().delete(withID: String(favorite.id)) {
                self.dataSource.favorites.remove(at: indexPath.row)
                self.tableView?.deleteRows(at: [indexPath], with: .fade)
            }
        }
        let configuration = UISwipeActionsConfiguration(actions: [clear])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

