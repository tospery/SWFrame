//
//  NavigatorTypeExtensions.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/24.
//

import UIKit
import URLNavigator

public enum ForwardType: Int {
    case push
    case present
    case open
}

public extension NavigatorType {

    // MARK: - Forward
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
        if let path = path {
            url.appendPathComponent(path)
        }
        if let queries = queries {
            url.appendQueryParameters(queries)
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
    
    // MARK: - Login
    public func goLogin() {
        if self.open(Router.shared.urlString(host: .login)) {
            return
        }
        self.present(Router.shared.urlString(host: .login), wrap: NavigationController.self)
    }
    
//    func alert(_ title: String, _ message: String, _ actions: [AlertActionType]) {
//        self.navigator.open(
//            Router.urlString(host: .alert, parameters: [Parameter.title: title,Parameter.message: message]),
//            context: [Parameter.actions: actions]
//        )
//    }
//
//    func rxAlert(_ title: String, _ message: String, _ actions: [AlertActionType]) -> Observable<Any> {
//        (self.navigator as! Navigator).rx.open(
//            Router.urlString(host: .alert, parameters: [Parameter.title: title,Parameter.message: message]),
//            context: [Parameter.actions: actions]
//        )
//    }
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
