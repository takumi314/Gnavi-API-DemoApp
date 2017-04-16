//
//  Router.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/16.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {

    static let baseURLPath = "https://api.gnavi.co.jp/"
    static let accessKey = ""

    case content(Int, String)
    case area
    case pref

    var method: HTTPMethod {
        switch self {
        case .content, .area, .pref:
            return .get
        }
    }

    var path: String {
        switch self {
        case .content:
            return "RestSearchAPI/20150630/"
        case .area:
            return ""
        case .pref:
            return "master/PrefSearchAPI/20150630/"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let parameters: [String: Any] = {
            switch self {
            case .content(let nextPage, let pref):
                return ["keyid": Router.accessKey,
                        "format": "json",
                        "callback": "",
                        "pref": pref,
                        "areacode_l": "",
                        "hit_per_page": 50,
                        "offset_page": nextPage]
            case .area:
                return ["keyid": "",
                        "format": "json",
                        "callback": "",
                        "lang": "ja"]
            case .pref:
                return ["keyid": Router.accessKey,
                        "format": "json",
                        "lang": "ja"]
            }
        }()

        do {
            let url = try Router.baseURLPath.asURL()
            return urlRequest(url, with: parameters, for: 60 * 100)
        } catch {
            fatalError("cannot convert to URL or nil")
        }
    }

    private func urlRequest(_ url: URL,with parameters: [String: Any],for time: TimeInterval) -> URLRequest {
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(time)

        do {
            return try URLEncoding.default.encode(request, with: parameters)
        } catch {
            // An `Error` if the encoding process encounters an error
            fatalError("The encoding process encounters an error")
        }
    }

}
