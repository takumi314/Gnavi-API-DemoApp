//
//  ResultCoordinator.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2018/04/04.
//  Copyright © 2018年 Kohey. All rights reserved.
//

import UIKit

class ResultCoordinator {
    private let presenter: UINavigationController
    private var resultsViewController: ResultsViewController?
    private let prefacture: Prefacture
    init(presenter: UINavigationController, prefacture: Prefacture) {
        self.presenter = presenter
        self.prefacture = prefacture
    }
}

extension ResultCoordinator: Coordinator {
    func run() {
        let vc = ResultsViewController(prefacture: prefacture)
        vc.delegate = self
        vc.title = "Restraunt"
        vc.masterType = .restraunt

        presenter.pushViewController(vc, animated: true)
        self.resultsViewController = vc
    }
    func start(with option: DeepLinkOption?) {
        assertionFailure()
    }
}

extension ResultCoordinator: ResultsViewControllerDelegate {
    func ResultsViewControllerDidSelect(_ viewController: ResultsViewController, at restrant: Restraunt) {
        let favorite = FavoriteCoordinator(presneter: presenter)
        favorite.run()
    }
}
