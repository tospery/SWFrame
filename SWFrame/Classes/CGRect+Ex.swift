//
//  CGRect+Ex.swift
//  SWFrame
//
//  Created by liaoya on 2021/4/2.
//

import Foundation

public extension CGRect {
    
    var isNaN: Bool {
        false // YJX_TODO SWKit.CGRectIsNaN(self)
    }

    var isInf: Bool {
        false // YJX_TODO SWKit.CGRectIsInf(self)
    }

    var isValidated: Bool {
        false // YJX_TODO SWKit.CGRectIsValidated(self)
    }

    var removeMin: CGRect {
        .zero // YJX_TODO SWKit.CGRectRemoveFloatMin(self)
    }
            
    var safed: CGRect {
        .zero // YJX_TODO SWKit.CGRectSafeValue(self)
    }
            
    var flat: CGRect {
        .zero // YJX_TODO SWKit.CGRectFlatted(self)
    }

    func fixed(_ precision: UInt) -> CGRect {
        .zero // YJX_TODO SWKit.CGRectToFixed(self, precision)
    }
    
    func rectBy(x: CGFloat) -> CGRect {
        .zero // YJX_TODO SWKit.CGRectSetX(self, x)
    }
    
    func rectBy(y: CGFloat) -> CGRect {
        .zero // YJX_TODO SWKit.CGRectSetY(self, y)
    }
    
    func rectBy(x: CGFloat, y: CGFloat) -> CGRect {
        .zero // YJX_TODO SWKit.CGRectSetXY(self, x, y)
    }
    
    func rectBy(width: CGFloat) -> CGRect {
        .zero // YJX_TODO SWKit.CGRectSetWidth(self, width)
    }
    
    func rectBy(height: CGFloat) -> CGRect {
        .zero // YJX_TODO SWKit.CGRectSetHeight(self, height)
    }
    
    func rectBy(size: CGSize) -> CGRect {
        .zero // YJX_TODO SWKit.CGRectSetSize(self, size)
    }
}

