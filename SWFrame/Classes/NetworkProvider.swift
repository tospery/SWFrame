//
//  NetworkProvider.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/9.
//

import UIKit
import Moya
import RxSwift
import RxCocoa
import Alamofire

final public class NetworkProvider<Target> where Target: Moya.TargetType {
    fileprivate var retryTimes = 0
    fileprivate let network: Observable<Bool>
    fileprivate let provider: MoyaProvider<Target>

    public required init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub,
         callbackQueue: DispatchQueue? = nil,
         session: Session = MoyaProvider<Target>.defaultAlamofireSession(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false,
         network: Observable<Bool> = connectedToInternet()) {
        self.network = network
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: callbackQueue, session: session, plugins: plugins, trackInflights: trackInflights)
    }

    public func request(_ token: Target) -> Observable<Moya.Response> {
        // -1003找不到主机, -1004找不到服务
        return self.provider.rx.request(token).asObservable()
//            .do(onError: { error in
//                let err = error
//                log("error")
//            })
    }
}

