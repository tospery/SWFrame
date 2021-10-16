//
//  Function.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import RxSwift

public func ToString(_ any: Any?) -> String? {
    guard let any = any else { return nil }
    return String.init(describing: any)
}

// MARK: - compare
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

public func compareVersion(_ version1: String, _ version2: String, amount: Int = 3) -> ComparisonResult {
    if version1 == version2 {
        return .orderedSame
    }
    let items1 = version1.components(separatedBy: ".")
    let items2 = version2.components(separatedBy: ".")
    guard items1.count == amount, items2.count == amount else {
        return .orderedSame
    }
    guard let first1 = items1[0].int, let first2 = items2[0].int else {
        return .orderedSame
    }
    if first1 > first2 {
        return .orderedDescending
    } else if first1 < first2 {
        return .orderedAscending
    }
    guard let second1 = items1[1].int, let second2 = items2[1].int else {
        return .orderedSame
    }
    if second1 > second2 {
        return .orderedDescending
    } else if second1 < second2 {
        return .orderedAscending
    }
    guard let third1 = items1[2].int, let third2 = items2[2].int else {
        return .orderedSame
    }
    if third1 > third2 {
        return .orderedDescending
    } else if third1 < third2 {
        return .orderedAscending
    }
    return .orderedSame
}


// value - 375标准
//public func metric(_ value: CGFloat) -> CGFloat {
//    (value / 375.f * UIScreen.width).flat
//}

// value - 375标准
public func metric(
    _ value: CGFloat,
    small: CGFloat = .greatestFiniteMagnitude,
    middle: CGFloat = .greatestFiniteMagnitude,
    large: CGFloat = .greatestFiniteMagnitude
) -> CGFloat {
    if isSmallScreen {
        return small != .greatestFiniteMagnitude ? small : (value / 375.f * deviceWidth).flat
    }
    if isMiddleScreen {
        return middle != .greatestFiniteMagnitude ? middle : (value / 375.f * deviceWidth).flat
    }
    if isLargeScreen {
        return large != .greatestFiniteMagnitude ? large : (value / 375.f * deviceWidth).flat
    }
    return (value / 375.f * deviceWidth).flat
}

//public func metric(regular: CGFloat, notched: CGFloat) -> CGFloat {
//    UIScreen.isNotched ? notched : regular
//}

public func metric(small: CGFloat, middle: CGFloat, large: CGFloat) -> CGFloat {
    if isSmallScreen {
        return small
    }
    if isMiddleScreen {
        return middle
    }
    if isLargeScreen {
        return large
    }
    return middle
}

public func connectedToInternet() -> Observable<Bool> {
    return reachSubject.asObservable()
        .filter { $0 != .unknown }
        .distinctUntilChanged()
        .map { status -> Bool in
            switch status {
            case .reachable: return true
            default: return false
        }
    }
}

/// 将所有屏幕按照宽松/紧凑分类，其中 iPad、iPhone XS Max/XR/Plus 均为宽松屏幕，但开启了放大模式的设备均会视为紧凑屏幕
public func preferredValue(regular: CGFloat, compact: CGFloat) -> CGFloat {
    SWHelper.isRegularScreen ? regular : compact
}

/// 将所有屏幕按照 Phone/Pad 分类，由于历史上宽高比最大（最胖）的手机为 iPhone 4，所以这里以它为基准，只要宽高比比 iPhone 4 更小的，都视为 Phone，其他情况均视为 Pad。注意 iPad 分屏则取分屏后的宽高来计算。
public func preferredValue(phone: CGFloat, pad: CGFloat) -> CGFloat {
    (applicationWidth / applicationHeight <= SWHelper.screenSizeFor35Inch.width / SWHelper.screenSizeFor35Inch.height ? phone : pad)
}

/// 区分全面屏和非全面屏
public func preferredValue(notched: CGFloat, other: CGFloat) -> CGFloat {
    SWHelper.isNotchedScreen ? notched : other
}
