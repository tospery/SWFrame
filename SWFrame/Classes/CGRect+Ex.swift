//
//  CGRect+Ex.swift
//  SWFrame
//
//  Created by liaoya on 2021/4/2.
//

import Foundation

public extension CGRect {
    
    var isNaN: Bool {
        false // YJX_TODO QMUIKit.CGRectIsNaN(self)
    }

    var isInf: Bool {
        false // YJX_TODO QMUIKit.CGRectIsInf(self)
    }

    var isValidated: Bool {
        false // YJX_TODO QMUIKit.CGRectIsValidated(self)
    }

    var removeMin: CGRect {
        .zero // YJX_TODO QMUIKit.CGRectRemoveFloatMin(self)
    }
            
    var safed: CGRect {
        .zero // YJX_TODO QMUIKit.CGRectSafeValue(self)
    }
            
    var flat: CGRect {
        .zero // YJX_TODO QMUIKit.CGRectFlatted(self)
    }

    func fixed(_ precision: UInt) -> CGRect {
        .zero // YJX_TODO QMUIKit.CGRectToFixed(self, precision)
    }
    
    func rectBy(x: CGFloat) -> CGRect {
        .zero // YJX_TODO QMUIKit.CGRectSetX(self, x)
    }
    
    func rectBy(y: CGFloat) -> CGRect {
        .zero // YJX_TODO QMUIKit.CGRectSetY(self, y)
    }
    
    func rectBy(x: CGFloat, y: CGFloat) -> CGRect {
        .zero // YJX_TODO QMUIKit.CGRectSetXY(self, x, y)
    }
    
    func rectBy(width: CGFloat) -> CGRect {
        .zero // YJX_TODO QMUIKit.CGRectSetWidth(self, width)
    }
    
    func rectBy(height: CGFloat) -> CGRect {
        .zero // YJX_TODO QMUIKit.CGRectSetHeight(self, height)
    }
    
    func rectBy(size: CGSize) -> CGRect {
        .zero // YJX_TODO QMUIKit.CGRectSetSize(self, size)
    }
}

