//
//  UserError.swift
//  SWFrame
//
//  Created by liaoya on 2021/4/14.
//

import Foundation

public enum UserError: Error {
    case notLoggedIn
    case loginExpired
}

extension UserError: CustomNSError {
    public static let domain = "com.swframe.error.user"
    public var errorCode: Int {
        switch self {
        case .notLoggedIn: return 1
        case .loginExpired: return 2
        }
    }
}

extension UserError: LocalizedError {
    public var failureReason: String? {
        switch self {
        case .notLoggedIn:
            return NSLocalizedString("Error.User.NotLoggedIn.Title", value: "用户未登录", comment: "")
        case .loginExpired:
            return NSLocalizedString("Error.User.LoginExpired.Title", value: "用户登录过期", comment: "")
        }
    }
    /// 详情
    public var errorDescription: String? {
        switch self {
        case .notLoggedIn:
            return NSLocalizedString("Error.User.NotLoggedIn.Message", value: "用户未登录", comment: "")
        case .loginExpired:
            return NSLocalizedString("Error.User.LoginExpired.Message", value: "用户登录过期", comment: "")
        }
    }
    /// 重试
    public var recoverySuggestion: String? {
        NSLocalizedString("Error.Retry", value: "重试", comment: "")
    }
}

extension UserError: Equatable {
    public static func == (lhs: UserError, rhs: UserError) -> Bool {
        switch (lhs, rhs) {
        case (.notLoggedIn, .notLoggedIn),
             (.loginExpired, .loginExpired):
            return true
        default:
            return false
        }
    }
}

extension UserError: SWCompatibleError {
    public var swError: SWError {
        .user(self.errorCode)
    }
}
