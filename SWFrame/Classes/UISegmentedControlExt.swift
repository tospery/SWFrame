//
//  UISegmentedControlExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/5/5.
//

import UIKit
import RxSwift
import RxCocoa
    
extension Reactive where Base: UISegmentedControl {
    
    public func titleTextAttributes(for state: UIControl.State) -> Binder<[NSAttributedString.Key: Any]?> {
        return Binder(self.base) { view, attr in
            view.setTitleTextAttributes(attr, for: state)
        }
    }
    
}
