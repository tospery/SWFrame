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
        self.width.isNaN || self.height.isNaN
    }
    
    var isInf: Bool {
        self.width.isInfinite || self.height.isInfinite
    }
    
    var isEmpty: Bool {
        self.width <= 0 || self.height <= 0
    }
    
    var isValidated: Bool {
        !self.isEmpty && !self.isInf && !self.isNaN
    }
    
    var removeMin: CGSize {
        .init(width: self.width.removeMin, height: self.height.removeMin)
    }
            
    var flat: CGSize {
        .init(width: self.width.flat, height: self.height.flat)
    }
    
    var ceil: CGSize {
        .init(width: self.width.ceil, height: self.height.ceil)
    }
    
    var floor: CGSize {
        .init(width: self.width.floor, height: self.height.floor)
    }
            
    func fixed(_ precision: UInt) -> CGSize {
        .init(width: self.width.fixed(precision), height: self.height.fixed(precision))
    }
    
}
