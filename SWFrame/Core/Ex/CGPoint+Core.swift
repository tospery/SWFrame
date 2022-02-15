//
//  CGPointExtensions.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation
import QMUIKit

public extension CGPoint {
    
    var removeMin: CGPoint {
        QMUIKit.CGPointRemoveFloatMin(self)
    }
        
    func fixed(_ precision: UInt) -> CGPoint {
        QMUIKit.CGPointToFixed(self, precision)
    }
    
}

