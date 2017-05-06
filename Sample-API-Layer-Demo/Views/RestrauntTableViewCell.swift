//
//  RestrauntTableViewCell.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/21.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class RestrauntTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImage: UIImageView?
    @IBOutlet weak var walkFromStation: UILabel?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var address: UILabel?
    @IBOutlet weak var tel: UILabel?
    @IBOutlet weak var budget: UILabel?

    private var imageURL: String?

    // 店名、最寄り駅（徒歩何分）、住所、電話番号、予算、サムネイル画像をセットする.
    func displayContent(of restraunt: Restraunt?) {
        guard let restraunt = restraunt else {
            return
        }
        setData(as: restraunt)
        loadImageData(from: imageURL)
    }

    fileprivate func setData(as restraunt: Restraunt?) {
        guard let rest = restraunt else {
            return
        }
        self.walkFromStation?.text = walk(from: rest.station, in: rest.walk)
        self.name?.text = rest.name
        self.address?.text = rest.address
        self.tel?.text = rest.tel
        self.budget?.text = rest.budget.description
        self.imageURL = rest.thumbnailURL
    }

    fileprivate func loadImageData(from imageURL: String?) {
        thumbnailImage?.image = nil

        guard let url = imageURL else { return }
        let global = DispatchQueue.global(qos: .default)
        let main = DispatchQueue.main

        global.async {
            guard let imageData
                = try? NSData(contentsOf: url.asURL(),
                              options: NSData.ReadingOptions.mappedIfSafe) as Data else {
                                return
            }
            let image = UIImage(data: imageData)
            main.async { [weak self] in
                self?.thumbnailImage?.contentMode = .scaleAspectFill
                self?.thumbnailImage?.clipsToBounds = true
                self?.thumbnailImage?.image = image
            }
        }
    }

    fileprivate func walk(from station: String?, in time: String?) -> String {
        guard let station = station, let time = time?.description else {
            return "データなし"
        }
        return "最寄駅　" + station + "(徒歩" + time + "分)"
    }

}
