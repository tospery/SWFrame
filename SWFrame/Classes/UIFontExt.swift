//
//  UIFontExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import QMUIKit

public extension UIFont {

    static func size(_ size: CGFloat) -> CGFloat {
        isSmallWidthScreen ? round(size * 0.9) : size
    }
    
    static func normal(_ size: CGFloat) -> UIFont {
        return .systemFont(ofSize: self.size(size))
    }
    
    static func bold(_ size: CGFloat) -> UIFont {
        return .boldSystemFont(ofSize: self.size(size))
    }
    
    static func light(_ size: CGFloat) -> UIFont {
        return .qmui_lightSystemFont(ofSize: self.size(size))
    }
    
}
