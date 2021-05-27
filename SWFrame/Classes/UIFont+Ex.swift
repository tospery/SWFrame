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
    
    static func bold(_ size: CGFloat) -> UIFont {
        .boldSystemFont(ofSize: size)
    }
    
}
