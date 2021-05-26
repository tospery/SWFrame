//
//  CGSize+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/5/9.
//

import Foundation

public extension CGSize {

    init(_ value: CGFloat) {
        self.init(width: value, height: value)
    }

    var isNaN: Bool {
        false // YJX_TODO QMUIKit.CGSizeIsNaN(self)
    }
    
    var isInf: Bool {
        false // YJX_TODO QMUIKit.CGSizeIsInf(self)
    }
    
    var isEmpty: Bool {
        false // YJX_TODO QMUIKit.CGSizeIsEmpty(self)
    }
    
    var isValidated: Bool {
        false // YJX_TODO QMUIKit.CGSizeIsValidated(self)
    }
    
    var removeMin: CGSize {
        .zero // YJX_TODO QMUIKit.CGSizeRemoveFloatMin(self)
    }
            
    var flat: CGSize {
        .zero // YJX_TODO QMUIKit.CGSizeFlatted(self)
    }
    
    var ceil: CGSize {
        .zero // YJX_TODO QMUIKit.CGSizeCeil(self)
    }
    
    var floor: CGSize {
        .zero // YJX_TODO QMUIKit.CGSizeFloor(self)
    }
            
    func fixed(_ precision: UInt) -> CGSize {
        .zero // YJX_TODO QMUIKit.CGSizeToFixed(self, precision)
    }
    
}
