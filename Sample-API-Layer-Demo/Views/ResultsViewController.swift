//
//  ResultsViewController.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/23.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    // MAEK: - Properties

    var restraunts: [Restraunt] = []
    var details: GnaviResults?
    var masterType: APIMasterType = .restraunt // default

    var prefCode: String = ""
    var onLoading = false

    private var refreshControl: UIRefreshControl?

    // IBOutlets

    @IBOutlet weak var resultTableView: UITableView?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Results"
        loadRestraunts(onPage: 1)
    }

    override func viewWillAppear(_ animated: Bool) {
        resultTableView?.reloadData()
        super.viewWillAppear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let _ = resultTableView {
            resultTableView?.removeFromSuperview()
        }
        setResultTableView()
        addRefreshControl()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in

        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in

        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Private methods

    func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "更新...")
        refreshControl?.addTarget(self,
                                  action: #selector(refresh),
                                  for: UIControlEvents.valueChanged)
        resultTableView?.addSubview(refreshControl!)
    }

    func refresh(sender: UIRefreshControl) {
        // ここに通信処理などデータフェッチの処理を書く
        guard let refreshControl = self.refreshControl,
            let pageOffset = details?.pageOffset else {
            return
        }
        refreshControl.beginRefreshing()
        DispatchQueue
            .main
            .asyncAfter(wallDeadline: .now() + 1.0,
                        execute: { [weak self] in
                            self?.loadRestraunts(onPage: pageOffset)
                            self?.resultTableView?.reloadData()
                            if #available(iOS 10.0, *) {
                                self?.resultTableView?.refreshControl?.endRefreshing()
                            } else {
                                self?.refreshControl?.endRefreshing()
                            }
            })
    }

    func loadRestraunts(onPage page: Int) {
        if NetworkManager.isAvailable() {
            let api = APIClient()
            api.request(router: .content(page, prefCode)) { [weak self]response in
                switch response {
                case .success(let data):
                    guard let details =  GnaviResults().organizer(data) else { break }
                    self?.details = details
                    self?.setResultTableView()
                    // テーブルにセットする
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }

    private func setResultTableView() {
        let tableFrame = measureVisibleArea()
        let tableView = UITableView(frame: tableFrame, style: .plain)

        resultTableView = registerNib(for: tableView)
        resultTableView?.backgroundColor = UIColor.orange
        resultTableView?.delegate = self
        resultTableView?.dataSource = self
        view.addSubview(resultTableView!)
    }

    private func registerNib(for tableView: UITableView?) -> UITableView {
        guard let tableView = tableView else {
            return UITableView()
        }
        let nib = UINib(nibName: master(of: .restraunt), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "rest")
        return tableView
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

extension ResultsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "rest") as? RestrauntTableViewCell,
            let rest = details?.rests[indexPath.row]else {
                return RestrauntTableViewCell()
        }
        cell.displayContent(of: rest)
        return cell
    }

    func master(of type: APIMasterType) -> String {
        switch type {
        case .prefacture:
            return "PrefactureTableViewCell"
        case .restraunt:
            return "RestrauntTableViewCell"
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = details?.rests.count else {
            return 1
        }
        return  count
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

extension ResultsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToViewController(of: indexPath)
    }

    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    func moveToViewController(of indexPath: IndexPath) {
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableView = resultTableView, let details = self.details else {
            return
        }
        // 検索を開始する閾値
        let lengthOnSwitching: CGFloat = 90.0

        // 検索中は拒絶
        if onLoading {
            onLoading = true
            return
        }

        //一番上までスクロールしたかどうか
        if (-lengthOnSwitching) > tableView.contentOffset.y {
            turnToPrevious(page: details.pageOffset + 1)
        }

        //一番下までスクロールしたとき
        if tableView.contentOffset.y >= tableView.contentSize.height - tableView.bounds.size.height + lengthOnSwitching {
            print("touched the bottom")
            turnToNext(page: details.pageOffset + 1)
        }
    }

    fileprivate func turnToNext(page nextPage: Int) {
        guard let details = self.details else {
                return
        }
        // まだ表示するコンテンツが存在するか
        if details.page * nextPage >= details.count {
            return
        }
        beginLoadingContents(of: nextPage)
        self.title = nextPage.description
    }

    fileprivate func turnToPrevious(page previousPage: Int) {
        guard let details = self.details else {
            return
        }
        if 1 >= details.pageOffset {
            return
        }
        beginLoadingContents(of: previousPage)
        self.title = previousPage.description

    }

    fileprivate func beginLoadingContents(of page: Int) {
        guard let tableView = self.resultTableView else {
            return
        }
        onLoading = true
        tableView.isPagingEnabled = false
        tableView.isUserInteractionEnabled = false
        loadRestraunts(onPage: page)
        print("begin Loading")
        DispatchQueue
            .main
            .asyncAfter(wallDeadline: .now() + 1.6,
                        execute: { [weak self] in
                            // 完了後に実行
                            tableView.isPagingEnabled = true
                            tableView.isUserInteractionEnabled = true
                            self?.onLoading = false
            })
    }

}

