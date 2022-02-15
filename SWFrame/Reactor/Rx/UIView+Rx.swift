//
//  UIView+Rx.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/15.
//

import UIKit
import RxSwift
import RxCocoa

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
    
    var swf_borderColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.qmui_borderColor = color
        }
    }
    
}
