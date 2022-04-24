//
//  BaseViewControllerExtensions.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/19.
//

import UIKit
import RxSwift
import RxCocoa
import SwifterSwift
import URLNavigator

public extension Reactive where Base: BaseViewController {
    
    var title: Binder<String?> {
        self.base.navigationBar.titleLabel.rx.text
    }
    
    var activating: Binder<Bool> {
        return Binder(self.base) { viewController, isActivating in
            viewController.isActivating = isActivating
            guard viewController.isViewLoaded else { return }
            if isActivating {
                viewController.navigator.showToastActivity()
            } else {
                viewController.navigator.hideToastActivity()
            }
        }
    }
    
    var toast: Binder<String> {
        return Binder(self.base) { viewController, message in
            guard viewController.isViewLoaded else { return }
            guard !message.isEmpty else { return }
            viewController.navigator.toastMessage(message)
        }
    }
    
    var error: Binder<Error?> {
        return Binder(self.base) { viewController, error in
            viewController.error = error
            guard viewController.isViewLoaded else { return }
            guard let error = error?.asSWError else { return }
            if error == .userLoginExpired {
                viewController.navigator.goLogin()
            } else {
                if let scrollViewController = viewController as? ScrollViewController {
                    // loading的错误用emptyDataset提示，不进行toast
                    if scrollViewController.isLoading {
                        return
                    } else if scrollViewController.isRefreshing {
                        // refreshing的empty错误，不进行toast
                        if error == .listIsEmpty {
                            return
                        }
                    }
                }
                viewController.navigator.toastMessage(error.localizedDescription)
            }
        }
    }
}
