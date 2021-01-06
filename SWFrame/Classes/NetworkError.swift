//
//  NetworkError.swift
//  SWFrame
//
//  Created by liaoya on 2021/1/6.
//

import Foundation

public enum NetworkError: Error {
    case disabled                   // 没有网络
    case unreachable                // 不可达
}

extension NetworkError: CustomNSError {
    public static let domain = "com.tospery.swframe.error.network"
    public var errorCode: Int {
        switch self {
        case .disabled:     return 1001
        case .unreachable:  return 1002
        }
    }
}

extension NetworkError: LocalizedError {
    public var failureReason: String? {
        NSLocalizedString("Error.Network.Title", value: "网络错误", comment: "")
    }
    public var errorDescription: String? {
        NSLocalizedString("Error.Network.Message", value: "网络错误", comment: "")
    }
    public var recoverySuggestion: String? {
        NSLocalizedString("Error.Retry", value: "重试", comment: "")
    }
}

extension NetworkError: SWCompatibleError {
    public var isNetwork: Bool { true }
    public var isServer: Bool { false }
    public var isUserExpired: Bool { false }
}
