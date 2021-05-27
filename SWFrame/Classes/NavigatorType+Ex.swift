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
            if let name = UIViewController.topMost?.className,
               name.contains("LoginViewController") {
                logger.print("已处于登录页，不需要再次打开", module: .swframe)
                return nil
            }
            return self.present("\(UIApplication.shared.urlScheme)://login", context: context, wrap: NavigationController.self)
        }
        return viewController
    }

}
