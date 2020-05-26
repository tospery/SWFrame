//
//  NetworkingType.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/9.
//

import UIKit
import RxSwift
import ObjectMapper
import Moya
import Alamofire

public protocol NetworkingType {
    associatedtype T: TargetType
    var provider: NetworkProvider<T> { get }
}

public extension NetworkingType {
    static func endpointsClosure<T>(_ xAccessToken: String? = nil) -> (T) -> Endpoint where T: TargetType {
        return { target in
            let endpoint = MoyaProvider.defaultEndpointMapping(for: target)
            // Sign all non-XApp, non-XAuth token requests
            return endpoint
        }
    }
    
    static func APIKeysBasedStubBehaviour<T>(_: T) -> Moya.StubBehavior {
//        if true {
//            // return .immediate
//            return .delayed(seconds: TimeInterval(1.5))
//        }
        return .never
    }
    
    static var plugins: [PluginType] {
        var plugins: [PluginType] = []
        #if DEBUG
        plugins.append(NetworkLoggerPlugin(verbose: true))
        #endif
        return plugins
    }
    
    static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest()
                request.httpShouldHandleCookies = true
                request.timeoutInterval = 10 // Constant.Network.timeout
                closure(.success(request))
            } catch {
                log.error(error.localizedDescription)
            }
        }
    }
    
    func convert(error: Error) -> AppError {
        if let error = error as? MoyaError {
            switch error {
            case .underlying(let error, _):
                if (error as NSError).isNetwork {
                    return .network
                } else if (error as NSError).isExpire {
                    return .expire
                }
                return .server
            default:
                return .server
            }
        }
        return .server
    }
}
