//
//  UIViewController+Rx.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/15.
//

import UIKit
import RxSwift
import RxCocoa
import SwifterSwift

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
