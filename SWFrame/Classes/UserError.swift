//
//  UserError.swift
//  SWFrame
//
//  Created by liaoya on 2021/1/6.
//

import Foundation

public enum UserError: Error {
    case notLogin                   // 未登录
    case loginExpired               // 登录过期
}

extension UserError: CustomNSError {
    public static let domain = "com.tospery.swframe.error.user"
    public var errorCode: Int {
        switch self {
        case .notLogin:         return 3001
        case .loginExpired:     return 3002
        }
    }
}

extension UserError: LocalizedError {
    public var failureReason: String? {
        NSLocalizedString("Error.User.Title", value: "用户异常", comment: "")
    }
    public var errorDescription: String? {
        NSLocalizedString("Error.User.Message", value: "用户异常", comment: "")
    }
    public var recoverySuggestion: String? {
        NSLocalizedString("Error.Retry", value: "重试", comment: "")
    }
}

extension UserError: SWCompatibleError {
    public var isNetwork: Bool { false }
    public var isServer: Bool { false }
    public var isUserExpired: Bool { self == .loginExpired }
}
