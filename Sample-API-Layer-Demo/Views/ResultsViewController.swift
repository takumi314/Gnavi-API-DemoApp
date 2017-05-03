//
//  ResultsViewController.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/23.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

let ONCE_READ_COUNT = 50

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
        let tableFrame = masureVisibleArea()
        let tableView = UITableView(frame: tableFrame, style: .plain)

        resultTableView = tableView
        resultTableView?.backgroundColor = UIColor.orange
        resultTableView?.delegate = self
        resultTableView?.dataSource = self
        view.addSubview(resultTableView!)
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

extension ResultsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let masterString = master(of: self.masterType)
        guard let cell = Bundle.main.loadNibNamed(masterString, owner: nil, options: nil)?.first as? RestrauntTableViewCell else {
            return RestrauntTableViewCell()
        }
        guard let rest = details?.rests[indexPath.row] else {
            return RestrauntTableViewCell()
        }

        cell.setData(as: rest)
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
        // オーバースクロールすると検索開始
        let lengthOnSwitching: CGFloat = 100.0

        // 検索中は拒絶
        if onLoading {
            onLoading = true
            return
        }

        //一番上までスクロールしたかどうか
        if (-lengthOnSwitching) > tableView.contentOffset.y {
            if 1 >= details.pageOffset {
                return
            }

            onLoading = true
            tableView.isPagingEnabled = false
            tableView.isUserInteractionEnabled = false
            loadRestraunts(onPage: details.pageOffset - 1)

            // 一番下にセット
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2.6, execute: { [weak self] in
                print("Loading")
                self?.title = self?.details?.pageOffset.description

                let bottomPoint = CGPoint(x: 0, y: tableView.contentSize.height - tableView.bounds.size.height - lengthOnSwitching)
                self?.resultTableView?.setContentOffset(bottomPoint, animated: false)

                // 完了後に実行
                tableView.isPagingEnabled = true
                tableView.isUserInteractionEnabled = true
                self?.onLoading = false
            })
        }

        //一番下までスクロールしたかどうか
        if tableView.contentOffset.y >= tableView.contentSize.height - tableView.bounds.size.height + lengthOnSwitching {
            print("touched the bottom")
            //まだ表示するコンテンツが存在するか
            if details.page * details.pageOffset >= details.count {
                return
            }

            onLoading = true
            tableView.isPagingEnabled = false
            tableView.isUserInteractionEnabled = false
            loadRestraunts(onPage: details.pageOffset + 1)

            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2.6, execute: { [weak self] in
                print("Loading")
                self?.title = self?.details?.pageOffset.description

                // 完了後に実行
                tableView.isPagingEnabled = true
                tableView.isUserInteractionEnabled = true
                self?.onLoading = false
            })

            // 1, Searching is on.
            // 2. 遅延処理を開始
            // 3. get started to load from API
            // 4.
            // 5.
            // 6.
        }
    }

}

