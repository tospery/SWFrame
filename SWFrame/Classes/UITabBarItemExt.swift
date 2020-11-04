//
//  UITabBarItemExt.swift
//  iOSFrame
//
//  Created by 杨建祥 on 2020/4/28.
//

import UIKit
import RxSwift
import RxCocoa
    
extension Reactive where Base: UITabBarItem {
    
    public var title: Binder<String?> {
        return Binder(self.base) { view, attr in
            view.title = attr
        }
    }
    
    public func titleTextAttributes(for state: UIControl.State) -> Binder<[NSAttributedString.Key: Any]?> {
        return Binder(self.base) { view, attr in
            view.setTitleTextAttributes(attr, for: state)
        }
    }
    
}
