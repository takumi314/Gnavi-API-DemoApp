//
//  RestrauntTableViewCell.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/21.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit
import Foundation

class RestrauntTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImage: UIImageView?
    @IBOutlet weak var walkFromStation: UILabel?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var address: UILabel?
    @IBOutlet weak var tel: UILabel?
    @IBOutlet weak var budget: UILabel?
    // 店名、最寄り駅（徒歩何分）、住所、電話番号、予算、サムネイル画像。

    func setData(as restraunt: Restraunt?) {
        guard let rest = restraunt else { return }

        self.walkFromStation?.text = walk(from: rest.station, in: rest.walk)
        self.name?.text = rest.name
        self.address?.text = rest.address
        self.tel?.text = rest.tel
        self.budget?.text = rest.budget.description

        let asynvImage = AsyncImageView()
        let url = rest.thumbnailURL
        asynvImage.loadImage(urlString: url) { [weak self] in
            self?.thumbnailImage?.contentMode = .scaleAspectFit
            self?.thumbnailImage?.image = asynvImage.image
        }
    }

    private func walk(from station: String?, in time: String?) -> String {
        guard let station = station, let time = time?.description else {
            return "データなし"
        }
        return "最寄駅　" + station + "(徒歩" + time + "分)"
    }

}
