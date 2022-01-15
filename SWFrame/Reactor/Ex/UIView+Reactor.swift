//
//  UIView+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import RxSwift
import RxCocoa

public enum ShadowPattern {
    case top, bottom, left, right, around, common
}

public struct ViewBorderPosition: OptionSet {
    
    public static let top = ViewBorderPosition(rawValue: 1 << 0)
    public static let left = ViewBorderPosition(rawValue: 1 << 1)
    public static let bottom = ViewBorderPosition(rawValue: 1 << 2)
    public static let right = ViewBorderPosition(rawValue: 1 << 3)

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
}

public enum ViewBorderLocation {
    case inside, center, outside
}

public extension UIView {
    
    var borderLayer: BorderLayer? {
        return self.layer as? BorderLayer
    }
    
    var top: CGFloat {
        get {
            self.frame.minY
        }
        set {
            self.frame = self.frame.rectBy(y: newValue)
        }
    }
    
    var bottom: CGFloat {
        get {
            self.frame.maxY
        }
        set {
            self.frame = self.frame.rectBy(y: newValue - self.frame.height)
        }
    }
    
    var left: CGFloat {
        get {
            self.frame.minX
        }
        set {
            self.frame = self.frame.rectBy(x: newValue)
        }
    }
    
    var right: CGFloat {
        get {
            self.frame.maxX
        }
        set {
            self.frame = self.frame.rectBy(x: newValue - self.frame.width)
        }
    }
    
    var extendToTop: CGFloat {
        get {
            self.top
        }
        set {
            self.height = self.bottom - newValue
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
        ((self.superview?.bounds.width ?? 0 - self.frame.width) / 2.0).flat
    }
    
    var topWhenCenter: CGFloat {
        ((self.superview?.bounds.height ?? 0 - self.frame.height) / 2.0).flat
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
    
    // MARK: Border start
//    public var borders: Border = [] {
//        didSet {
//            self.updateBordersHidden()
//        }
//    }
    
    struct RuntimeKey {
        static let borderLocationKey = UnsafeRawPointer.init(bitPattern: "borderLocationKey".hashValue)
    }
    
    var borderLocation: ViewBorderLocation? {
        get {
            objc_getAssociatedObject(self, RuntimeKey.borderLocationKey!) as? ViewBorderLocation
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.borderLocationKey!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    
    // MARK: Border end
    
}
