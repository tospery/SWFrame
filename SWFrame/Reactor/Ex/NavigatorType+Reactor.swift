//
//  NavigatorTypeExtensions.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/24.
//

import UIKit
import URLNavigator
import RxSwift
import RxCocoa

public enum ForwardType: Int {
    case push
    case present
    case open
}

public extension NavigatorType {

    // MARK: - Forward（支持自动跳转登录页功能）
    @discardableResult
    public func forward(
        _ url: URLConvertible,
        path: String? = nil,
        queries: [String: String]? = nil,
        context: Any? = nil,
        from1: UINavigationControllerType? = nil,
        from2: UIViewControllerType? = nil,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) -> Bool {
        guard var url = url.urlValue else { return false }
        guard let host = url.host else { return false }
        if let path = path {
            url.appendPathComponent(path)
        }
        if let queries = queries {
            url.appendQueryParameters(queries)
        }
        
        // 检测登录要求
        var needLogin = false
        var isLogined = true
        let router = Router.shared
        if let compatible = router as? RouterCompatible {
            isLogined = compatible.isLogined()
            if compatible.needLogin(host: host, path: path) {
                needLogin = true
            }
        } else {
            if host == .user {
                needLogin = true
            }
        }
        if needLogin && !isLogined {
            (self as! Navigator).rx.open(
                router.urlString(host: .login)
            ).subscribe(onNext: { result in
                logger.print("自动跳转登录页(数据): \(result)")
            }, onError: { error in
                logger.print("自动跳转登录页(错误): \(error)")
            }, onCompleted: {
                logger.print("自动跳转登录页(完成)")
                self.forward(url, path: path, queries: queries, context: context, from1: from1, from2: from2, animated: animated, completion: completion)
            }).disposed(by: gDisposeBag)
            return true
        }
        
        let forwardType = ForwardType.init(
            rawValue: url.queryParameters.int(for: Parameter.forwardType) ?? 0
        )
        switch forwardType {
        case .push:
            if self.push(url, context: context, from: from1, animated: animated) != nil {
                return true
            }
        case .present:
            if self.present(url, context: context, wrap: NavigationController.self, from: from2, animated: animated, completion: completion) != nil {
                return true
            }
        default: break
        }
        return self.open(url, context: context)
    }
    
    @discardableResult
    public func rxForward(
        _ url: URLConvertible,
        path: String? = nil,
        queries: [String: String]? = nil,
        context: Any? = nil,
        from1: UINavigationControllerType? = nil,
        from2: UIViewControllerType? = nil,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) -> Observable<Any> {
        (self as! Navigator).rx.forward(url, path: path, queries: queries, context: context, from1: from1, from2: from2, animated: animated, completion: completion)
    }

    // MARK: - Toast
    public func toastMessage(_ message: String) {
        guard !message.isEmpty else { return }
        self.open(Router.shared.urlString(host: .toast, parameters: [
            Parameter.message: message
        ]))
    }
    
    public func showToastActivity() {
        self.open(Router.shared.urlString(host: .toast, parameters: [
            Parameter.active: true.string
        ]))
    }
    
    public func hideToastActivity() {
        self.open(Router.shared.urlString(host: .toast, parameters: [
            Parameter.active: false.string
        ]))
    }
    
    // MARK: - Alert
    public func alert(_ title: String, _ message: String, _ actions: [AlertActionType]) {
        self.open(
            Router.shared.urlString(
                host: .alert,
                parameters: [
                    Parameter.title: title,
                    Parameter.message: message
                ]),
            context: [
                Parameter.actions: actions
            ]
        )
    }

    public func rxAlert(_ title: String, _ message: String, _ actions: [AlertActionType]) -> Observable<Any> {
        (self as! Navigator).rx.open(
            Router.shared.urlString(
                host: .alert,
                parameters: [
                    Parameter.title: title,
                    Parameter.message: message
                ]),
            context: [
                Parameter.actions: actions
            ]
        )
    }
    
    // MARK: - Login
    public func goLogin() {
        self.open(Router.shared.urlString(host: .login))
    }
    
//    
//    func sheet(_ path: Router.Path, context: Any? = nil) {
//        self.navigator.open(Router.urlString(host: .sheet, path: path), context: context)
//    }
//    
//    func rxSheet(_ path: Router.Path, context: Any? = nil) -> Observable<Any> {
//        (self.navigator as! Navigator).rx.open(Router.urlString(host: .sheet, path: path), context: context)
//    }
//
//    func popup(_ path: Router.Path, context: Any? = nil) {
//        self.navigator.open(Router.urlString(host: .popup, path: path), context: context)
//    }
//    
//    func rxPopup(_ path: Router.Path, context: Any? = nil) -> Observable<Any> {
//        (self.navigator as! Navigator).rx.open(Router.urlString(host: .popup, path: path), context: context)
//    }
    
}
