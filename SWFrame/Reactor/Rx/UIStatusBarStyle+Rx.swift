//
//  EnumEx.swift
//  SWFrame
//
//  Created by liaoya on 2020/7/9.
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
