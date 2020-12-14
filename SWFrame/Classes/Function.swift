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
    return flat(value / 375.f * UIScreen.width)
}

public func metric(small: CGFloat, middle: CGFloat, large: CGFloat) -> CGFloat {
    if isSmallWidthScreen {
        return small
    }
    if isLargeWidthScreen {
        return large
    }
    return middle
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
    return (isNotchedScreen ? notched : other)
}

public func alternate(regular: CGFloat, compact: CGFloat) -> CGFloat {
    return (QMUIHelper.isRegularScreen() ? regular : compact)
}

public func log(
    _ message: @autoclosure () -> Any,
    level: DDLogLevel = DDDefaultLogLevel,
    flag: DDLogFlag = .debug,
    context: Int = 0,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line,
    tag: Any? = nil,
    asynchronous async: Bool = asyncLoggingEnabled,
    ddlog: DDLog = .sharedInstance
) {
    _DDLogMessage(
        message(),
        level: level,
        flag: flag,
        context: context,
        file: file,
        function: function,
        line: line,
        tag: tag,
        asynchronous: async,
        ddlog: ddlog
    )
}
