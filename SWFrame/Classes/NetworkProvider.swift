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
        return self.network.take(1).flatMap { isReachable -> Observable<Moya.Response> in
            if isReachable {
                return self.provider.rx.request(token).asObservable()
            }
            return .error(AppError.network)
        }.catchError { error -> Observable<Moya.Response> in
            var appError = AppError.server
            if let error = error as? MoyaError {
                switch error {
                case .underlying(let error, _):
                    if (error as NSError).isNetwork {
                        appError = .network
                    } else if (error as NSError).isExpire {
                        appError = .expire
                    }
                default:
                    break
                }
            }
            return .error(appError)
        }
    }
}

