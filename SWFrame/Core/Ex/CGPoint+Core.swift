//
//  CGPointExtensions.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation

public extension CGPoint {
    
    var removeMin: CGPoint {
        .init(x: self.x.removeMin, y: self.y.removeMin)
    }
        
    func fixed(_ precision: UInt) -> CGPoint {
        .init(x: self.x.fixed(precision), y: self.y.fixed(precision))
    }
    
}

