//
//  IPManager.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation
import RxSwift
import RxRelay
import Alamofire
import Connectivity

public let ipSubject = BehaviorRelay<String?>.init(value: nil)

final public class IPManager {
    
    var disposeBag = DisposeBag()
    public static let shared = IPManager()
    
    init() {
        
    }
    
    deinit {
    }
    
    public func start() {
        reachSubject.asObservable()
            .filter { $0 != .determining }
            .flatMap { _ in self.request() }
            .subscribe(onNext: { ip in
                ipSubject.accept(ip)
            }).disposed(by: self.disposeBag)
    }
    
    func request() -> Observable<String> {
        Observable<String>.create { observer in
            AF.request("https://api.ipify.org", requestModifier: { $0.timeoutInterval = 2 })
                .responseString { response in
                    if let string = response.value, !string.isEmpty {
                        logger.print("本机IP: \(string)", module: .swframe)
                        observer.onNext(string)
                        observer.onCompleted()
                    } else {
                        let error: Error = response.error ?? SWError.unknown
                        logger.print("本机IP: \(error)", module: .swframe)
                        observer.onError(error)
                    }
                }
            return Disposables.create { }
        }
    }

}

