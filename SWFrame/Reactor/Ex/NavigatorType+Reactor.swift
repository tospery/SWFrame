//
//  NavigatorTypeExtensions.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/24.
//

import UIKit
import URLNavigator

public extension NavigatorType {

    @discardableResult
    public func forward(
        _ url: URLConvertible,
        context: Any? = nil,
        from: UINavigationControllerType? = nil,
        animated: Bool = true
    ) -> Bool {
        if self.push(url, context: context, from: from, animated: animated) != nil {
            return true
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
