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
//            return self.sf_top
//        }
//        set {
//            self.sf_top = newValue
//        }
    }
    
    var bottom: CGFloat {
        get { 0 } set {}
//        get {
//            return self.sf_bottom
//        }
//        set {
//            self.sf_bottom = newValue
//        }
    }
    
    var left: CGFloat {
        get { 0 } set {}
//        get {
//            return self.sf_left
//        }
//        set {
//            self.sf_left = newValue
//        }
    }
    
    var right: CGFloat {
        get { 0 } set {}
//        get {
//            return self.sf_right
//        }
//        set {
//            self.sf_right = newValue
//        }
    }
    
    var extendToTop: CGFloat {
        get { 0 } set {}
//        get {
//            return self.sf_extendToTop
//        }
//        set {
//            self.sf_extendToTop = newValue
//        }
    }
    
    var extendToBottom: CGFloat {
        get { 0 } set {}
//        get {
//            return self.sf_extendToBottom
//        }
//        set {
//            self.sf_extendToBottom = newValue
//        }
    }
    
    var extendToLeft: CGFloat {
        get { 0 } set {}
//        get {
//            return self.sf_extendToLeft
//        }
//        set {
//            self.sf_extendToLeft = newValue
//        }
    }
    
    var extendToRight: CGFloat {
        get { 0 } set {}
//        get {
//            return self.sf_extendToRight
//        }
//        set {
//            self.sf_extendToRight = newValue
//        }
    }
    
    var leftWhenCenter: CGFloat {
        0 // YJX_TODO return self.sf_leftWhenCenterInSuperview
    }
    
    var topWhenCenter: CGFloat {
        0 // YJX_TODO return self.sf_topWhenCenterInSuperview
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
