//
//  APIClient.swift
//  Sample-API-Layer-Demo
//
//  Created by NishiokaKohei on 2017/04/16.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Alamofire
import RxSwift
import RxMoya
import Moya

enum Result<T> {
    case success(T)
    case failure(Error)
}

struct APIClient {

    public static let shared = APIClient()

    private let provider = MoyaProvider<MultiTarget>()
    private let disposeBag = DisposeBag()

    private func request<G: GnaviApiTargetType>(_ request: G) -> Single<G.Response> {
        return provider.rx
                .request(MultiTarget(request))
                .filterSuccessfulStatusCodes()
                .map(G.Response.self)
    }

    func requestPrefactures(onSuccess: @escaping ([Prefacture]) -> Void) {
        APIClient.shared
            .request(Gnavi.GetPrefactures())
            .subscribe(
                onSuccess: { (areaL) in
                    print(areaL)
                    onSuccess(areaL.prefs)
                },
                onError: { (error) in
                    print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }

    func requestRestraunt(prefCode: String, onPage page: Int, onSuccess: @escaping (GnaviResults) -> ()) {
        APIClient.shared
            .request(Gnavi.GetRestraunts(page: page, prefCode: prefCode))
            .subscribe(onSuccess: { (results) in
                onSuccess(results)
            }, onError: { (error) in
                print(error.localizedDescription)
                    fatalError()
            })
            .disposed(by: disposeBag)
    }
}
