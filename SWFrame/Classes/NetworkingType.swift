//
//  NetworkingType.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/8/19.
//

import UIKit
import RxSwift
import Moya
import Alamofire
import ObjectMapper

public protocol NetworkingType {
    associatedtype Target: TargetType
    var provider: MoyaProvider<Target> { get }
}

public extension NetworkingType {
    static var endpointClosure: MoyaProvider<Target>.EndpointClosure {
        return { target in
            return MoyaProvider.defaultEndpointMapping(for: target)
        }
    }
    
    static var requestClosure: MoyaProvider<Target>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest()
                request.httpShouldHandleCookies = true
                request.timeoutInterval = 15
                closure(.success(request))
            } catch {
                closure(.failure(MoyaError.underlying(error, nil)))
            }
        }
    }
    
    static var stubClosure: MoyaProvider<Target>.StubClosure {
        return { _ in
            return .never
        }
    }

    static var callbackQueue: DispatchQueue? {
        return nil
    }
    
    static var session: Session {
        return MoyaProvider<Target>.defaultAlamofireSession()
    }
    
    static var plugins: [PluginType] {
        var plugins: [PluginType] = []
        let logger = NetworkLoggerPlugin.init()
        logger.configuration.logOptions = [.requestBody, .successResponseBody, .errorResponseBody]
        // logger.configuration.output = output
        plugins.append(logger)
        return plugins
    }
    
    static var trackInflights: Bool {
        return false
    }
    
//    static func output(target: TargetType, items: [String]) {
//        for item in items {
//            DDLogDebug(item)
//        }
//    }
}

public extension NetworkingType {
    func request(_ target: Target) -> Single<Response> {
        return self.provider.rx.request(target)
    }
    
    func requestRaw(_ target: Target) -> Single<Response> {
        return self.request(target)
            .observeOn(MainScheduler.instance)
    }
    
    func requestJSON(_ target: Target) -> Single<Any> {
        return self.request(target)
            .mapJSON()
            .observeOn(MainScheduler.instance)
    }
    
    func requestObject<Model: ModelType>(_ target: Target, type: Model.Type) -> Single<Model> {
        return self.request(target)
            .mapObject(Model.self)
            .observeOn(MainScheduler.instance)
    }
    
    func requestArray<Model: ModelType>(_ target: Target, type: Model.Type) -> Single<[Model]> {
        return self.request(target)
            .mapArray(Model.self)
            .observeOn(MainScheduler.instance)
    }
    
    func requestBase(_ target: Target) -> Single<BaseResponse> {
        return self.request(target)
            .mapObject(BaseResponse.self)
            .flatMap { response -> Single<BaseResponse> in
                guard response.code(target) == successCode else {
                    return .error(SWError.server(response.code, response.message(target)))
                }
                return .just(response)
        }
        .observeOn(MainScheduler.instance)
    }
    
    func requestData(_ target: Target) -> Single<Any?> {
        return self.request(target)
            .mapObject(BaseResponse.self)
            .flatMap { response -> Single<Any?> in
                guard response.code(target) == successCode else {
                    return .error(SWError.server(response.code, response.message(target)))
                }
                return .just(response.data)
        }
        .observeOn(MainScheduler.instance)
    }
    
    func requestModel<Model: ModelType>(_ target: Target, type: Model.Type) -> Single<Model> {
        return self.request(target)
            .mapObject(BaseResponse.self)
            .flatMap { response -> Single<Model> in
                guard response.code(target) == successCode,
                    let json = response.data(target) as? [String: Any],
                    let model = Model.init(JSON: json) else {
                        return .error(SWError.server(response.code, response.message(target)))
                }
                return .just(model)
        }
        .observeOn(MainScheduler.instance)
    }
    
    func requestModels<Model: ModelType>(_ target: Target, type: Model.Type) -> Single<[Model]> {
        return self.request(target)
            .mapObject(BaseResponse.self)
            .flatMap { response -> Single<[Model]> in
                guard response.code(target) == successCode else {
                    return .error(SWError.server(response.code, response.message(target)))
                }
                let jsonArray = response.data(target) as? [[String : Any]] ?? []
                let models = [Model].init(JSONArray: jsonArray)
                return .just(models)
        }
        .observeOn(MainScheduler.instance)
    }
    
    func requestList<Model: ModelType>(_ target: Target, type: Model.Type) -> Single<List<Model>> {
        return self.request(target)
            .mapObject(BaseResponse.self)
            .flatMap { response -> Single<List<Model>> in
                guard response.code(target) == successCode,
                    let json = response.data(target) as? [String: Any],
                    let list = List<Model>.init(JSON: json) else {
                        return .error(SWError.server(response.code, response.message(target)))
                }
                return .just(list)
        }
        .observeOn(MainScheduler.instance)
    }
}

