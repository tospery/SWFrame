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
         manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false,
         network: Observable<Bool> = connectedToInternet()) {
        self.network = network
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: callbackQueue, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }

    public func request(_ token: Target) -> Observable<Moya.Response> {
//        let actualRequest = self.provider.rx.request(token)
//        return self.network.ignore(value: false).take(1).flatMap({ _ in
//            return actualRequest.filterSuccessfulStatusCodes().do(onSuccess: { (response) in
//
//            }, onError: { (error) in
//                if let error = error as? MoyaError {
//                    switch error {
//                    case .statusCode(let response):
//                        if response.statusCode == 401 {
//                            // Unauthorized AuthManager.removeToken()
//                        }
//                    default: break
//                    }
//                }
//            })
//        })
        
        
//        return self.network.flatMap { hasNetwork -> Observable<Int> in
//            if hasNetwork {
//                self.retryTimes = 0
//                return Observable.just(1)
//            }
//            if self.retryTimes != 5 {
//                self.retryTimes += 1
//                return Observable.timer(.seconds(3), scheduler: MainScheduler.instance)
//            }
//            return Observable.error(AppError.network)
//        }.flatMap { withNetwork -> Observable<Moya.Response> in
//            return self.provider.rx.request(token).asObservable()
//        }
        // YJX_TODO 无网重试
        // https://www.jianshu.com/p/92c70f7d4fc4
        return self.provider.rx.request(token).asObservable()
    }
}

