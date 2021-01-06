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

public enum SWErrorNetworkCode: Int {
    case disabled = 1001            // 没有网络
    case unreachable                // 不可达
}

public enum SWErrorUserCode: Int {
    case notLogin = 3001            // 未登录
    case loginExpired               // 登录过期
}

//public enum SWErrorAppCode: Int {
//    case navigation = 4001          // 导航错误
//}

public enum SWError: Error {
    case network(Int, String?)  // 1000~1999
    case server(Int, String?)   // 2000~2999
    case user(Int, String?)     // 3000~3999
    case app(Int, String?)      // 4009~4999（预留4100）
}

extension SWError: CustomNSError {
    
    public static let domain = "com.tospery.swframe.error"

    public var errorCode: Int {
        switch self {
        case let .network(code, _): return code
        case let .server(code, _): return code
        case let .user(code, _): return code
        case let .app(code, _): return code
        }
    }
    
}

extension SWError: LocalizedError {
    /// 概要
    public var failureReason: String? {
        switch self {
        case .network: return NSLocalizedString("Error.Network.Title", value: "网络错误", comment: "")
        case .server: return NSLocalizedString("Error.Server.Title", value: "服务异常", comment: "")
        case .user: return NSLocalizedString("Error.User.Title", value: "用户异常", comment: "")
        case .app: return NSLocalizedString("Error.App.Title", value: "操作错误", comment: "")
        }
    }
    /// 详情
    public var errorDescription: String? {
        switch self {
        case let .network(_, message):
            return message ?? NSLocalizedString("Error.Network.Message", value: "网络错误", comment: "")
        case let .server(_, message):
            return message ?? NSLocalizedString("Error.Server.Message", value: "服务异常", comment: "")
        case let .user(_, message):
            return message ?? NSLocalizedString("Error.User.Message", value: "用户异常", comment: "")
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
        case let (.network(code1, _), .network(code2, _)):
            return code1 == code2
        case let (.server(code1, _), .server(code2, _)):
            return code1 == code2
        case let (.user(code1, _), .user(code2, _)):
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
        case let .network(code, message): return "SWError.network(\(code), \(message))"
        case let .server(code, message): return "SWError.server(\(code), \(message))"
        case let .user(code, message): return "SWError.user(\(code), \(message))"
        case let .app(code, message): return "SWError.app(\(code), \(message))"
        }
    }
}

extension SWError: SWCompatibleError {
    public var isNetwork: Bool {
        switch self {
        case .network: return true
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
        return self == .user(SWErrorUserCode.loginExpired.rawValue, nil)
    }
}
