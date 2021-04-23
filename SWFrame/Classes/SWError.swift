//
//  SWError.swift
//  SWFrame
//
//  Created by liaoya on 2021/1/5.
//

import Foundation
import RxSwift
import Moya

public enum SWError: Error {
    case network
    case unlogin
    case system(Int)
    case server(Int, String?)
    case app(Int, String?)
    
    var asSystemError: SystemError? {
        switch self {
        case let .system(code):
            switch code {
            case SystemError.navigation.errorCode: return .navigation
            case SystemError.dataFormat.errorCode: return .dataFormat
            case SystemError.listIsEmpty.errorCode: return .listIsEmpty
            default: return nil
            }
        default:
            return nil
        }
    }

}

extension SWError: CustomNSError {
    public static let domain = "com.swframe.error"
    public var errorCode: Int {
        switch self {
        case .network: return 1
        case .unlogin: return 2
        case let .system(code): return code
        case let .server(code, _): return code
        case let .app(code, _): return code
        }
    }
}

extension SWError: LocalizedError {
    /// 概述
    public var failureReason: String? {
        switch self {
        case .network: return NSLocalizedString("Error.Network.Title", value: "网络错误", comment: "")
        case .unlogin: return NSLocalizedString("Error.Unlogin.Title", value: "用户未登录", comment: "")
        case .system: return self.asSystemError?.failureReason
        case .server: return NSLocalizedString("Error.Server.Title", value: "服务异常", comment: "")
        case .app: return NSLocalizedString("Error.App.Title", value: "操作错误", comment: "")
        }
    }
    /// 详情
    public var errorDescription: String? {
        switch self {
        case .network: return NSLocalizedString("Error.Network.Message", value: "网络错误", comment: "")
        case .unlogin: return NSLocalizedString("Error.Unlogin.Message", value: "用户未登录", comment: "")
        case .system: return self.asSystemError?.errorDescription
        case let .server(_, message): return message ?? NSLocalizedString("Error.Server.Message", value: "服务异常", comment: "")
        case let .app(_, message): return message ?? NSLocalizedString("Error.App.Message", value: "操作错误", comment: "")
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
        case (.network, .network): return true
        case (.unlogin, .unlogin): return true
        case let (.system(code1), .system(code2)): return code1 == code2
        case let (.server(code1, _), .server(code2, _)): return code1 == code2
        case let (.app(code1, _), .app(code2, _)): return code1 == code2
        default: return false
        }
    }
}

extension SWError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .network: return "SWError.network"
        case .unlogin: return "SWError.unlogin"
        case let .system(code): return "SWError.system(\(code))"
        case let .server(code, message): return "SWError.server(\(code), \(message))"
        case let .app(code, message): return "SWError.app(\(code), \(message))"
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
    public var isUnlogin: Bool {
        self == .unlogin
    }
    public var displayImage: UIImage? {
        if self.isNetwork {
            return UIImage.networkError
        } else if self.isServer {
            return UIImage.serverError
        } else if self.isUnlogin {
            return UIImage.expireError
        }
        return nil
    }
}
