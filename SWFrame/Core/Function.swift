//
//  Function.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/11.
//

import UIKit
import QMUIKit

// MARK: - Compare
public func compareVersion(_ version1: String, _ version2: String, amount: Int = 3) -> ComparisonResult {
    version1.compare(version2, options: .numeric)
}

public func compareImage(_ left: ImageSource?, _ right: ImageSource?) -> Bool {
    if let lImage = left as? UIImage,
       let rImage = right as? UIImage {
        return lImage == rImage
    }
    if let lURL = left as? URL,
       let rURL = right as? URL {
        return lURL == rURL
    }
    return false
}

public func compareModels(_ left: [[ModelType]]?, _ right: [[ModelType]]?) -> Bool {
    if left == nil && right == nil {
        return true
    }
    if left == nil && right != nil {
        return false
    }
    if left != nil && right == nil {
        return false
    }
    if left!.count != right!.count {
        return false
    }
    for (arrayIndex, array1) in left!.enumerated() {
        let array2 = right![arrayIndex]
        if array1.count != array2.count {
            return false
        }
        for (modelIndex, model2) in array2.enumerated() {
            let model1 = array1[modelIndex]
            let leftString = String.init(describing: model1)
            let rightString = String.init(describing: model2)
            if leftString != rightString {
                return false
            }
        }
    }
    return true
}

public func compareAny(_ left: Any?, _ right: Any?) -> Bool {
    let leftType = type(of: left)
    let rightType = type(of: right)
    if leftType != rightType {
        return false
    }
    if left == nil && right == nil {
        return true
    }
    if left == nil && right != nil {
        return false
    }
    if left != nil && right == nil {
        return false
    }
    let leftString = String.init(describing: left!)
    let rightString = String.init(describing: right!)
    return leftString == rightString
}

/// 以390为标准，按设备宽度进行比例布局。
public func metric(_ width: CGFloat) -> CGFloat {
    (width / 390.f * deviceWidth).flat
}

/// 区分全面屏和非全面屏
public func preferredValue(notched: CGFloat, other: CGFloat) -> CGFloat {
    isNotchedScreen ? notched : other
}

/// 将所有屏幕按照宽松/紧凑分类，其中 iPad、iPhone XS Max/XR/Plus 均为宽松屏幕，但开启了放大模式的设备均会视为紧凑屏幕
public func preferredValue(regular: CGFloat, compact: CGFloat) -> CGFloat {
    isRegularScreen ? regular : compact
}

/// 小中大屏幕分类
public func preferredValue(small: CGFloat, middle: CGFloat, large: CGFloat) -> CGFloat {
    if isSmallScreen {
        return small
    } else if isLargeScreen {
        return large
    } else {
        return middle
    }
}
