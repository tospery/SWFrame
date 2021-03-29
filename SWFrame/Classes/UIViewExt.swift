//
//  UIViewExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit

import RxSwift
import RxCocoa

public extension UIView {
    
    var borderLayer: BorderLayer? {
        return self.layer as? BorderLayer
    }
    
    var top: CGFloat {
        get {
            self.frame.minY
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var bottom: CGFloat {
        get {
            self.frame.maxY
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue - self.frame.height
            self.frame = frame
        }
    }
    
    var left: CGFloat {
        get {
            self.frame.minX
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var right: CGFloat {
        get {
            self.frame.maxX
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue - self.frame.width
            self.frame = frame
        }
    }
    
    var extendToTop: CGFloat {
        get {
            self.top
        }
        set {
            self.height = self.bottom - self.top
            self.top = newValue
        }
    }
    
    var extendToBottom: CGFloat {
        get {
            self.bottom
        }
        set {
            self.height = newValue - self.top
            self.bottom = newValue
        }
    }
    
    var extendToLeft: CGFloat {
        get {
            self.left
        }
        set {
            self.width = self.right - newValue
            self.left = newValue
        }
    }
    
    var extendToRight: CGFloat {
        get {
            self.right
        }
        set {
            self.width = newValue - self.left
            self.right = newValue
        }
    }
    
    var leftWhenCenter: CGFloat {
        //CGFloatGetCenter(CGRectGetWidth(self.superview.bounds), CGRectGetWidth(self.frame));
        // return flat((parent - child) / 2.0);
        guard let parent = self.superview?.bounds.width else { return 0 }
        return (parent - self.frame.width) / 2.f // YJX_TODO
    }
    
    var topWhenCenter: CGFloat {
        // return self.qmui_topWhenCenterInSuperview
        // return CGFloatGetCenter(CGRectGetHeight(self.superview.bounds), CGRectGetHeight(self.frame));
        guard let parent = self.superview?.bounds.height else { return 0 }
        return (parent - self.frame.height) / 2.f
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

public extension Reactive where Base: UIView {
    
//    var loading: Binder<Bool> {
//        return Binder(self.base) { view, loading in
//            view.isUserInteractionEnabled = !loading
//            loading ? view.makeToastActivity(.center) : view.hideToastActivity()
//        }
//    }
    
    var setNeedsLayout: Binder<Void> {
        return Binder(self.base) { view, _ in
            view.setNeedsLayout()
        }
    }
    
    var borderColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.borderColor = color
        }
    }
    
    var qmui_borderColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            // view.qmui_borderColor = color // YJX_TODO
        }
    }
    
}
