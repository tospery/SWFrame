//
//  UITabBarExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/5/2.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa
import SwifterSwift
    
extension Reactive where Base: UITabBar {
    
    @available(iOS 10.0, *)
    public var unselectedItemTintColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.unselectedItemTintColor = attr
        }
    }
    
//    public var imageTintColor: Binder<UIColor?> {
//        return Binder(self.base) { view, attr in
//            if let items = view.items {
//                for item in items {
//                    item.image = item.image?.qmui_image(withTintColor: attr)?.original
//                }
//            }
//        }
//    }
//    
//    public var selectedImageTintColor: Binder<UIColor?> {
//        return Binder(self.base) { view, attr in
//            if let items = view.items {
//                for item in items {
//                    item.selectedImage = item.selectedImage?.qmui_image(withTintColor: attr)?.original
//                }
//            }
//        }
//    }
    
}
