//
//  UIFontExtensions.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation

public extension UIFont {

    static func light(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .light)
    }
    
    static func medium(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .medium)
    }
    
    static func normal(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size)
    }
    
    static func bold(_ size: CGFloat) -> UIFont {
        .boldSystemFont(ofSize: size)
    }

}
