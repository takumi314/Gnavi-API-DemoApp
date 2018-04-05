//
//  ApplicationCoordinator.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2018/03/28.
//  Copyright © 2018年 Kohey. All rights reserved.
//

import UIKit

class ApplicationCoordinator: NSObject {
    let window: UIWindow
    let rootTabBarController: UITabBarController
    let firstTabCoordinator: FirstTabCoordinator
    var secondTabCoordinator: SecondTabCoordinator?
    init(_ window: UIWindow) {
        self.window = window

        let rootTabBarController =  MainTabBarController(controllers: [])
        rootTabBarController.tabBar.tintColor = .white
        rootTabBarController.tabBar.barTintColor = .blue

        self.firstTabCoordinator = FirstTabCoordinator(root: rootTabBarController)
        self.secondTabCoordinator = SecondTabCoordinator(root: rootTabBarController)
        self.rootTabBarController = rootTabBarController
    }

}

extension ApplicationCoordinator: Coordinator {
    func run() {
        firstTabCoordinator.run()
        rootTabBarController.delegate = self
        window.rootViewController = rootTabBarController
        window.makeKeyAndVisible()
    }

    func start(with option: DeepLinkOption?) {

    }
}

extension ApplicationCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 1 {
            secondTabCoordinator?.didSelect()
        }
        if tabBarController.selectedIndex == 0 {
            firstTabCoordinator.didSelect()
        }
    }
}

