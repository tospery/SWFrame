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
    
    static func normal(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size)
    }
    
    static func normal(_ size: CGFloat, small: CGFloat) -> UIFont {
        UIScreen.isSmall ? .systemFont(ofSize: small) : .systemFont(ofSize: size)
    }
    
    static func normal(_ size: CGFloat, large: CGFloat) -> UIFont {
        UIScreen.isLarge ? .systemFont(ofSize: large) : .systemFont(ofSize: size)
    }
    
    static func normal(small: CGFloat, middle: CGFloat, large: CGFloat) -> UIFont {
        switch UIScreen.kind {
        case .small: return .systemFont(ofSize: small)
        case .middle: return .systemFont(ofSize: middle)
        case .large: return .systemFont(ofSize: large)
        }
    }
    
    static func bold(_ size: CGFloat) -> UIFont {
        .boldSystemFont(ofSize: size)
    }
    
    static func bold(_ size: CGFloat, small: CGFloat) -> UIFont {
        UIScreen.isSmall ? .boldSystemFont(ofSize: small) : .boldSystemFont(ofSize: size)
    }
    
    static func bold(_ size: CGFloat, large: CGFloat) -> UIFont {
        UIScreen.isLarge ? .boldSystemFont(ofSize: large) : .boldSystemFont(ofSize: size)
    }
    
    static func bold(small: CGFloat, middle: CGFloat, large: CGFloat) -> UIFont {
        switch UIScreen.kind {
        case .small: return .boldSystemFont(ofSize: small)
        case .middle: return .boldSystemFont(ofSize: middle)
        case .large: return .boldSystemFont(ofSize: large)
        }
    }
    
}
