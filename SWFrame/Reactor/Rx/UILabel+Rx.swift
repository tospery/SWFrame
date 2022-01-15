//
//  UILabel+Rx.swift
//  SWFrame
//
//  Created by liaoya on 2021/5/25.
//

import UIKit
import RxCocoa
import RxSwift

extension Reactive where Base: UILabel {

    public var isHighlighted: Binder<Bool> {
        return Binder(self.base) { label, highlighted in
            label.isHighlighted = highlighted
        }
    }

}
