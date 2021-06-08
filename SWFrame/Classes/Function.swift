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

// MARK: - Dictionary member
public func boolMember(_ params: [String: Any]?, _ key: String, _ default: Bool) -> Bool {
    guard let params = params else { return `default` }
    return (params[key] as? Bool) ??
    ((params[key] as? String)?.bool) ??
    ((params[key] as? Int)?.bool) ??
        `default`
}

public func stringMember(_ params: [String: Any]?, _ key: String, _ default: String?) -> String? {
    guard let params = params else { return `default` }
    return (params[key] as? String) ??
    ((params[key] as? Int)?.string) ??
        `default`
}

public func intMember(_ params: [String: Any]?, _ key: String, _ default: Int?) -> Int? {
    guard let params = params else { return `default` }
    return (params[key] as? Int) ??
    ((params[key] as? String)?.int) ??
        `default`
}

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

public func modelMember<Model: ModelType>(_ params: [String: Any]?, _ key: String, _ type: Model.Type) -> Model? {
    guard let string = stringMember(params, key, nil) else { return nil }
    guard let base64 = string.base64Decoded else { return nil }
    guard let model = Model.init(JSONString: base64) else { return nil }
    return model
}

public func enumMember<T: RawRepresentable>(
    _ params: [String: Any]?,
    _ key: String,
    _ type: T.Type
) -> T? where T.RawValue == String {
    guard let string = stringMember(params, key, nil) else { return nil }
    guard let value = T.init(rawValue: string) else { return nil }
    return value
}

public func enumMember<T: RawRepresentable>(
    _ params: [String: Any]?,
    _ key: String,
    _ type: T.Type
) -> T? where T.RawValue == Int {
    guard let int = intMember(params, key, nil) else { return nil }
    guard let value = T.init(rawValue: int) else { return nil }
    return value
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

