//
//  NavigatorExtensions.swift
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
    
    func forward(
        _ url: URLConvertible,
        path: String? = nil,
        queries: [String: String]? = nil,
        context: Any? = nil,
        from1: UINavigationControllerType? = nil,
        from2: UIViewControllerType? = nil,
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
            guard base.forward(url, path: path, queries: queries, context: ctx, from1: from1, from2: from2, animated: animated, completion: completion) else {
                observer.onError(SWError.navigation)
                return Disposables.create { }
            }
            return Disposables.create { }
        }
    }
    
    func push(_ url: URLConvertible, context: Any? = nil, from: UINavigationControllerType? = nil, animated: Bool = true) -> Observable<UIViewController> {
        return .create { [weak base] observer -> Disposable in
            guard let base = base else { return Disposables.create { } }
            var ctx = [String: Any].init()
            if let context = context as? [String: Any] {
                ctx = context
            } else {
                ctx[Parameter.extra] = context
            }
            ctx[Parameter.observer] = observer
            
            if url.queryParameters.bool(for: Parameter.needLogin) ?? false &&
                url.queryParameters.string(for: Parameter.currentUser)?.isEmpty ?? true {
                if let name = UIViewController.topMost?.className, name.contains("login") {
                    observer.onCompleted()
                    return Disposables.create { }
                }
                var didLogined = false
                base.rx.present("\(UIApplication.shared.urlScheme)://login")
                    .subscribe(onNext: { result in
                        didLogined = true
                        logger.print("【路由触发】登录成功: \(result)", module: .swframe)
                        guard base.push(
                            url, context: ctx, from: from, animated: animated
                        ) != nil else {
                            observer.onError(SWError.navigation)
                            return
                        }
                    }, onError: { error in
                        observer.onError(error)
                    }, onCompleted: {
                        if !didLogined {
                            observer.onCompleted()
                        }
                    }).disposed(by: base.rx.disposeBag)
                return Disposables.create { }
            }
            
            guard base.push(
                url, context: ctx, from: from, animated: animated
            ) != nil else {
                observer.onError(SWError.navigation)
                return Disposables.create { }
            }
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
            
            if url.queryParameters.bool(for: Parameter.needLogin) ?? false &&
                url.queryParameters.string(for: Parameter.currentUser)?.isEmpty ?? true {
                if let name = UIViewController.topMost?.className, name.contains("login") {
                    observer.onCompleted()
                    return Disposables.create { }
                }
                var didLogined = false
                base.rx.present("\(UIApplication.shared.urlScheme)://login")
                    .subscribe(onNext: { result in
                        didLogined = true
                        logger.print("【路由触发】登录成功: \(result)", module: .swframe)
                        guard base.present(
                            url, context: ctx, wrap: wrap, from: from, animated: animated, completion: completion
                        ) != nil else {
                            observer.onError(SWError.navigation)
                            return
                        }
                    }, onError: { error in
                        observer.onError(error)
                    }, onCompleted: {
                        if !didLogined {
                            observer.onCompleted()
                        }
                    }).disposed(by: base.rx.disposeBag)
                return Disposables.create { }
            }
            
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
            
            if url.queryParameters.bool(for: Parameter.needLogin) ?? false &&
                url.queryParameters.string(for: Parameter.currentUser)?.isEmpty ?? true {
                if let name = UIViewController.topMost?.className, name.contains("login") {
                    observer.onCompleted()
                    return Disposables.create { }
                }
                var didLogined = false
                base.rx.present("\(UIApplication.shared.urlScheme)://login")
                    .subscribe(onNext: { result in
                        didLogined = true
                        logger.print("【路由触发】登录成功: \(result)", module: .swframe)
                        guard base.open(url, context: ctx) else {
                            observer.onError(SWError.navigation)
                            return
                        }
                    }, onError: { error in
                        observer.onError(error)
                    }, onCompleted: {
                        if !didLogined {
                            observer.onCompleted()
                        }
                    }).disposed(by: base.rx.disposeBag)
                return Disposables.create { }
            }
            
            guard base.open(url, context: ctx) else {
                observer.onError(SWError.navigation)
                return Disposables.create { }
            }
            return Disposables.create { }
        }
    }

}
