//
//  BaseViewController+Rx.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/19.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import SwifterSwift
import URLNavigator

public extension Reactive where Base: BaseViewController {

    var activating: Binder<Bool> {
        return Binder(self.base) { viewController, isActivating in
            viewController.isActivating = isActivating
            guard viewController.isViewLoaded else { return }
            var url = "\(UIApplication.shared.urlScheme)://toast".url!
            url.appendQueryParameters([
                Parameter.active: isActivating.string
            ])
            viewController.navigator.open(url)
        }
    }
    
    var toast: Binder<String> {
        return Binder(self.base) { viewController, message in
            guard viewController.isViewLoaded else { return }
            guard !message.isEmpty else { return }
            var url = "\(UIApplication.shared.urlScheme)://toast".url!
            url.appendQueryParameters([
                Parameter.message: message
            ])
            viewController.navigator.open(url)
        }
    }
    
    var error: Binder<Error?> {
        return Binder(self.base) { viewController, error in
            viewController.error = error
            guard viewController.isViewLoaded else { return }
            guard let error = error else { return }
            if (error as? SWFError)?.isNotLoginedIn ?? false {
                if let name = UIViewController.topMost?.className,
                   name.contains("LoginViewController") {
                    logger.print("已处于登录页，不需要再次打开", module: .swframe)
                } else {
                    viewController.navigator.present( "\(UIApplication.shared.urlScheme)://login", wrap: NavigationController.self)
                }
            } else {
                if let scrollViewController = viewController as? ScrollViewController {
                    // loading的错误用emptyDataset提示，不进行toast
                    if scrollViewController.isLoading {
                        return
                    } else if scrollViewController.isRefreshing {
                        // refreshing的empty错误，不进行toast
                        if error.asSWFError.isListIsEmpty {
                            return
                        }
                    }
                }
                var url = "\(UIApplication.shared.urlScheme)://toast".url!
                url.appendQueryParameters([
                    Parameter.message: error.asSWFError.localizedDescription
                ])
                viewController.navigator.open(url)
            }
        }
    }
}
