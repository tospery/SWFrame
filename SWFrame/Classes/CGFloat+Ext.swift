//
//  CGFloat+Ext.swift
//  SWFrame
//
//  Created by liaoya on 2020/11/13.
//

import Foundation
import QMUIKit

public extension CGFloat {
    
    var removeMin: CGFloat {
        QMUIKit.removeFloatMin(self)
    }
    
    var safed: CGFloat {
        QMUIKit.CGFloatSafeValue(self)
    }
    
    var flat: CGFloat {
        QMUIKit.flat(self)
    }
    
    var floorInPixel: CGFloat {
        QMUIKit.floorInPixel(self)
    }
    
    func fixed(_ precision: UInt) -> CGFloat {
        QMUIKit.CGFloatToFixed(self, precision)
    }
    
}
