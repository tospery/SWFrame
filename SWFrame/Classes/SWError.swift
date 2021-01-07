//
//  SWError.swift
//  SWFrame
//
//  Created by liaoya on 2021/1/5.
//

import Foundation
import RxSwift
import Moya

public protocol SWCompatibleError : Error {
    var isNetwork: Bool { get }
    var isServer: Bool { get }
    var isUserExpired: Bool { get }
    var displayImage: UIImage? { get }
}

extension SWCompatibleError {
    public var isNetwork: Bool { false }
    public var isServer: Bool { false }
    public var isUserExpired: Bool { false }
    public var displayImage: UIImage? {
        if self.isNetwork {
            return UIImage.networkError
        } else if self.isServer {
            return UIImage.serverError
        } else if self.isUserExpired {
            return UIImage.expireError
        }
        return nil
    }
}

public enum SWError: Error {
    case networkDisabled
    case networkUnreachable
    case userNotLogin
    case userLoginExpired
    case navigationException
    case server(Int, String?)
    case app(Int, String?)
}

extension SWError: CustomNSError {
    public static let domain = "com.tospery.swframe.error"
    public var errorCode: Int {
        switch self {
        case .networkDisabled: return 10001
        case .networkUnreachable: return 10002
        case .userNotLogin: return 10003
        case .userLoginExpired: return 10004
        case .navigationException: return 10005
        case let .server(code, _): return code
        case let .app(code, _): return code
        }
    }
}

extension SWError: LocalizedError {
    /// 概述
    public var failureReason: String? {
        switch self {
        case .networkDisabled:
            return NSLocalizedString("Error.Network.Title", value: "网络错误", comment: "")
        case .networkUnreachable:
            return NSLocalizedString("Error.Network.Title", value: "网络错误", comment: "")
        case .userNotLogin:
            return NSLocalizedString("Error.User.Title", value: "用户异常", comment: "")
        case .userLoginExpired:
            return NSLocalizedString("Error.User.Title", value: "用户异常", comment: "")
        case .navigationException:
            return NSLocalizedString("Error.Navigation.Title", value: "导航异常", comment: "")
        case .server:
            return NSLocalizedString("Error.Server.Title", value: "服务异常", comment: "")
        case .app:
            return NSLocalizedString("Error.App.Title", value: "操作错误", comment: "")
        }
    }
    /// 详情
    public var errorDescription: String? {
        switch self {
        case .networkDisabled:
            return NSLocalizedString("Error.Network.Message", value: "网络错误", comment: "")
        case .networkUnreachable:
            return NSLocalizedString("Error.Network.Message", value: "网络错误", comment: "")
        case .userNotLogin:
            return NSLocalizedString("Error.User.Message", value: "用户异常", comment: "")
        case .userLoginExpired:
            return NSLocalizedString("Error.User.Message", value: "用户异常", comment: "")
        case .navigationException:
            return NSLocalizedString("Error.Navigation.Message", value: "导航异常", comment: "")
        case let .server(_, message):
            return message ?? NSLocalizedString("Error.Server.Message", value: "服务异常", comment: "")
        case let .app(_, message):
            return message ?? NSLocalizedString("Error.App.Message", value: "操作错误", comment: "")
        }
    }
    /// 重试
    public var recoverySuggestion: String? {
        NSLocalizedString("Error.Retry", value: "重试", comment: "")
    }
}

extension SWError: Equatable {
    public static func == (lhs: SWError, rhs: SWError) -> Bool {
        switch (lhs, rhs) {
        case (.networkDisabled, .networkDisabled),
             (.networkUnreachable, .networkUnreachable),
             (.userNotLogin, .userNotLogin),
             (.userLoginExpired, .userLoginExpired),
             (.navigationException, .navigationException):
            return true
        case let (.server(code1, _), .server(code2, _)):
            return code1 == code2
        case let (.app(code1, _), .app(code2, _)):
            return code1 == code2
        default:
            return false
        }
    }
}

extension SWError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .networkDisabled:
            return "SWError.networkDisabled"
        case .networkUnreachable:
            return "SWError.networkUnreachable"
        case .userNotLogin:
            return "SWError.userNotLogin"
        case .userLoginExpired:
            return "SWError.userLoginExpired"
        case .navigationException:
            return "SWError.navigationException"
        case let .server(code, message):
            return "SWError.server(\(code), \(message))"
        case let .app(code, message):
            return "SWError.app(\(code), \(message))"
        }
    }
}

extension SWError: SWCompatibleError {
    public var isNetwork: Bool {
        switch self {
        case .networkDisabled, .networkUnreachable: return true
        default: return false
        }
    }
    public var isServer: Bool {
        switch self {
        case .server: return true
        default: return false
        }
    }
    public var isUserExpired: Bool {
        return self == .userLoginExpired
    }
}
