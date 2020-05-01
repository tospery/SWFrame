//
//  NavigatorTypeExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/22.
//

import UIKit
import RxSwift
import RxCocoa
import URLNavigator

public var routeObserverKey: String { "routeObserverKey" }
public var routeContextKey: String { "routeContextKey" }

public extension NavigatorType {
    
}

extension Navigator: ReactiveCompatible { }
public extension Reactive where Base: Navigator {
    public func open(_ url: URLConvertible, context: Any? = nil) -> Observable<AlertActionType> {
        return .create { [weak base] observer -> Disposable in
            var ctx: Dictionary<String, Any> = [:]
            ctx[routeObserverKey] = observer
            if let context = context {
                ctx[routeContextKey] = context
            }
            base?.open(url, context: ctx)
            return Disposables.create { }
        }
    }
}