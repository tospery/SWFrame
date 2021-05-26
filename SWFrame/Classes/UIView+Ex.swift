//
//  UIView+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit

public extension UIView {
    
    var borderLayer: BorderLayer? {
        return self.layer as? BorderLayer
    }
    
    // YJX_TODO
    var top: CGFloat {
        get { 0 } set {}
//        get {
//            return self.swf_top
//        }
//        set {
//            self.swf_top = newValue
//        }
    }
    
    var bottom: CGFloat {
        get { 0 } set {}
//        get {
//            return self.swf_bottom
//        }
//        set {
//            self.swf_bottom = newValue
//        }
    }
    
    var left: CGFloat {
        get { 0 } set {}
//        get {
//            return self.swf_left
//        }
//        set {
//            self.swf_left = newValue
//        }
    }
    
    var right: CGFloat {
        get { 0 } set {}
//        get {
//            return self.swf_right
//        }
//        set {
//            self.swf_right = newValue
//        }
    }
    
    var extendToTop: CGFloat {
        get { 0 } set {}
//        get {
//            return self.swf_extendToTop
//        }
//        set {
//            self.swf_extendToTop = newValue
//        }
    }
    
    var extendToBottom: CGFloat {
        get { 0 } set {}
//        get {
//            return self.swf_extendToBottom
//        }
//        set {
//            self.swf_extendToBottom = newValue
//        }
    }
    
    var extendToLeft: CGFloat {
        get { 0 } set {}
//        get {
//            return self.swf_extendToLeft
//        }
//        set {
//            self.swf_extendToLeft = newValue
//        }
    }
    
    var extendToRight: CGFloat {
        get { 0 } set {}
//        get {
//            return self.swf_extendToRight
//        }
//        set {
//            self.swf_extendToRight = newValue
//        }
    }
    
    var leftWhenCenter: CGFloat {
        0 // YJX_TODO return self.swf_leftWhenCenterInSuperview
    }
    
    var topWhenCenter: CGFloat {
        0 // YJX_TODO return self.swf_topWhenCenterInSuperview
    }

    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }

    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
}
