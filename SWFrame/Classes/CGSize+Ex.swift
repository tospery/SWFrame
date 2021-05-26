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
        false // YJX_TODO SWKit.CGSizeIsNaN(self)
    }
    
    var isInf: Bool {
        false // YJX_TODO SWKit.CGSizeIsInf(self)
    }
    
    var isEmpty: Bool {
        false // YJX_TODO SWKit.CGSizeIsEmpty(self)
    }
    
    var isValidated: Bool {
        false // YJX_TODO SWKit.CGSizeIsValidated(self)
    }
    
    var removeMin: CGSize {
        .zero // YJX_TODO SWKit.CGSizeRemoveFloatMin(self)
    }
            
    var flat: CGSize {
        .zero // YJX_TODO SWKit.CGSizeFlatted(self)
    }
    
    var ceil: CGSize {
        .zero // YJX_TODO SWKit.CGSizeCeil(self)
    }
    
    var floor: CGSize {
        .zero // YJX_TODO SWKit.CGSizeFloor(self)
    }
            
    func fixed(_ precision: UInt) -> CGSize {
        .zero // YJX_TODO SWKit.CGSizeToFixed(self, precision)
    }
    
}
