//
//  UIButton+Rx.swift
//  SWFrame
//
//  Created by liaoya on 2022/3/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxTheme

public extension ThemeProxy where Base: UIButton {

    func backgroundImage(from newValue: ThemeAttribute<UIImage?>, for state: UIControl.State) {
        base.setBackgroundImage(newValue.value, for: state)
        let disposable = newValue.stream
            .take(until: base.rx.deallocating)
            .observe(on: MainScheduler.instance)
            .bind(to: base.rx.backgroundImage(for: state))
        hold(disposable, for: "backgroundImage.forState.\(state.rawValue)")
    }

}
