//
//  UIFontExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import QMUIKit

public extension UIFont {
    
    static var scale: CGFloat {
        return ((QMUIHelper.is35InchScreen() || QMUIHelper.is40InchScreen()) ? -2 : 0)
    }
    
    static func normal(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: (size + self.scale))
    }
    
    static func bold(_ size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: (size + self.scale))
    }
    
    static func light(_ size: CGFloat) -> UIFont {
        return UIFont.qmui_lightSystemFont(ofSize: (size + self.scale))
    }
    
}
