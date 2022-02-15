//
//  CGRectExtensions.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation
import QMUIKit

public extension CGRect {
    
    var minEdge: CGFloat {
        return min(width, height)
    }
    
    var maxEdge: CGFloat {
        return max(width, height)
    }
    
    var isNaN: Bool {
        QMUIKit.CGRectIsNaN(self)
    }

    var isInf: Bool {
        QMUIKit.CGRectIsInf(self)
    }

    var isValidated: Bool {
        QMUIKit.CGRectIsValidated(self)
    }

    var removeMin: CGRect {
        QMUIKit.CGRectRemoveFloatMin(self)
    }
            
    var safed: CGRect {
        QMUIKit.CGRectSafeValue(self)
    }
            
    var flat: CGRect {
        QMUIKit.CGRectFlatted(self)
    }

    func fixed(_ precision: UInt) -> CGRect {
        QMUIKit.CGRectToFixed(self, precision)
    }
    
    func rectBy(x: CGFloat) -> CGRect {
        QMUIKit.CGRectSetX(self, x)
    }
    
    func rectBy(y: CGFloat) -> CGRect {
        QMUIKit.CGRectSetY(self, y)
    }
    
    func rectBy(x: CGFloat, y: CGFloat) -> CGRect {
        QMUIKit.CGRectSetXY(self, x, y)
    }
    
    func rectBy(width: CGFloat) -> CGRect {
        QMUIKit.CGRectSetWidth(self, width)
    }
    
    func rectBy(height: CGFloat) -> CGRect {
        QMUIKit.CGRectSetHeight(self, height)
    }
    
    func rectBy(size: CGSize) -> CGRect {
        QMUIKit.CGRectSetSize(self, size)
    }

}

