//
//  ProviderType.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/5.
//

import UIKit
import RxSwift
import RxCocoa

public protocol ProviderType {
    
}

//// MARK: - Alert
//public protocol AlertActionType {
//    var title: String? { get }
//    var style: UIAlertAction.Style { get }
//}
//
//extension AlertActionType {
//    var style: UIAlertAction.Style {
//        return .default
//    }
//}
//
//extension ProviderType {
//
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
//
//}
