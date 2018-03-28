//
//  FavoriteCoordinator.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2018/04/04.
//  Copyright © 2018年 Kohey. All rights reserved.
//

import UIKit

class FavoriteCoordinator {
    private let presenter: UINavigationController
    private var favorite: FavoriteViewController?
    init(presneter: UINavigationController) {
        self.presenter = presneter
    }
}

extension FavoriteCoordinator: Coordinator {
    func run() {
        let favorite = FavoriteViewController()
        presenter.pushViewController(favorite, animated: true)
        self.favorite = favorite
    }
    func start(with option: DeepLinkOption?) {

    }
}
