//
//  SystemError.swift
//  SWFrame
//
//  Created by liaoya on 2021/4/14.
//

import Foundation

public enum SystemError: Error {
    case unknown
    case navigation
    case dataFormat
    case listIsEmpty
}

extension SystemError: CustomNSError {
    public static let domain = "com.swframe.error.system"
    public var errorCode: Int {
        switch self {
        case .unknown: return 1
        case .navigation: return 2
        case .dataFormat: return 3
        case .listIsEmpty: return 4
        }
    }
}

extension SystemError: LocalizedError {
    public var failureReason: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("Error.System.Unknown.Title", value: "未知错误", comment: "")
        case .navigation:
            return NSLocalizedString("Error.System.Navigation.Title", value: "导航错误", comment: "")
        case .dataFormat:
            return NSLocalizedString("Error.System.DataFormat.Title", value: "数据格式异常", comment: "")
        case .listIsEmpty:
            return NSLocalizedString("Error.System.ListIsEmpty.Title", value: "列表为空", comment: "")
        }
    }
    /// 详情
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("Error.System.Unknown.Message", value: "导航错误", comment: "")
        case .navigation:
            return NSLocalizedString("Error.System.Navigation.Message", value: "导航错误", comment: "")
        case .dataFormat:
            return NSLocalizedString("Error.System.DataFormat.Message", value: "数据格式异常", comment: "")
        case .listIsEmpty:
            return NSLocalizedString("Error.System.ListIsEmpty.Message", value: "列表为空", comment: "")
        }
    }
    /// 重试
    public var recoverySuggestion: String? {
        NSLocalizedString("Error.Retry", value: "重试", comment: "")
    }
}

extension SystemError: Equatable {
    public static func == (lhs: SystemError, rhs: SystemError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown),
             (.navigation, .navigation),
             (.dataFormat, .dataFormat),
             (.listIsEmpty, .listIsEmpty):
            return true
        default:
            return false
        }
    }
}

extension SystemError: SWCompatibleError {
    public var swError: SWError {
        .system(self.errorCode)
    }
}
