//
//  CGPoint+Ex.swift
//  SWFrame
//
//  Created by liaoya on 2021/4/2.
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
