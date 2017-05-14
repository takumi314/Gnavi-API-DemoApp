//
//  APIClient.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/16.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Alamofire

enum Result {
    case success(Any)
    case failure(Error)
}

struct APIClient {

    func request(router: Router, completion: @escaping (Result) -> Void = {_ in } ) {
        Alamofire
            .request(router)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    completion(Result.success(data))
                case .failure:
                    if let error = response.result.error {
                        completion(Result.failure(error))
                    } else {
                        fatalError("Error instance is nil")
                    }
                }
            }
    }

}
