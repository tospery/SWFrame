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
    ) -> Bool {
        if self.push(url, context: context, from: from, animated: animated) != nil {
            return true
        }
        return self.open(url, context: context)
    }

}
