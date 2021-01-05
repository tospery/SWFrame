//
//  SWError.swift
//  SWFrame
//
//  Created by liaoya on 2021/1/5.
//

import Foundation
import RxSwift
import Moya

public protocol SWErrorCompatible {
    var asSWError: SWError { get }
}

public enum SWError: Error {
    case network(Int, String?)  // 100~199
    case server(Int, String?)   // 200~299
    case user(Int, String?)     // 300~399
    case app(Int, String?)      // 400~499
}

extension SWError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .network(_, message):
            return message ?? NSLocalizedString("Error.Network.Message", value: "网络错误", comment: "")
        case let .server(_, message):
            return message ?? NSLocalizedString("Error.Server.Message", value: "服务异常", comment: "")
        case let .user(_, message):
            return message ?? "用户异常"
        case let .app(_, message):
            return message ?? "操作错误"
        }
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
