//
//  APIClient.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/16.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Alamofire

enum Result<T> {
    case success(T)
    case failure(Error)
}

struct APIClient {

    func request(router: Router, completion: @escaping (Result<Data>) -> Void = {_ in } ) {
        Alamofire
            .request(router)
            .responseData { response in
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
