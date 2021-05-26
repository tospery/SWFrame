//
//  UIView+Rx.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/2.
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
    
    var sf_borderColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            // YJX_TODO view.sf_borderColor = color
        }
    }
    
}

