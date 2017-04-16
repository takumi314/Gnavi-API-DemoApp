//
//  AsyncImageView.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/23.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit
import Foundation

class AsyncImageView: UIImageView {

    let CACHE_SEC : TimeInterval = 5 * 60; //5分キャッシュ

    //画像を非同期で読み込む
    func loadImage(urlString: String, completion:  @escaping () -> Void ) {
        guard let url = NSURL(string: urlString) else { return }
        let request = URLRequest(url: url as URL,
                                 cachePolicy: .returnCacheDataElseLoad,
                                 timeoutInterval: CACHE_SEC)
        let config =  URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)

        session.dataTask(with: request,
                         completionHandler: { (data, request, error) in
                            if error == nil {
                                //Success
                                guard let imageData
                                    = try? NSData(contentsOf: url as URL,
                                                  options: NSData.ReadingOptions.mappedIfSafe) as Data else {
                                                    return
                                        }
                                self.image = UIImage(data: imageData)
                                completion()
                            } else {
                                //Error
                                print("AsyncImageView:Error \(String(describing: error?.localizedDescription))")
                            }
                        }).resume()

    }
    
}
