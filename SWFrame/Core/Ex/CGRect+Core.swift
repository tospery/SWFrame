//
//  CGRectExtensions.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation

public extension CGRect {
    
    var minEdge: CGFloat {
        return min(width, height)
    }
    
    var maxEdge: CGFloat {
        return max(width, height)
    }
    
    var isNaN: Bool {
        self.origin.x.isNaN || self.origin.y.isNaN || self.size.width.isNaN || self.size.height.isNaN
    }

    var isInf: Bool {
        self.origin.x.isInfinite || self.origin.y.isInfinite || self.size.width.isInfinite || self.size.height.isInfinite
    }

    var isValidated: Bool {
        !self.isNull && !self.isInfinite && !self.isNaN && !self.isInf
    }

    var removeMin: CGRect {
        .init(
            x: self.origin.x.removeMin,
            y: self.origin.y.removeMin,
            width: self.size.width.removeMin,
            height: self.size.height.removeMin
        )
    }
            
    var safed: CGRect {
        .init(
            x: self.origin.x.safed,
            y: self.origin.y.safed,
            width: self.size.width.safed,
            height: self.size.height.safed
        )
    }
            
    var flat: CGRect {
        .init(
            x: self.origin.x.flat,
            y: self.origin.y.flat,
            width: self.size.width.flat,
            height: self.size.height.flat
        )
    }

    func fixed(_ precision: UInt) -> CGRect {
        .init(
            x: self.origin.x.fixed(precision),
            y: self.origin.y.fixed(precision),
            width: self.size.width.fixed(precision),
            height: self.size.height.fixed(precision)
        )
    }
    
    func rectBy(x: CGFloat) -> CGRect {
        var rect = self
        rect.origin.x = x.flat
        return rect
    }
    
    func rectBy(y: CGFloat) -> CGRect {
        var rect = self
        rect.origin.y = y.flat
        return rect
    }
    
    func rectBy(x: CGFloat, y: CGFloat) -> CGRect {
        var rect = self
        rect.origin.x = x.flat
        rect.origin.y = y.flat
        return rect
    }
    
    func rectBy(width: CGFloat) -> CGRect {
        if width < 0 {
            return self
        }
        var rect = self
        rect.size.width = width.flat
        return rect
    }
    
    func rectBy(height: CGFloat) -> CGRect {
        if height < 0 {
            return self
        }
        var rect = self
        rect.size.height = height.flat
        return rect
    }
    
    func rectBy(size: CGSize) -> CGRect {
        var rect = self
        rect.size = size.flat
        return rect
    }

}

