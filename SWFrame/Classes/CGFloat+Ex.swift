//
//  CGFloat+Ex.swift
//  SWFrame
//
//  Created by liaoya on 2020/11/13.
//

import Foundation

public extension CGFloat {
    
    var removeMin: CGFloat {
        self == CGFloat.leastNormalMagnitude ? 0 : self
    }
    
    var safed: CGFloat {
        self.isNaN ? 0 : self
    }
    
    var flat: CGFloat {
        Darwin.ceil(self.removeMin * UIScreen.main.scale) / UIScreen.main.scale
    }
    
    var floorInPixel: CGFloat {
        Darwin.floor(self.removeMin * UIScreen.main.scale) / UIScreen.main.scale
    }
    
    func fixed(_ precision: UInt) -> CGFloat {
//        NSString *formatString = [NSString stringWithFormat:@"%%.%@f", @(precision)];
//        NSString *toString = [NSString stringWithFormat:formatString, value];
//        #if CGFLOAT_IS_DOUBLE
//        CGFloat result = [toString doubleValue];
//        #else
//        CGFloat result = [toString floatValue];
//        #endif
//        return result;
        let format = String.init(format: "%%.%@f", NSNumber.init(value: precision))
        let string = String.init(format: format, self)
        return string.cgFloat() ?? 0
    }
    
}
