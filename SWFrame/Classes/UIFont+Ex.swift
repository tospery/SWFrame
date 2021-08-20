//
//  UIFont+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import QMUIKit

public extension UIFont {

    static func light(_ size: CGFloat) -> UIFont {
        .qmui_lightSystemFont(ofSize: size)
    }
    
    static func normal(
        _ size: CGFloat,
        small: CGFloat = .greatestFiniteMagnitude,
        middle: CGFloat = .greatestFiniteMagnitude,
        large: CGFloat = .greatestFiniteMagnitude
    ) -> UIFont {
        switch UIScreen.kind {
        case .small: return .systemFont(ofSize: (small != .greatestFiniteMagnitude ? small : size))
        case .middle: return .systemFont(ofSize: (middle != .greatestFiniteMagnitude ? middle : size))
        case .large: return .systemFont(ofSize: (large != .greatestFiniteMagnitude ? large : size))
        }
    }
    
    static func bold(
        _ size: CGFloat,
        small: CGFloat = .greatestFiniteMagnitude,
        middle: CGFloat = .greatestFiniteMagnitude,
        large: CGFloat = .greatestFiniteMagnitude
    ) -> UIFont {
        switch UIScreen.kind {
        case .small: return .boldSystemFont(ofSize: (small != .greatestFiniteMagnitude ? small : size))
        case .middle: return .boldSystemFont(ofSize: (middle != .greatestFiniteMagnitude ? middle : size))
        case .large: return .boldSystemFont(ofSize: (large != .greatestFiniteMagnitude ? large : size))
        }
    }
    
}
