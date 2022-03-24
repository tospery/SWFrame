//
//  UIView+Rx.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/15.
//

import UIKit
import RxSwift
import RxCocoa
import RxTheme

public extension Reactive where Base: UIView {
    
    var setNeedsLayout: Binder<Void> {
        return Binder(self.base) { view, _ in
            view.setNeedsLayout()
        }
    }
    
    var borderColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.borderColor = color
        }
    }
    
    var qmui_borderColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.qmui_borderColor = color
        }
    }
    
}

public extension ThemeProxy where Base: UIView {

    var borderColor: ThemeAttribute<UIColor?> {
        get { fatalError("set only") }
        set {
            base.layer.borderColor = newValue.value?.cgColor
            let disposable = newValue.stream
                .take(until: base.rx.deallocating)
                .observe(on: MainScheduler.instance)
                .bind(to: base.rx.borderColor)
            hold(disposable, for: "borderColor")
        }
    }

    var qmui_borderColor: ThemeAttribute<UIColor?> {
        get { fatalError("set only") }
        set {
            base.qmui_borderColor = newValue.value
            let disposable = newValue.stream
                .take(until: base.rx.deallocating)
                .observe(on: MainScheduler.instance)
                .bind(to: base.rx.qmui_borderColor)
            hold(disposable, for: "qmui_borderColor")
        }
    }
    
}
