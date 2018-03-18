//
//  GnaviApi.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2018/03/18.
//  Copyright © 2018年 Kohey. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum Gnavi {

    struct APIConfiguration {
        static let baseURLPath: String = "https://api.gnavi.co.jp/"
        static let accessKey: String = "7b3a8ffca29de044520190eb3437adfe"
    }

}

protocol GnaviApiTargetType: TargetType {
    associatedtype Response: Codable
}

extension GnaviApiTargetType {

    /// The target's base `URL`.
    public var baseURL: URL {
        return URL(string: "https://api.gnavi.co.jp/")!
    }
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        return ""

    }
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        return .get
    }
    /// Provides stub data for use in testing.
    public var sampleData: Data {
        return Data()
    }
    /// The type of HTTP task to be performed.
    public var task: Moya.Task {
        return .requestPlain
    }
    /// The type of validation to perform on the request. Default is `.none`.
    public var validationType: Moya.ValidationType {
        return .none
    }
    /// The headers to be used in the request.
    public var headers: [String : String]? {
        return ["": ""]
    }
}


struct JSONArrayEncoding: ParameterEncoding {
    static let `default` = JSONArrayEncoding()

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()

        guard let json = parameters?["jsonArray"] else {
            return request
        }

        let data = try JSONSerialization.data(withJSONObject: json, options: [])

        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        request.httpBody = data

        return request
    }
}
