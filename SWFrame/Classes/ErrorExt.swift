//
//  ErrorExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/11.
//

import UIKit
import RxSwift
import Moya

public enum SFError: Error {
    case network
    case server(String?)
    case expired
    case illegal(String?)
}

public extension Error {
    
    var isNetwork: Bool {
        return ((self as NSError).code == (SFError.network as NSError).code && (self as NSError).domain.contains(".APPError")) || ((self as NSError).domain == NSURLErrorDomain)
    }

    var isServer: Bool {
        return ((self as NSError).code == (SFError.server(nil) as NSError).code && (self as NSError).domain.contains(".APPError")) || ((self as NSError).code == 500)
    }

    var isExpired: Bool {
        return ((self as NSError).code == (SFError.expired as NSError).code && (self as NSError).domain.contains(".APPError")) || ((self as NSError).code == 401)
    }

    var isIllegal: Bool {
        return ((self as NSError).code == (SFError.illegal(nil) as NSError).code && (self as NSError).domain.contains(".APPError"))
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

//public enum AppError: Error {
//    case network
//    case server
//    case empty
//    case expire
//    case timeout
//    case underlying(Error)
//
//    public struct Code {
//        public static let Success   = 200
//        public static let Expire    = 401
//    }
//
//    public var image: UIImage {
//        switch self {
//        case .network:
//            return .networkError
//        case .server:
//            return .serverError
//        case .empty:
//            return .emptyError
//        case .expire:
//            return .expireError
//        case .timeout:
//            return .expireError
//        case .underlying:
//            return .serverError
//        }
//    }
//
//    public var title: String {
//        switch self {
//        case .network:
//            return NSLocalizedString("Error.Network.Title", comment: "")
//        case .server:
//            return NSLocalizedString("Error.Server.Title", comment: "")
//        case .empty:
//            return NSLocalizedString("Error.Empty.Title", comment: "")
//        case .expire:
//            return NSLocalizedString("Error.Expire.Title", comment: "")
//        case .timeout:
//            return NSLocalizedString("Error.Expire.Title", comment: "")
//        case .underlying:
//            return NSLocalizedString("Error.Server.Title", comment: "")
//        }
//    }
//
//    public var message: String {
//        switch self {
//        case .network:
//            return NSLocalizedString("Error.Network.Message", comment: "")
//        case .server:
//            return NSLocalizedString("Error.Server.Message", comment: "")
//        case .empty:
//            return NSLocalizedString("Error.Empty.Message", comment: "")
//        case .timeout:
//            return NSLocalizedString("Error.Expire.Message", comment: "")
//        case .expire:
//            return NSLocalizedString("Error.Expire.Message", comment: "")
//        case .underlying(let error):
//            return error.localizedDescription
//        }
//    }
//
//    public var retryTitle: String {
//        return NSLocalizedString("Error.Retry", comment: "")
//    }
//
//}
//
//public extension Error {
//
//    public var asAppError: AppError {
//        if let appError = self as? AppError {
//            return appError
//        }
//
//        if let error = self as? RxError {
//            switch error {
//            case .timeout:
//                return .timeout
//            default:
//                return .underlying(self)
//            }
//        }
//
//        if let error = self as? MoyaError {
//            switch error {
//            case let .underlying(error, response):
//                if (error as NSError).isNetwork {
//                    return .network
//                } else if (error as NSError).isExpire {
//                    return .expire
//                }
//                return .server
//            default:
//                return .server
//            }
//        }
//
//        return .underlying(self)
//    }
//}
