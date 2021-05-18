//
//  CGPoint+Ext.swift
//  SWFrame
//
//  Created by liaoya on 2021/4/2.
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
