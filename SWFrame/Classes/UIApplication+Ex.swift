//
//  UIApplication+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/8.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIApplication {

    var statusBarStyle: Binder<UIStatusBarStyle> {
        return Binder(self.base) { _, attr in
            statusBarService.accept(attr)
        }
    }

}
