//
//  Api+Prefactures.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2018/03/18.
//  Copyright © 2018年 Kohey. All rights reserved.
//

import Foundation
import Moya

extension Gnavi {

    struct GetPrefactures: GnaviApiTargetType {
        typealias Response = AreaLMasters

        /// The path to be appended to `baseURL` to form the full `URL`.
        public var path: String {
            return "master/PrefSearchAPI/20150630/"
        }
        /// The HTTP method used in the request.
        public var method: Moya.Method {
            return .get
        }
        /// The type of HTTP task to be performed.
        public var task: Moya.Task {
            let parameters = ["keyid": APIConfiguration.accessKey,
                              "format": "json",
                              "lang": "ja"] as [String : Any]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

}
