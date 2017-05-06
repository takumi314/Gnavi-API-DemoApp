//
//  PrefactureTableViewCell.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/23.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class PrefactureTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!

    var number: String? = nil

    func setNameData(with pref: Prefacture?) {
        guard let pref = pref, self.name != nil else {
            print("self.name is nil.")
            return
        }
        self.name.text = pref.prefName
    }

}
