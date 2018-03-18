//
//  Api+Restraunt.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2018/03/18.
//  Copyright © 2018年 Kohey. All rights reserved.
//

import Foundation
import Moya

extension Gnavi {

    struct GetRestraunts: GnaviApiTargetType {
        typealias Response = GnaviResults

        /// The path to be appended to `baseURL` to form the full `URL`.
        public var path: String {
            return "RestSearchAPI/20150630/"
        }
        /// The HTTP method used in the request.
        public var method: Moya.Method {
            return .get
        }
        /// The type of HTTP task to be performed.
        public var task: Moya.Task {
            let parameters = ["keyid": "\(APIConfiguration.accessKey)",
                "format": "json",
                "callback": "",
                "pref": prefCode,
                "areacode_l": "",
                "hit_per_page": ONCE_READ_COUNT,
                "offset_page": page] as [String : Any]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }

        private let page: Int
        private let prefCode: String
        private let perPage: Int

        init(page: Int, prefCode: String, perPage: Int = ONCE_READ_COUNT) {
            self.page   = page
            self.prefCode = prefCode
            self.perPage = perPage
        }
    }
    
}



