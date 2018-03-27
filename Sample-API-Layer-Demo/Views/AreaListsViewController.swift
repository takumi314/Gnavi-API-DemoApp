//
//  AreaListsViewController.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/19.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class AreaListsViewController: UIViewController {

    // MAEK: - Properties

    var areas: [Prefacture] = []
    var masterType: APIMasterType = .prefacture // default

    // MAEK: - IBOutlets

    @IBOutlet weak var areaTableView: UITableView?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Prefacture"
        loadPrefactures()
    }

    override func viewWillAppear(_ animated: Bool) {
        areaTableView?.reloadData()
        super.viewWillAppear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if areaTableView != nil {
            areaTableView?.removeFromSuperview()
        }
        setAreaTableView()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        //
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Private methods

    private func loadPrefactures() {
        if NetworkManager.isAvailable() {
            APIClient.shared.requestPrefactures {
                (prefactures: [Prefacture]) in
                self.areas = prefactures
                self.areaTableView?.reloadData()
            }
        } else {
            print("Failed to access")
        }
    }

    private func setAreaTableView() {
        let tableFrame = measureVisibleArea()
        let tableView = UITableView(frame: tableFrame, style: .plain)

        areaTableView = tableView
        areaTableView?.backgroundColor = UIColor.orange
        areaTableView?.delegate = self
        areaTableView?.dataSource = self
        view.addSubview(areaTableView!)
    }

    private func measureVisibleArea() -> CGRect {
        // 画面サイズ
        let size = UIScreen.main.bounds
        // ステータスバーの高さを取得
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        // ナビゲーションバー
        let navBarFrame = self.navigationController?.navigationBar.frame
        // タブバー
        let tabBarFrame = super.tabBarController?.tabBar.frame
        guard let navBarHeight = navBarFrame?.size.height, let tabBarHeight = tabBarFrame?.size.height else {
                let tableSize = CGSize(width: size.width, height: size.height - 32.0 - 49.0)
                let point = CGPoint(x: 0, y: 0 + statusBarHeight + 32)
                return CGRect(origin: point, size: tableSize)
        }
        let tableSize = CGSize(width: size.width, height: size.height - navBarHeight - statusBarHeight - tabBarHeight)
        let point = CGPoint(x: 0, y: 0 + navBarHeight + statusBarHeight)

        return CGRect(origin: point, size: tableSize)
    }

}

// MAEK: - UITableViewDataSource

extension AreaListsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.textLabel?.text = areas[indexPath.row].prefName
        return cell
    }

    private func master(of type: APIMasterType) -> String {
        switch type {
        case .prefacture:
            return "PrefactureTableViewCell"
        case .restraunt:
            return "RestrauntTableViewCell"
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return masterType == .prefacture ? 1 : 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = "Title"
        return title
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view =  UIView()
        view.backgroundColor = UIColor.brown
        return view
    }

    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return 1
    }

}

// MAEK: - UITableViewDelegate

extension AreaListsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToViewController(of: indexPath)
    }

    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }

    func moveToViewController(of indexPath: IndexPath) {
        let prefacture = areas[indexPath.row]
        let vc = ResultsViewController(prefacture: prefacture)
        vc.title = "Restraunt"
        vc.masterType = .restraunt
        
        navigationController?.pushViewController(vc, animated: true)
    }

}

