//
//  SecondTabCoordinator.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2018/04/04.
//  Copyright © 2018年 Kohey. All rights reserved.
//

import UIKit

class SecondTabCoordinator {
    private let rootTabBarController: UITabBarController
    private let presenter: UINavigationController
    private let favoriteCoordinator: FavoriteCoordinator

    init(root: UITabBarController) {
        let presenter = UINavigationController(nibName: nil, bundle: nil)
        presenter.navigationBar.barTintColor = .blue
        presenter.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        if #available(iOS 11.0, *) {
            presenter.navigationBar.prefersLargeTitles = true
        }
        root.viewControllers?.append(presenter)

        self.presenter = presenter
        self.rootTabBarController = root
        self.favoriteCoordinator = FavoriteCoordinator(presneter: presenter)
    }

    func didSelect() {
        if presenter.viewControllers.isEmpty {
            run()
        } else {

        }
    }

}

extension SecondTabCoordinator: Coordinator {
    func run() {
        favoriteCoordinator.run()
    }
    func start(with option: DeepLinkOption?) {

    }
}
