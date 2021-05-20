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

// MARK: - Dictionary member
public func colorMember(_ params: Dictionary<String, Any>?, _ key: String, _ default: UIColor?) -> UIColor? {
    if let value = params?[key] as? String, let color = UIColor(hexString: value) {
        return color
    }
    return `default`
}

public func urlMember(_ params: Dictionary<String, Any>?, _ key: String, _ default: URL?) -> URL? {
    if let value = params?[key] as? String, let url = URL(string: value) {
        return url
    }
    return `default`
}

public func arrayMember(_ params: Dictionary<String, Any>?, _ key: String, _ default: Array<Any>?) -> Array<Any>? {
    if let value = params?[key] as? Array<Any> {
        return value
    }
    return `default`
}

// value - 375标准
public func metric(_ value: CGFloat) -> CGFloat {
    (value / 375.f * UIScreen.width).flat
}

public func metric(_ value: CGFloat, small: CGFloat) -> CGFloat {
    switch UIScreen.kind {
    case .small: return small
    default: return value
    }
}

public func metric(_ value: CGFloat, large: CGFloat) -> CGFloat {
    switch UIScreen.kind {
    case .large: return large
    default: return value
    }
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
        .ignore(.unknown)
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

