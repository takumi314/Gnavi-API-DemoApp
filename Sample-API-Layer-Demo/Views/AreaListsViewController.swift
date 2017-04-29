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
        if NetworkManager.isAvailable() {
            let api = APIClient()
            api.request(router: .pref) { [weak self](response) in
                switch response {
                case .success(let data):
                    self?.areas = AreaLMasters.organizer(data)
                    self?.setAreaTableView()
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }

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

    private func setAreaTableView() {
        let tableFrame = masureVisibleArea()
        let tableView = UITableView(frame: tableFrame, style: .plain)

        areaTableView = tableView
        areaTableView?.backgroundColor = UIColor.orange
        areaTableView?.delegate = self
        areaTableView?.dataSource = self
        view.addSubview(areaTableView!)
    }

    private func masureVisibleArea() -> CGRect {
        // 画面サイズ
        let size = UIScreen.main.bounds
        // ステータスバーの高さを取得
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        // ナビゲーションバーの高さを取得
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        let tableSize = CGSize(width: size.width, height: size.height - statusBarHeight - navBarHeight!)
        let point = CGPoint(x: 0, y: 0 + statusBarHeight + navBarHeight!)

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
        let prefCode = areas[indexPath.row].prefCode
        let vc = ResultsViewController()
        vc.title = "Restraunt"
        vc.prefCode = prefCode
        vc.masterType = .restraunt
        
        navigationController?.pushViewController(vc, animated: true)
    }

}

