//
//  FirstTabCoordinator.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2018/03/29.
//  Copyright © 2018年 Kohey. All rights reserved.
//

import UIKit

class FirstTabCoordinator {
    private let rootTabBarController: UITabBarController
    private let presenter: UINavigationController
    private let areaListsCoordinator: AreaListsCoordinator

    init(root: UITabBarController) {
        let presenter = UINavigationController(nibName: nil, bundle: nil)
        presenter.navigationBar.barTintColor = .blue
        presenter.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        if #available(iOS 11.0, *) {
            presenter.navigationBar.prefersLargeTitles = true
        }
        root.setViewControllers([presenter], animated: false)

        self.rootTabBarController = root
        self.presenter = presenter
        self.areaListsCoordinator = AreaListsCoordinator(presenter: presenter)
    }

    func didSelect() {
        presenter.popToRootViewController(animated: true)
    }

}

extension FirstTabCoordinator: Coordinator {
    func run() {
        areaListsCoordinator.run()
    }
    func start(with option: DeepLinkOption?) {

    }
}

