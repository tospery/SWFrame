//
//  SystemError.swift
//  SWFrame
//
//  Created by liaoya on 2021/4/14.
//

import Foundation

public enum SystemError: Error {
    case navigation
    case dataFormat
    case listIsEmpty
}

extension SystemError: CustomNSError {
    public static let domain = "com.swframe.error.system"
    public var errorCode: Int {
        switch self {
        case .navigation: return 1
        case .dataFormat: return 2
        case .listIsEmpty: return 3
        }
    }
}

extension SystemError: LocalizedError {
    public var failureReason: String? {
        switch self {
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
        case (.navigation, .navigation),
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
