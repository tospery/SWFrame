//
//  SWError.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation

public struct ErrorCode {
    public static let ok                        = 200
    public static let serverUnableConnect       = -10001
    public static let serverInternalError       = -10002
    public static let serverNoResponse          = -10003
    public static let nserror                   = -20001
    public static let skerror                   = -20002
    public static let rxerror                   = -20003
    public static let aferror                   = -20004
    public static let moyaError                 = -20005
    public static let appError                  = -30000
}

public enum SWError: Error {
    case none
    case unknown
    case timeout
    case navigation
    case dataFormat
    case listIsEmpty
    case userNotLoginedIn
    case userLoginExpired
    case networkNotConnected
    case networkNotReachable
    case server(Int, String?)
    case app(Int, String?)
}

extension SWError: CustomNSError {
    public static let domain = Bundle.main.bundleIdentifier ?? ""
    public var errorCode: Int {
        switch self {
        case .none: return 0
        case .unknown: return 1
        case .timeout: return 2
        case .navigation: return 3
        case .dataFormat: return 4
        case .listIsEmpty: return 5
        case .userNotLoginedIn: return 6
        case .userLoginExpired: return 7
        case .networkNotConnected: return 8
        case .networkNotReachable: return 9
        case let .server(code, _): return code
        case let .app(code, _): return code
        }
    }
}

extension SWError: LocalizedError {
    /// 概述
    public var failureReason: String? {
        switch self {
        case .none:
            return NSLocalizedString("Error.None.Title", value: "", comment: "")
        case .unknown:
            return NSLocalizedString("Error.Unknown.Title", value: "", comment: "")
        case .timeout:
            return NSLocalizedString("Error.Timeout.Title", value: "", comment: "")
        case .navigation:
            return NSLocalizedString("Error.Navigation.Title", value: "", comment: "")
        case .dataFormat:
            return NSLocalizedString("Error.DataFormat.Title", value: "", comment: "")
        case .listIsEmpty:
            return NSLocalizedString("Error.ListIsEmpty.Title", value: "", comment: "")
        case .userNotLoginedIn:
            return NSLocalizedString("Error.UserNotLoginedIn.Title", value: "", comment: "")
        case .userLoginExpired:
            return NSLocalizedString("Error.UserLoginExpired.Title", value: "", comment: "")
        case .networkNotConnected:
            return NSLocalizedString("Error.NetworkNotConnected.Title", value: "", comment: "")
        case .networkNotReachable:
            return NSLocalizedString("Error.NetworkNotReachable.Title", value: "", comment: "")
        case .server:
            return NSLocalizedString("Error.Server.Title", value: "", comment: "")
        case .app:
            return NSLocalizedString("Error.App.Title", value: "", comment: "")
        }
    }
    /// 详情
    public var errorDescription: String? {
        switch self {
        case .none:
            return NSLocalizedString("Error.None.Message", value: "", comment: "")
        case .unknown:
            return NSLocalizedString("Error.Unknown.Message", value: "", comment: "")
        case .timeout:
            return NSLocalizedString("Error.Timeout.Message", value: "", comment: "")
        case .navigation:
            return NSLocalizedString("Error.Navigation.Message", value: "", comment: "")
        case .dataFormat:
            return NSLocalizedString("Error.DataFormat.Message", value: "", comment: "")
        case .listIsEmpty:
            return NSLocalizedString("Error.ListIsEmpty.Message", value: "", comment: "")
        case .userNotLoginedIn:
            return NSLocalizedString("Error.UserNotLoginedIn.Message", value: "", comment: "")
        case .userLoginExpired:
            return NSLocalizedString("Error.UserLoginExpired.Message", value: "", comment: "")
        case .networkNotConnected:
            return NSLocalizedString("Error.NetworkNotConnected.Message", value: "", comment: "")
        case .networkNotReachable:
            return NSLocalizedString("Error.NetworkNotReachable.Message", value: "", comment: "")
        case let .server(code, message):
            return message ?? NSLocalizedString("Error.Server.Message\(code)", value: "", comment: "")
        case let .app(code, message):
            return message ?? NSLocalizedString("Error.App.Message\(code)", value: "", comment: "")
        }
    }
    /// 重试
    public var recoverySuggestion: String? {
        var suggestion: String?
        switch self {
        case let .app(code, _):
            suggestion = NSLocalizedString("Error.App.Suggestion\(code)", value: "", comment: "")
        default:
            break
        }
        if suggestion?.hasPrefix("Error.") ?? false {
            suggestion = nil
        }
        return suggestion
    }
}

extension SWError: Equatable {
    public static func == (lhs: SWError, rhs: SWError) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none),
             (.unknown, .unknown),
            (.timeout, .timeout),
             (.navigation, .navigation),
             (.dataFormat, .dataFormat),
             (.listIsEmpty, .listIsEmpty),
             (.userNotLoginedIn, .userNotLoginedIn),
            (.userLoginExpired, .userLoginExpired),
            (.networkNotConnected, .networkNotConnected),
            (.networkNotReachable, .networkNotReachable):
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
        case .none: return "SWError.none"
        case .unknown: return "SWError.unknown"
        case .timeout: return "SWError.timeout"
        case .navigation: return "SWError.navigation"
        case .dataFormat: return "SWError.dataFormat"
        case .listIsEmpty: return "SWError.listIsEmpty"
        case .userNotLoginedIn: return "SWError.userNotLoginedIn"
        case .userLoginExpired: return "SWError.userLoginExpired"
        case .networkNotConnected: return "SWError.networkNotConnected"
        case .networkNotReachable: return "SWError.networkNotReachable"
//        case .serverCantEnable: return "SWError.serverCantEnable"
//        case .serverNoResponse: return "SWError.serverNoResponse"
        case let .server(code, message): return "SWError.server(\(code), \(message ?? ""))"
        case let .app(code, message): return "SWError.app(\(code), \(message ?? ""))"
        }
    }
}

extension SWError {
    
//    public var isNetwork: Bool {
//        self == .network
//    }
//
//    public var isServer: Bool {
//        if case .server = self {
//            return true
//        }
//        return false
//    }
//
//    public var isCancel: Bool {
//        self == .cancel
//    }
//
//    public var isListIsEmpty: Bool {
//        self == .listIsEmpty
//    }
//
//    public var isNotLoginedIn: Bool {
//        self == .userNotLoginedIn
//    }
    
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
