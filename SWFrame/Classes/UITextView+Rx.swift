//
//  UITextView+Rx.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/2.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UITextView {
    
    var placeholderColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.placeholderColor = color
        }
    }
    
}

