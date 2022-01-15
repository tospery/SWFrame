//
//  SWError.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation

public let StatusCodeOK = 200

public enum SWError: Error {
    case cancel
    case unknown
    case network
    case navigation
    case dataFormat
    case listIsEmpty
    case notLoginedIn
    case server(Int, String?)
    case app(Int, String?)
}

extension SWError: CustomNSError {
    public static let domain = Bundle.main.bundleIdentifier ?? ""
    public var errorCode: Int {
        switch self {
        case .cancel: return 1
        case .unknown: return 2
        case .network: return 3
        case .navigation: return 4
        case .dataFormat: return 5
        case .listIsEmpty: return 6
        case .notLoginedIn: return 7
        case let .server(code, _): return code
        case let .app(code, _): return code
        }
    }
}

extension SWError: LocalizedError {
    /// 概述
    public var failureReason: String? {
        switch self {
        case .cancel: return NSLocalizedString("Error.Cancel.Title", value: "", comment: "")
        case .unknown: return NSLocalizedString("Error.Unknown.Title", value: "", comment: "")
        case .network: return NSLocalizedString("Error.Network.Title", value: "", comment: "")
        case .navigation: return NSLocalizedString("Error.Navigation.Title", value: "", comment: "")
        case .dataFormat: return NSLocalizedString("Error.DataFormat.Title", value: "", comment: "")
        case .listIsEmpty: return NSLocalizedString("Error.ListIsEmpty.Title", value: "", comment: "")
        case .notLoginedIn: return NSLocalizedString("Error.NotLoginedIn.Title", value: "", comment: "")
        case .server: return NSLocalizedString("Error.Server.Title", value: "", comment: "")
        case .app: return NSLocalizedString("Error.App.Title", value: "", comment: "")
        }
    }
    /// 详情
    public var errorDescription: String? {
        switch self {
        case .cancel: return NSLocalizedString("Error.Cancel.Message", value: "", comment: "")
        case .unknown: return NSLocalizedString("Error.Unknown.Message", value: "未知错误", comment: "")
        case .network: return NSLocalizedString("Error.Network.Message", value: "网络错误", comment: "")
        case .navigation: return NSLocalizedString("Error.Navigation.Message", value: "导航错误", comment: "")
        case .dataFormat: return NSLocalizedString("Error.DataFormat.Message", value: "数据异常", comment: "")
        case .listIsEmpty: return NSLocalizedString("Error.ListIsEmpty.Message", value: "列表为空", comment: "")
        case .notLoginedIn: return NSLocalizedString("Error.NotLoginedIn.Message", value: "用户未登录", comment: "")
        case let .server(_, message): return message ?? NSLocalizedString("Error.Server.Message", value: "服务异常", comment: "")
        case let .app(_, message): return message ?? NSLocalizedString("Error.App.Message", value: "非法操作", comment: "")
        }
    }
    /// 重试
    public var recoverySuggestion: String? {
        switch self {
        case .network: return NSLocalizedString("Error.Network.Suggestion", value: NSLocalizedString("Retry", value: "重试", comment: ""), comment: "")
        default: return NSLocalizedString("Retry", value: "重试", comment: "")
        }
    }
}

extension SWError: Equatable {
    public static func == (lhs: SWError, rhs: SWError) -> Bool {
        switch (lhs, rhs) {
        case (.cancel, .cancel),
             (.unknown, .unknown),
             (.network, .network),
             (.navigation, .navigation),
             (.dataFormat, .dataFormat),
             (.listIsEmpty, .listIsEmpty),
             (.notLoginedIn, .notLoginedIn):
            return true
        case (.server(let left, _), .server(let right, _)),
             (.app(let left, _), .app(let right, _)):
            return left == right
        default: return false
        }
    }
}

extension SWError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .cancel: return "SWError.cancel"
        case .unknown: return "SWError.unknown"
        case .network: return "SWError.network"
        case .navigation: return "SWError.navigation"
        case .dataFormat: return "SWError.dataFormat"
        case .listIsEmpty: return "SWError.listIsEmpty"
        case .notLoginedIn: return "SWError.notLoginedIn"
        case let .server(code, message): return "SWError.server(\(code), \(message ?? ""))"
        case let .app(code, message): return "SWError.app(\(code), \(message ?? ""))"
        }
    }
}

extension SWError {
    
    public var isNetwork: Bool {
        self == .network
    }
    
    public var isServer: Bool {
        if case .server = self {
            return true
        }
        return false
    }
    
    public var isCancel: Bool {
        self == .cancel
    }
    
    public var isListIsEmpty: Bool {
        self == .listIsEmpty
    }
    
    public var isNotLoginedIn: Bool {
        self == .notLoginedIn
    }
    
    public func isServerError(withCode errorCode: Int) -> Bool {
        if case let .server(code, _) = self {
            return errorCode == code
        }
        return false
    }
    
    public func isAppError(withCode errorCode: Int) -> Bool {
        if case let .app(code, _) = self {
            return errorCode == code
        }
        return false
    }
    
}

public protocol SWErrorCompatible: Error {
    var swError: SWError { get }
}

extension SWErrorCompatible {
    public var swError: SWError {
        .server(0, nil)
    }
}

extension Error {
    
    public var asSWError: SWError {
        if let sw = self as? SWError {
            return sw
        }
        if let compatible = self as? SWErrorCompatible {
            return compatible.swError
        }
        return .server(0, self.localizedDescription)
    }

}
