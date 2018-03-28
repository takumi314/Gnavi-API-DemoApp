//
//  AreaListsCoordinator.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2018/04/04.
//  Copyright © 2018年 Kohey. All rights reserved.
//

import UIKit

class AreaListsCoordinator {
    private let presenter: UINavigationController
    private var areaListsViewController: AreaListsViewController?
    private var resultCoorinator: ResultCoordinator?
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
}

extension AreaListsCoordinator: Coordinator {
    func run() {
        let vc = AreaListsViewController(nibName: nil, bundle: nil)
        vc.delegate = self
        presenter.pushViewController(vc, animated: true)
        self.areaListsViewController = vc
    }
    func start(with option: DeepLinkOption?) {
        assertionFailure()
    }
}

extension AreaListsCoordinator: AreaListsViewControllerDelegate {
    func areaListsViewControllerDidSelect(_ viewController: AreaListsViewController, at prefacture: Prefacture) {
        let result = ResultCoordinator(presenter: presenter, prefacture: prefacture)
        result.run()
        self.resultCoorinator = result
    }
}

extension AreaListsCoordinator: ResultsViewControllerDelegate {
    func ResultsViewControllerDidSelect(_ viewController: ResultsViewController, at restrant: Restraunt) {

    }
}
