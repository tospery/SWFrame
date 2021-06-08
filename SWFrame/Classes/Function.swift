//
//  Function.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import QMUIKit
import RxSwift
import CocoaLumberjack

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
    #if DEBUG
    logger.print("compareAny\n\(leftString)\n\(rightString)", module: .swframe)
    #endif
    return leftString == rightString
}

// value - 375标准
public func metric(_ value: CGFloat) -> CGFloat {
    (value / 375.f * UIScreen.width).flat
}

public func metric(_ value: CGFloat, notched: CGFloat) -> CGFloat {
    UIScreen.isNotched ? notched : value
}

public func metric(_ value: CGFloat, small: CGFloat) -> CGFloat {
    UIScreen.isSmall ? small : value
}

public func metric(_ value: CGFloat, large: CGFloat) -> CGFloat {
    UIScreen.isLarge ? large : value
}

public func metric(small: CGFloat, middle: CGFloat, large: CGFloat) -> CGFloat {
    switch UIScreen.kind {
    case .small: return small
    case .middle: return middle
    case .large: return large
    }
}

public func fontSize(_ value: CGFloat) -> CGFloat {
    (value / 375.f * UIScreen.width).flat
}

public func fontSize(small: CGFloat, middle: CGFloat, large: CGFloat) -> CGFloat {
    switch UIScreen.kind {
    case .small: return small
    case .middle: return middle
    case .large: return large
    }
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

// 区分全面屏（iPhone X 系列）和非全面屏
public func alternate(notched: CGFloat, other: CGFloat) -> CGFloat {
    return (UIScreen.isNotched ? notched : other)
}

// 区分紧凑屏
public func alternate(regular: CGFloat, compact: CGFloat) -> CGFloat {
    return (UIScreen.isRegular ? regular : compact)
}

