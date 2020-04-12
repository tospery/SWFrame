//
//  UIViewExt.swift
//  SwiftFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import QMUIKit

public extension UIView {
    
    var borderLayer: BorderLayer? {
        return self.layer as? BorderLayer
    }
    
    var top: CGFloat {
        get {
            return self.qmui_top
        }
        set {
            self.qmui_top = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.qmui_bottom
        }
        set {
            self.qmui_bottom = newValue
        }
    }
    
    var left: CGFloat {
        get {
            return self.qmui_left
        }
        set {
            self.qmui_left = newValue
        }
    }
    
    var right: CGFloat {
        get {
            return self.qmui_right
        }
        set {
            self.qmui_right = newValue
        }
    }
    
    var extendToTop: CGFloat {
        get {
            return self.qmui_extendToTop
        }
        set {
            self.qmui_extendToTop = newValue
        }
    }
    
    var extendToBottom: CGFloat {
        get {
            return self.qmui_extendToBottom
        }
        set {
            self.qmui_extendToBottom = newValue
        }
    }
    
    var extendToLeft: CGFloat {
        get {
            return self.qmui_extendToLeft
        }
        set {
            self.qmui_extendToLeft = newValue
        }
    }
    
    var extendToRight: CGFloat {
        get {
            return self.qmui_extendToRight
        }
        set {
            self.qmui_extendToRight = newValue
        }
    }
    
    var leftWhenCenter: CGFloat {
        return self.qmui_leftWhenCenterInSuperview
    }
    
    var topWhenCenter: CGFloat {
        return self.qmui_topWhenCenterInSuperview
    }
    
}
