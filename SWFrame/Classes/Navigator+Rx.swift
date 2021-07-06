//
//  Navigator+Rx.swift
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
    
    func push(_ url: URLConvertible, context: Any? = nil, from: UINavigationControllerType? = nil, animated: Bool = true) -> Observable<UIViewController> {
        return .create { [weak base] observer -> Disposable in
            guard let base = base else { return Disposables.create { } }
            var viewController: UIViewController?
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                if viewController == nil {
                    observer.onError(SWError.navigation)
                } else {
                    observer.onNext(viewController!)
                    observer.onCompleted()
                }
            }
            viewController = base.push(url, context: context, from: from, animated: animated)
            CATransaction.commit()
            return Disposables.create { }
        }
    }

    func present(
        _ url: URLConvertible,
        context: Any? = nil,
        wrap: UINavigationController.Type? = nil,
        from: UIViewControllerType? = nil,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) -> Observable<Any> {
        return .create { [weak base] observer -> Disposable in
            guard let base = base else { return Disposables.create { } }
            var ctx = [String: Any].init()
            if let context = context as? [String: Any] {
                ctx = context
            } else {
                ctx[Parameter.extra] = context
            }
            ctx[Parameter.observer] = observer
            guard base.present(
                url, context: ctx, wrap: wrap, from: from, animated: animated, completion: completion
            ) != nil else {
                observer.onError(SWError.navigation)
                return Disposables.create { }
            }
            return Disposables.create { }
        }
    }
    
    func open(_ url: URLConvertible, context: Any? = nil) -> Observable<Any> {
        return .create { [weak base] observer -> Disposable in
            guard let base = base else { return Disposables.create { } }
            var ctx = [String: Any].init()
            if let context = context as? [String: Any] {
                ctx = context
            } else {
                ctx[Parameter.extra] = context
            }
            ctx[Parameter.observer] = observer
            guard base.open(url, context: ctx) else {
                observer.onError(SWError.navigation)
                return Disposables.create { }
            }
            return Disposables.create { }
        }
    }
    
}
