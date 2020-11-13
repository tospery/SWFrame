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
        if UIScreen.widthPoint == .pt320 {
            return 0.9
        }
        return 1.0
    }
    
    static func size(_ size: CGFloat, w320: CGFloat = -1, w414: CGFloat = -1) -> CGFloat {
        if w320 != -1 && UIScreen.widthPoint == .pt320 {
            return w320
        }
        if w414 != -1 && UIScreen.widthPoint == .pt414 {
            return w320
        }
        return floor(size * (UIScreen.widthPoint == .pt320 ? 0.9 : 1.0))
    }
    
    static func normal(_ size: CGFloat, w320: CGFloat = -1, w414: CGFloat = -1) -> UIFont {
        return .systemFont(ofSize: self.size(size, w320: w320))
    }
    
    static func bold(_ size: CGFloat, w320: CGFloat = -1, w414: CGFloat = -1) -> UIFont {
        return .boldSystemFont(ofSize: self.size(size, w320: w320))
    }
    
    static func light(_ size: CGFloat, w320: CGFloat = -1, w414: CGFloat = -1) -> UIFont {
        return .qmui_lightSystemFont(ofSize: self.size(size, w320: w320))
    }
    
}
