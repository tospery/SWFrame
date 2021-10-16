//
//  UIFont+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit

public extension UIFont {

    static func light(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: UIFont.Weight.light)
    }
    
    static func normal(
        _ size: CGFloat,
        small: CGFloat = .greatestFiniteMagnitude,
        middle: CGFloat = .greatestFiniteMagnitude,
        large: CGFloat = .greatestFiniteMagnitude
    ) -> UIFont {
        if isSmallScreen {
            return .systemFont(ofSize: (small != .greatestFiniteMagnitude ? small : size))
        }
        if isMiddleScreen {
            return .systemFont(ofSize: (middle != .greatestFiniteMagnitude ? middle : size))
        }
        if isLargeScreen {
            return .systemFont(ofSize: (large != .greatestFiniteMagnitude ? large : size))
        }
        return .systemFont(ofSize: (middle != .greatestFiniteMagnitude ? middle : size))
    }
    
    static func bold(
        _ size: CGFloat,
        small: CGFloat = .greatestFiniteMagnitude,
        middle: CGFloat = .greatestFiniteMagnitude,
        large: CGFloat = .greatestFiniteMagnitude
    ) -> UIFont {
        if isSmallScreen {
            return .boldSystemFont(ofSize: (small != .greatestFiniteMagnitude ? small : size))
        }
        if isMiddleScreen {
            return .boldSystemFont(ofSize: (middle != .greatestFiniteMagnitude ? middle : size))
        }
        if isLargeScreen {
            return .boldSystemFont(ofSize: (large != .greatestFiniteMagnitude ? large : size))
        }
        return .boldSystemFont(ofSize: (middle != .greatestFiniteMagnitude ? middle : size))
    }
    
}
