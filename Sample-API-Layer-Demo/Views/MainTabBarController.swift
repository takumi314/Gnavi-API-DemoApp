//
//  MainTabBarController.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/05/05.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        var controllers: [UIViewController] = []

        let areaViewController = AreaListsViewController()  // ViewController = Name of your controller
        let navigation = UINavigationController()
        navigation.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        navigation.viewControllers = [areaViewController]
        controllers.append(navigation)

        let secondViewController = UIViewController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        controllers.append(secondViewController)

        let thirdViewController = UIViewController()
        thirdViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 2)
        controllers.append(thirdViewController)

        self.setViewControllers(controllers, animated: false)

        AppDelegate().window = UIWindow(frame: UIScreen.main.bounds)
        AppDelegate().window?.rootViewController = self
        AppDelegate().window?.makeKeyAndVisible()
    }

}
