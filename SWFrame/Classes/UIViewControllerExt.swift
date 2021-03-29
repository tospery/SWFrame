//
//  UIViewControllerExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/7.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import SwifterSwift

public extension UIViewController {
    
    struct RuntimeKey {
        static let automaticallySetModalPresentationStyleKey = UnsafeRawPointer.init(bitPattern: "automaticallySetModalPresentationStyleKey".hashValue)
    }
    
    var automaticallySetModalPresentationStyle: Bool? {
        get {
            objc_getAssociatedObject(self, RuntimeKey.automaticallySetModalPresentationStyleKey!) as? Bool
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.automaticallySetModalPresentationStyleKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    @objc func sf_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if #available(iOS 13.0, *) {
            var need = true
            if let _ = self as? UIImagePickerController {
                need = false
            } else if let _ = self as? UIAlertController {
                need = false
            } else {
                let className = viewControllerToPresent.className
                if className == "PopupDialog" {
                    need = false
                }
            }
            if need {
                if let auto = self.automaticallySetModalPresentationStyle, auto == false {
                    need = false
                }
            }
            if need {
                viewControllerToPresent.modalPresentationStyle = .fullScreen
            }
        }
        self.sf_present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
}

public extension Reactive where Base: UIViewController {

    func dismiss(_ animated: Bool = true) -> ControlEvent<()> {
        let source: Observable<Void> = Observable.create { [weak viewController = self.base] observer in
            MainScheduler.ensureRunningOnMainThread()
            guard let viewController = viewController else {
                observer.on(.completed)
                return Disposables.create()
            }
            observer.on(.next(()))
            viewController.dismiss(animated: animated) {
                observer.on(.completed)
            }
            return Disposables.create()
        }.takeUntil(deallocated)
        return ControlEvent(events: source)
    }

}


