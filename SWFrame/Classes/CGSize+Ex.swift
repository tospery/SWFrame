//
//  CGSize+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/5/9.
//

import Foundation
import QMUIKit

public extension CGSize {

    init(_ value: CGFloat) {
        self.init(width: value, height: value)
    }

    var isNaN: Bool {
        QMUIKit.CGSizeIsNaN(self)
    }
    
    var isInf: Bool {
        QMUIKit.CGSizeIsInf(self)
    }
    
    var isEmpty: Bool {
        QMUIKit.CGSizeIsEmpty(self)
    }
    
    var isValidated: Bool {
        QMUIKit.CGSizeIsValidated(self)
    }
    
    var removeMin: CGSize {
        QMUIKit.CGSizeRemoveFloatMin(self)
    }
            
    var flat: CGSize {
        QMUIKit.CGSizeFlatted(self)
    }
    
    var ceil: CGSize {
        QMUIKit.CGSizeCeil(self)
    }
    
    var floor: CGSize {
        QMUIKit.CGSizeFloor(self)
    }
            
    func fixed(_ precision: UInt) -> CGSize {
        QMUIKit.CGSizeToFixed(self, precision)
    }
    
}
