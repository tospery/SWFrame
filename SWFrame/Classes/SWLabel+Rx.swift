//
//  SWLabel+Rx.swift
//  SWFrame
//
//  Created by liaoya on 2021/5/27.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: SWLabel {

    var attrText: Binder<NSAttributedString?> {
        return Binder(self.base) { label, attributedText in
            label.setText(attributedText)
        }
    }

}
