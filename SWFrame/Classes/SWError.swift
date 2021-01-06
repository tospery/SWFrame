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
    case network(Int, String?)  // 100~199
    case server(Int, String?)   // 200~299
    case user(Int, String?)     // 300~399
    case app(Int, String?)      // 400~499
    
    public static let NetworkUnreachableCode    = 101
    public static let UserNotLoginCode          = 301
    public static let UserExpiredCode           = 302
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

public extension Error {
    var isNetwork: Bool {
        if let error = self as? SWError {
            switch error {
            case .network: return true
            default: return false
            }
        }
        if (self as NSError).domain == NSURLErrorDomain {
            return true
        }
        if let error = self as? APPError, error == .network {
            return true
        }
        return false
    }

    var isServer: Bool {
        if let error = self as? SWError {
            switch error {
            case .server: return true
            default: return false
            }
        }
        if (self as NSError).code == 500 {
            return true
        }
        if let error = self as? APPError {
            switch error {
            case .server:
                return true
            default:
                return false
            }
        }
        return false
    }

    var isExpired: Bool {
        if let error = self as? SWError {
            switch error {
            case let .user(302, _): return true
            default: return false
            }
        }
        if (self as NSError).code == 401 {
            return true
        }
        if let error = self as? APPError, error == .expired {
            return true
        }
        return false
    }

    var isIllegal: Bool {
        if let error = self as? APPError {
            switch error {
            case .illegal:
                return true
            default:
                return false
            }
        }
        return false
    }

    var title: String? {
        if self.isNetwork {
            return NSLocalizedString("Error.Network.Title", comment: "")
        } else if self.isServer {
            return NSLocalizedString("Error.Server.Title", comment: "")
        } else if self.isExpired {
            return NSLocalizedString("Error.Expired.Title", comment: "")
        }
        return nil
    }

    var message: String {
        if self.isNetwork {
            return NSLocalizedString("Error.Network.Message", comment: "")
        } else if self.isServer {
            return NSLocalizedString("Error.Server.Message", comment: "")
        } else if self.isExpired {
            return NSLocalizedString("Error.Expired.Message", comment: "")
        }
        return self.localizedDescription
    }

    var retry: String? {
        return NSLocalizedString("Error.Retry", comment: "")
    }

    var image: UIImage? {
        if self.isNetwork {
            return UIImage.networkError
        } else if self.isServer {
            return UIImage.serverError
        } else if self.isExpired {
            return UIImage.expireError
        }
        return nil
    }
}

//extension Error {
//
//    // YJX_TODO_ERROR
//    public var asSWError: SWError {
//        if let compatible = self as? SWErrorCompatible {
//            return compatible.convert(self)
//        }
//        return SWError.network(100, "aaaaaa")
//    }
//
//}
//
//public protocol SWErrorCompatible {
//
//    func convert(_ error: Error) -> SWError
//
//}
