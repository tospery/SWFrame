//
//  UIView+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa

public enum ShadowPattern {
    case top, bottom, left, right, around, common
}

public extension UIView {
    
    var borderLayer: BorderLayer? {
        return self.layer as? BorderLayer
    }
    
    var top: CGFloat {
        get { self.qmui_top }
        set { self.qmui_top = newValue }
    }
    
    var bottom: CGFloat {
        get { self.qmui_bottom }
        set { self.qmui_bottom = newValue }
    }
    
    var left: CGFloat {
        get { self.qmui_left }
        set { self.qmui_left = newValue }
    }
    
    var right: CGFloat {
        get { self.qmui_right }
        set { self.qmui_right = newValue }
    }
    
    var extendToTop: CGFloat {
        get { self.qmui_extendToTop }
        set { self.qmui_extendToTop = newValue }
    }
    
    var extendToBottom: CGFloat {
        get { self.qmui_extendToBottom }
        set { self.qmui_extendToBottom = newValue }
    }
    
    var extendToLeft: CGFloat {
        get { self.qmui_extendToLeft }
        set { self.qmui_extendToLeft = newValue }
    }
    
    var extendToRight: CGFloat {
        get { self.extendToRight }
        set { self.extendToRight = newValue }
    }
    
    var leftWhenCenter: CGFloat { self.qmui_leftWhenCenterInSuperview }
    
    var topWhenCenter: CGFloat { self.qmui_topWhenCenterInSuperview }

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
    
    func addShadow(
        color: UIColor,
        opacity: CGFloat,
        radius: CGFloat,
        path: CGFloat,
        pattern: ShadowPattern
    ) {
        self.layer.masksToBounds = false // 必须要等于false否则会把阴影切割隐藏掉
        self.layer.shadowColor = color.cgColor // 阴影颜色
        self.layer.shadowOpacity = opacity.float // 阴影透明度，默认0
        self.layer.shadowOffset = .zero // 阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
        self.layer.shadowRadius = radius // 阴影半径，默认3
        
        let x = 0.f, y = 0.f
        let width = self.bounds.size.width, height = self.bounds.size.height
        
        var rect = CGRect.init()
        switch pattern {
        case .top:
            rect = .init(x: x, y: x - path / 2, width: width, height: path)
        case .bottom:
            rect = .init(x: y, y: height - path / 2, width: width, height: path)
        case .left:
            rect = .init(x: x - path / 2, y: y, width: path, height: height)
        case .right:
            rect = .init(x: width - path / 2, y: y, width: path, height: height)
        case .around:
            rect = .init(x: x - path / 2, y: y - path / 2, width: width + path, height: height + path)
        case .common:
            rect = .init(x: x - path / 2, y: 2, width: width + path, height: height + path / 2)
        }
        self.layer.shadowPath = UIBezierPath.init(rect: rect).cgPath // 阴影路径
    }

    enum ViewSide {
        case top
        case right
        case bottom
        case left
    }
    
    struct RuntimeKey {
        static let swfBorderColorKey = UnsafeRawPointer.init(bitPattern: "swfBorderColorKey".hashValue)!
        static let swfLeftBorderKey = UnsafeRawPointer.init(bitPattern: "swfLeftBorderKey".hashValue)!
        static let swfBottomBorderKey = UnsafeRawPointer.init(bitPattern: "swfBottomBorderKey".hashValue)!
        static let swfTopBorderKey = UnsafeRawPointer.init(bitPattern: "swfTopBorderKey".hashValue)!
        static let swfRightBorderKey = UnsafeRawPointer.init(bitPattern: "swfRightBorderKey".hashValue)!
    }
    
    var swf_borderColor: UIColor? {
        get {
            objc_getAssociatedObject(self, RuntimeKey.swfBorderColorKey) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.swfBorderColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.swf_topBorderLayer?.borderColor = newValue?.cgColor
            self.swf_leftBorderLayer?.borderColor = newValue?.cgColor
            self.swf_bottomBorderLayer?.borderColor = newValue?.cgColor
            self.swf_rightBorderLayer?.borderColor = newValue?.cgColor
        }
    }
    
    private var swf_leftBorderLayer: CALayer? {
        get {
            objc_getAssociatedObject(self, RuntimeKey.swfLeftBorderKey) as? CALayer
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.swfLeftBorderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var swf_bottomBorderLayer: CALayer? {
        get {
            objc_getAssociatedObject(self, RuntimeKey.swfBottomBorderKey) as? CALayer
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.swfBottomBorderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var swf_topBorderLayer: CALayer? {
        get {
            objc_getAssociatedObject(self, RuntimeKey.swfTopBorderKey) as? CALayer
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.swfTopBorderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var swf_rightBorderLayer: CALayer? {
        get {
            objc_getAssociatedObject(self, RuntimeKey.swfRightBorderKey) as? CALayer
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.swfRightBorderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addBorder(side: ViewSide, thickness: CGFloat, color: UIColor, leftOffset: CGFloat = 0, rightOffset: CGFloat = 0, topOffset: CGFloat = 0, bottomOffset: CGFloat = 0) {
        
        switch side {
        case .top:
            let border: CALayer = _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                             y: 0 + topOffset,
                                             width: self.frame.size.width - leftOffset - rightOffset,
                                             height: thickness), color: color)
            if let old = self.swf_topBorderLayer {
                old.removeFromSuperlayer()
            }
            self.swf_topBorderLayer = border
            self.layer.addSublayer(border)
        case .right:
            let border: CALayer = _getOneSidedBorder(frame: CGRect(x: self.frame.size.width-thickness-rightOffset,
                                             y: 0 + topOffset, width: thickness,
                                             height: self.frame.size.height - topOffset - bottomOffset), color: color)
            if let old = self.swf_rightBorderLayer {
                old.removeFromSuperlayer()
            }
            self.swf_rightBorderLayer = border
            self.layer.addSublayer(border)
        case .bottom:
            let border: CALayer = _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                             y: self.frame.size.height-thickness-bottomOffset,
                                             width: self.frame.size.width - leftOffset - rightOffset, height: thickness), color: color)
            if let old = self.swf_bottomBorderLayer {
                old.removeFromSuperlayer()
            }
            self.swf_bottomBorderLayer = border
            self.layer.addSublayer(border)
        case .left:
            let border: CALayer = _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                             y: 0 + topOffset,
                                             width: thickness,
                                             height: self.frame.size.height - topOffset - bottomOffset), color: color)
            if let old = self.swf_leftBorderLayer {
                old.removeFromSuperlayer()
            }
            self.swf_leftBorderLayer = border
            self.layer.addSublayer(border)
        }
    }
    
    func removeBorders() {
        self.swf_topBorderLayer?.removeFromSuperlayer()
        self.swf_leftBorderLayer?.removeFromSuperlayer()
        self.swf_bottomBorderLayer?.removeFromSuperlayer()
        self.swf_rightBorderLayer?.removeFromSuperlayer()
        self.swf_topBorderLayer = nil
        self.swf_leftBorderLayer = nil
        self.swf_bottomBorderLayer = nil
        self.swf_rightBorderLayer = nil
    }
    
    fileprivate func _getOneSidedBorder(frame: CGRect, color: UIColor) -> CALayer {
        let border:CALayer = CALayer()
        border.frame = frame
        border.backgroundColor = color.cgColor
        return border
    }
    
}
