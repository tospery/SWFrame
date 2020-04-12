//
//  ReactiveExt.swift
//  SwiftFrame
//
//  Created by 杨建祥 on 2020/4/7.
//

import UIKit
import RxSwift
import RxCocoa
import QMUIKit
import Toast_Swift

// MARK: - UIView
public extension Reactive where Base: UIView {
    
//    var loading: Binder<Bool> {
//        return Binder(self.base) { view, loading in
//            view.isUserInteractionEnabled = !loading
//            loading ? view.makeToastActivity(.center) : view.hideToastActivity()
//        }
//    }
    
    var setNeedsLayout: Binder<Void> {
        return Binder(self.base) { view, _ in
            view.setNeedsLayout()
        }
    }
    
    var borderColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.qmui_borderColor = attr
        }
    }
    
}

//public extension Reactive where Base: UIViewController {
//
//    var loading: Binder<Bool> {
//        return Binder(self.base) { viewController, loading in
//            if viewController.qmui_isViewLoadedAndVisible() {
//                let view = viewController.view!
//                view.isUserInteractionEnabled = !loading
//                loading ? view.makeToastActivity(.center) : view.hideToastActivity()
//            }
//        }
//    }
//
//}

// MARK: - BaseViewController
public extension Reactive where Base: BaseViewController {
    
    var loading: Binder<Bool> {
        return Binder(self.base) { viewController, loading in
            viewController.loading = loading
//            if viewController.qmui_isViewLoadedAndVisible() {
//                let view = viewController.view!
//                view.isUserInteractionEnabled = !loading
//                loading ? view.makeToastActivity(.center) : view.hideToastActivity()
//            }
        }
    }
    
    var error: Binder<Error?> {
        return Binder(self.base) { viewController, error in
            viewController.error = error
        }
    }
    
//    var emptyDataSetImageTintColorBinder: Binder<UIColor?> {
//        return Binder(self.base) { viewController, attr in
//            viewController.emptyDataSetImageTintColor.accept(attr)
//        }
//    }
    
//    var emptyDataSetTap: ControlEvent<Void> {
//        let source = self.base.emptyDataSetSubject.map{ _ in }
//        return ControlEvent(events: source)
//    }
    
}

// MARK: - ScrollViewController
public extension Reactive where Base: ScrollViewController {
    
    var emptyDataSetTap: ControlEvent<Void> {
        let source = self.base.emptyDataSetSubject.map{ _ in }
        return ControlEvent(events: source)
    }
    
}
