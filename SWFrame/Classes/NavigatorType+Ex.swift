//
//  NavigatorType+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/24.
//

import UIKit
import URLNavigator

public extension NavigatorType {

    @discardableResult
    public func forward(
        _ url: URLConvertible,
        context: Any? = nil,
        from: UINavigationControllerType? = nil,
        animated: Bool = true
    ) -> UIViewController? {
        let viewController = self.push(url, context: context, from: from, animated: animated)
        if viewController == nil {
            return self.present("\(UIApplication.shared.urlScheme)://login", context: context, wrap: NavigationController.self)
        }
        return viewController
    }

}
