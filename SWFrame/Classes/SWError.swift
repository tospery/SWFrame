//
//  DemoError.swift
//  SWFrame
//
//  Created by liaoya on 2021/1/5.
//

import Foundation
import RxSwift
import Moya

public protocol SWError : Error {
    var isNetwork: Bool { get }
    var isServer: Bool { get }
    var isUserExpired: Bool { get }
    var displayImage: UIImage? { get }
}

extension NSError: SWError {
    public var isNetwork: Bool {
        self.domain == NSURLErrorDomain
    }
    public var isServer: Bool {
        self.code == 500
    }
    public var isUserExpired: Bool {
        self.code == 401
    }
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

//extension SWError {
//}

public enum DemoError: Error {
    case network(Int, String?)  // 100~199
    case server(Int, String?)   // 200~299
    case action(Int, String?)   // 300~399
    case user(Int, String?)     // 400~499
    
    public static let NetworkUnreachableCode    = 100
    public static let UserNotLoginCode          = 400
    public static let UserExpiredCode           = 401
}

extension DemoError: CustomNSError {
    
    public static let domain = "com.tospery.swframe.error"

    public var errorCode: Int {
        switch self {
        case let .network(code, _): return code
        case let .server(code, _): return code
        case let .action(code, _): return code
        case let .user(code, _): return code
        }
    }
    
}

extension DemoError: LocalizedError {
    /// 概要
    public var failureReason: String? {
        switch self {
        case .network: return NSLocalizedString("Error.Network.Title", value: "网络错误", comment: "")
        case .server: return NSLocalizedString("Error.Server.Title", value: "服务异常", comment: "")
        case .action: return NSLocalizedString("Error.Action.Title", value: "操作错误", comment: "")
        case .user: return NSLocalizedString("Error.User.Title", value: "用户异常", comment: "")
        }
    }
    /// 详情
    public var errorDescription: String? {
        switch self {
        case let .network(_, message):
            return message ?? NSLocalizedString("Error.Network.Message", value: "网络错误", comment: "")
        case let .server(_, message):
            return message ?? NSLocalizedString("Error.Server.Message", value: "服务异常", comment: "")
        case let .action(_, message):
            return message ?? NSLocalizedString("Error.Action.Message", value: "操作错误", comment: "")
        case let .user(_, message):
            return message ?? NSLocalizedString("Error.User.Message", value: "用户异常", comment: "")
        }
    }
    /// 重试
    public var recoverySuggestion: String? {
        NSLocalizedString("Error.Retry", value: "重试", comment: "")
    }
}

extension DemoError: Equatable {
    public static func == (lhs: DemoError, rhs: DemoError) -> Bool {
        switch (lhs, rhs) {
        case let (.network(code1, _), .network(code2, _)):
            return code1 == code2
        case let (.server(code1, _), .server(code2, _)):
            return code1 == code2
        case let (.action(code1, _), .action(code2, _)):
            return code1 == code2
        case let (.user(code1, _), .user(code2, _)):
            return code1 == code2
        default:
            return false
        }
    }
}

extension DemoError: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .network(code, message): return "DemoError.network(\(code), \(message))"
        case let .server(code, message): return "DemoError.server(\(code), \(message))"
        case let .action(code, message): return "DemoError.action(\(code), \(message))"
        case let .user(code, message): return "DemoError.user(\(code), \(message))"
        }
    }
}

//public extension Error {
//    var isNetwork: Bool {
//        if let error = self as? DemoError {
//            switch error {
//            case .network: return true
//            default: return false
//            }
//        }
//        if (self as NSError).domain == NSURLErrorDomain {
//            return true
//        }
//        if let error = self as? APPError, error == .network {
//            return true
//        }
//        return false
//    }

//    var isServer: Bool {
//        if let error = self as? DemoError {
//            switch error {
//            case .server: return true
//            default: return false
//            }
//        }
//        if (self as NSError).code == 500 {
//            return true
//        }
//        if let error = self as? APPError {
//            switch error {
//            case .server:
//                return true
//            default:
//                return false
//            }
//        }
//        return false
//    }
//
//    var isExpired: Bool {
//        if let error = self as? DemoError {
//            switch error {
//            case let .user(302, _): return true
//            default: return false
//            }
//        }
//        if (self as NSError).code == 401 {
//            return true
//        }
//        if let error = self as? APPError, error == .expired {
//            return true
//        }
//        return false
//    }

//    var isIllegal: Bool {
//        if let error = self as? APPError {
//            switch error {
//            case .illegal:
//                return true
//            default:
//                return false
//            }
//        }
//        return false
//    }

//    var title: String? {
//        if self.isNetwork {
//            return NSLocalizedString("Error.Network.Title", comment: "")
//        } else if self.isServer {
//            return NSLocalizedString("Error.Server.Title", comment: "")
//        } else if self.isExpired {
//            return NSLocalizedString("Error.Expired.Title", comment: "")
//        }
//        return nil
//    }

//    var message: String {
//        if self.isNetwork {
//            return NSLocalizedString("Error.Network.Message", comment: "")
//        } else if self.isServer {
//            return NSLocalizedString("Error.Server.Message", comment: "")
//        } else if self.isExpired {
//            return NSLocalizedString("Error.Expired.Message", comment: "")
//        }
//        return self.localizedDescription
//    }
//
//    var retry: String? {
//        return NSLocalizedString("Error.Retry", comment: "")
//    }
//    var image: UIImage? {
//        if self.isNetwork {
//            return UIImage.networkError
//        } else if self.isServer {
//            return UIImage.serverError
//        } else if self.isExpired {
//            return UIImage.expireError
//        }
//        return nil
//    }
//}

//extension LocalizedError {
//    public var errorDescription: String? {
//        "未知的错误"
//    }
//}

//public protocol TypedError : Error {
//
//    /// A localized message describing what error occurred.
//    var errorDescription: String? { get }
//
//    /// A localized message describing the reason for the failure.
//    var failureReason: String? { get }
//
//    /// A localized message describing how one might recover from the failure.
//    var recoverySuggestion: String? { get }
//
//    /// A localized message providing "help" text if the user requests help.
//    var helpAnchor: String? { get }
//}

//extension Error {
//
//    // YJX_TODO_ERROR
//    public var asSWError: DemoError {
//        if let compatible = self as? SWErrorCompatible {
//            return compatible.convert(self)
//        }
//        return DemoError.network(100, "aaaaaa")
//    }
//
//}
//
//public protocol SWErrorCompatible {
//
//    func convert(_ error: Error) -> DemoError
//
//}
