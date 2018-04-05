//
//  MainTabBarController.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/05/05.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    init(controllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.setViewControllers(controllers, animated: false)

        // デフォルト0, 最初に1をセットしないとうまくいかない
        self.selectedIndex = 1
        self.selectedIndex = 0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
