//
//  CGPoint+Ex.swift
//  SWFrame
//
//  Created by liaoya on 2021/4/2.
//

import Foundation

public extension CGPoint {
    
    var removeMin: CGPoint {
        .zero // YJX_TODO SWKit.CGPointRemoveFloatMin(self)
    }
        
    func fixed(_ precision: UInt) -> CGPoint {
        .zero // YJX_TODO SWKit.CGPointToFixed(self, precision)
    }
    
}
