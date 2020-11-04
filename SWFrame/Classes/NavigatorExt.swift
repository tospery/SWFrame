//
//  NavigatorExt.swift
//  iOSFrame
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
                    observer.onError(APPError.illegal(0, nil))
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

    func present(_ url: URLConvertible, context: Any? = nil, wrap: UINavigationController.Type? = nil, from: UIViewControllerType? = nil, animated: Bool = true, completion: (() -> Void)? = nil) -> Observable<UIViewController> {
        return .create { [weak base] observer -> Disposable in
            guard let base = base else { return Disposables.create { } }
            guard let viewController = base.present(url, context: context, wrap: wrap, from: from, animated: animated, completion: {
                observer.onCompleted()
            }) else {
                observer.onError(APPError.illegal(0, nil))
                return Disposables.create { }
            }
            observer.onNext(viewController)
            return Disposables.create { }
        }
    }
    
    func open(_ url: URLConvertible, context: Any? = nil) -> Observable<AlertActionType> {
        return .create { [weak base] observer -> Disposable in
            guard let base = base else { return Disposables.create { } }
            var ctx: Dictionary<String, Any> = [:]
            ctx[Parameter.routeObserver] = observer
            if let context = context {
                ctx[Parameter.routeContext] = context
            }
            base.open(url, context: ctx)
            return Disposables.create { }
        }
    }
}
