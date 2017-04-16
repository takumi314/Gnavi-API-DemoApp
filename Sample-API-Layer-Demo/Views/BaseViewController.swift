//
//  BaseViewController.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/20.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

enum Display {
    case first, second

    var cell: String {
        switch self {
        case .first:
            return ""
        case .second:
            return ""
        }
    }

    var title: String {
        switch self {
        case .first:
            return "First View"
        case .second:
            return "Second View"
        }
    }

}

enum APIMasterType {
    case prefacture
    case restraunt
}



protocol BaseControllable {
     var viewController: UIViewController { get set }
}

class BaseViewController: UIViewController {

}






