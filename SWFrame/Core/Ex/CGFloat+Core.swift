//
//  CGFloatExtensions.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/11.
//

import Foundation

public extension CGFloat {
    
    var removeMin: CGFloat {
        self == CGFloat.leastNormalMagnitude ? 0 : self
    }
    
    var safed: CGFloat {
        self.isNaN ? 0 : self
    }
    
    var ceil: CGFloat {
        Foundation.ceil(self.removeMin)
    }
    
    var floor: CGFloat {
        Foundation.floor(self.removeMin)
    }
    
    /**
     *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
     *
     *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
     */
    var flat: CGFloat {
        Foundation.ceil(self.removeMin * UIScreen.main.scale) / UIScreen.main.scale
    }
    
    /**
     *  类似flat，只不过 flat 是向上取整，而 floorInPixel 是向下取整
     */
    var floorInPixel: CGFloat {
        Foundation.floor(self.removeMin * UIScreen.main.scale) / UIScreen.main.scale
    }
    
    func fixed(_ precision: UInt) -> CGFloat {
        let format = String.init(format: "%%.%@f", NSNumber.init(value: precision))
        let string = String.init(format: format, self)
#if CGFLOAT_IS_DOUBLE
        return (string as NSString).doubleValue
#else
        return CGFloat((string as NSString).floatValue)
#endif
    }

}


public extension IntegerLiteralType {
    var f: CGFloat {
        return CGFloat(self)
    }
}

public extension FloatLiteralType {
    var f: CGFloat {
        return CGFloat(self)
    }
}
