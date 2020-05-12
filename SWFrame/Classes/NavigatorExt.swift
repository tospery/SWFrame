//
//  NavigatorExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/22.
//

import UIKit
import RxSwift
import RxCocoa
import URLNavigator

extension Navigator: ReactiveCompatible { }
public extension Reactive where Base: Navigator {
    public func open(_ url: URLConvertible, context: Any? = nil) -> Observable<AlertActionType> {
        return .create { [weak base] observer -> Disposable in
            var ctx: Dictionary<String, Any> = [:]
            ctx[Parameter.routeObserver] = observer
            if let context = context {
                ctx[Parameter.routeContext] = context
            }
            base?.open(url, context: ctx)
            return Disposables.create { }
        }
    }
}
