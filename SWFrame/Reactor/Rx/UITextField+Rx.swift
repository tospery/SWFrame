//
//  UITextField+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/26.
//

import UIKit
import RxSwift
import RxCocoa
import RxTheme
import SwifterSwift

public extension Reactive where Base: UITextField {
    
    var placeHolderColor: Binder<UIColor?> {
        return Binder(self.base) { textField, color in
            textField.setPlaceHolderTextColor(color ?? .dark)
        }
    }
    
}

public extension ThemeProxy where Base: UITextField {

    var placeHolderColor: ThemeAttribute<UIColor?> {
        get { fatalError("set only") }
        set {
            base.setPlaceHolderTextColor(newValue.value ?? .dark)
            let disposable = newValue.stream
                .take(until: base.rx.deallocating)
                .observe(on: MainScheduler.instance)
                .bind(to: base.rx.placeHolderColor)
            hold(disposable, for: "placeHolderColor")
        }
    }

}
