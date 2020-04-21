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
    
//    @discardableResult
//    public func open(_ url: URLConvertible, context: Any? = nil) -> Bool {
//      return self.openURL(url, context: context)
//    }
    
    
    //    func alert<Action>(title: String?, message: String?, preferredStyle: UIAlertController.Style, actions: [Action]) -> Observable<Action> where Action : AlertActionType {
    //        return .create { observer -> Disposable in
    //            let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
    //            for action in actions {
    //                let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
    //                    observer.onNext(action)
    //                    observer.onCompleted()
    //                }
    //                alert.addAction(alertAction)
    //            }
    //            UIViewController.topMost?.present(alert, animated: true, completion: nil)
    //            return Disposables.create {
    //                alert.dismiss(animated: true, completion: nil)
    //            }
    //        }
    //    }
    
//    @discardableResult
//    func open<Action>(_ url: URLConvertible, context: Any? = nil) -> Observable<Action> where Action : AlertActionType {
//        return .create { observer -> Disposable in
//            var ctx: Dictionary<String, Any> = [:]
//            ctx[routeObserverKey] = observer
//            if let context = context {
//                ctx[routeContextKey] = context
//            }
//            self.open(url, context: ctx)
//            return Disposables.create { }
//        }
//    }
}

extension Navigator: ReactiveCompatible { }
public extension Reactive where Base: Navigator {
        
//    var image: Binder<ImageSource?> {
//        return Binder(self.base) { imageView, resource in
//            imageView.isHidden = false
//            if let image = resource as? UIImage {
//                imageView.image = image
//            } else if let url = resource as? URL {
//                imageView.kf.setImage(with: url)
//            } else {
//                imageView.isHidden = true
//            }
//        }
//    }
//
//    func image(placeholder: Placeholder? = nil, options: KingfisherOptionsInfo? = nil) -> Binder<Resource?> {
//        return Binder(self.base) { imageView, resource in
//            imageView.kf.setImage(with: resource, placeholder: placeholder, options: options)
//        }
//    }
    
//    func open(_ url: URLConvertible, context: Any? = nil) -> Observable<AlertActionType> {
//        return Binder(self.base) { navigator, action in
//
//        }
//    }
    
//    public func open(_ url: URLConvertible, context: [AlertActionType]? = nil) -> Observable<AlertActionType> {
//        return .create { [weak base] observer -> Disposable in
//            var ctx: Dictionary<String, Any> = [:]
//            ctx[observerKey] = observer
//            if let context = context {
//                ctx[routeContextKey] = context
//            }
//            base?.open(url, context: ctx)
//            return Disposables.create { }
//        }
//    }
    
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
    
//    public func open<Action>(_ url: URLConvertible, context: Any? = nil) -> Observable<Action> where Action: AlertActionType {
//        return .create { [weak base] observer -> Disposable in
//            var ctx: Dictionary<String, Any> = [:]
//            ctx[routeObserverKey] = observer
//            if let context = context {
//                ctx[routeContextKey] = context
//            }
//            base?.open(url, context: ctx)
//            return Disposables.create { }
//        }
//    }
    
}
