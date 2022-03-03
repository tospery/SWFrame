//
//  UIBarAppearance+Rx.swift
//  SWFrame.default-Components_JSBridge
//
//  Created by liaoya on 2022/3/3.
//

import UIKit
import RxCocoa
import RxSwift
import RxTheme

@available(iOS 13.0, *)
public extension ThemeProxy where Base: UIBarAppearance {

    var backgroundColor: ThemeAttribute<UIColor?> {
        get { fatalError("set only") }
        set {
            base.backgroundColor = newValue.value
            let disposable = newValue.stream
                .take(until: base.rx.deallocating)
                .observe(on: MainScheduler.instance)
                .bind(to: base.rx.backgroundColor)
            hold(disposable, for: "backgroundColor")
        }
    }

}
