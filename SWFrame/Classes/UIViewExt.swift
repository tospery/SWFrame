//
//  UIViewExt.swift
//  iOSFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa

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
            view.qmui_borderColor = color
        }
    }
    
}
