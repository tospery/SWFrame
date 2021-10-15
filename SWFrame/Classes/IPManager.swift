//
//  IPManager.swift
//  SWFrame
//
//  Created by liaoya on 2021/10/14.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

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
            .filter { $0 != .unknown && $0 != .notReachable }
            .flatMap { _ in self.request() }
            .subscribe(onNext: { ip in
                ipSubject.accept(ip)
            }).disposed(by: self.disposeBag)
    }
    
    func request() -> Observable<String> {
        Observable<String>.create { [weak self] observer in
            guard let `self` = self else { return Disposables.create { } }
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
