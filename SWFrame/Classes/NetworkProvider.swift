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
        
        // 1
//        let actualRequest = self.provider.rx.request(token)
//        return self.network.filter{ $0 }.take(.seconds(10), scheduler: MainScheduler.instance).flatMap { connected in
//            return actualRequest.asObservable()
//        }
        
        // 2
//        let actualRequest = self.provider.rx.request(token)
//        return self.network.take(1).flatMap { isReachable -> Observable<Moya.Response> in
//            if isReachable {
//                return actualRequest.asObservable()
//            }
//            return Observable<Moya.Response>.empty()
//        }
        
        // 3
//        let actualRequest = self.provider.rx.request(token)
//        return .create { observer -> Disposable in
//            let disposable = self.network.take(1).flatMap { isReachable -> Observable<Moya.Response> in
//                if isReachable {
//                    return actualRequest.filterSuccessfulStatusCodes().asObservable()
//                }
//                return Observable<Moya.Response>.error(NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil))
//            }.subscribe(onNext: { response in
//                observer.onNext(response)
//                observer.onCompleted()
//            }, onError: { error in
//                observer.onError(error)
//            }, onCompleted: {
//                observer.onCompleted()
//            })
//            return Disposables.create {
//                disposable.dispose()
//            }
//        }
        
        // return self.provider.rx.request(token).asObservable()
        
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
        // return self.provider.rx.request(token).asObservable()
        
//        let network = self.network.filter { value -> Bool in
//            return !value
//        }.take(.seconds(30), scheduler: MainScheduler.instance)
        
//        let network = self.network.ignore(value: false).take(1)
//        network.subscribe(onNext: { value in
//            print("a")
//        }, onError: { error in
//            print("b")
//        }, onCompleted: {
//            print("c")
//        }) {
//            print("d")
//        }
//
//        let actualRequest = self.provider.rx.request(token)
//        return self.network.ignore(value: false).take(1).flatMap { _ in
//            return actualRequest.filterSuccessfulStatusCodes().do(onSuccess: { response in
//                print("response")
//            }, onError: { error in
//                print("error")
//            })
//        }
        
//        return self.network.flatMap { value in
//            if value {
//                return self.provider.rx.request(token).asObservable()
//            }
//            return Observable<Moya.Response>.empty()
//        }
        
    }
}

