//
//  Error+Ex.swift
//  SWFrame
//
//  Created by liaoya on 2021/4/8.
//

import Foundation
import RxSwift
import Alamofire
import SwifterSwift
import Moya
import SafariServices
import StoreKit

extension SWError {

    public var displayImage: UIImage? {
        switch self {
        case .networkNotConnected, .networkNotReachable: return UIImage.networkError
        case .server: return UIImage.serverError
        case .listIsEmpty: return UIImage.emptyError
        case .userLoginExpired: return UIImage.expireError
        default: return nil
        }
    }
    
}

extension NSError: SWErrorCompatible {
    public var swError: SWError {
        if self.domain == SFAuthenticationError.errorDomain {
            if let compatible = self as? SFAuthenticationError as? SWErrorCompatible {
                return compatible.swError
            }
        }
        if self.domain == SKError.errorDomain {
            if let compatible = self as? SKError as? SWErrorCompatible {
                return compatible.swError
            }
        }
        if self.domain == NSURLErrorDomain {
            // NSURLErrorDomain Code=-1020 "目前不允许数据连接。"
            // NSURLErrorCannotConnectToHost        -1004       无法连接服务器
            if self.code >= NSURLErrorNetworkConnectionLost &&
                self.code <= NSURLErrorCancelled {
                return .server(ErrorCode.serverUnableConnect, self.localizedDescription)
            } else if self.code >= NSURLErrorCannotParseResponse ||
                        self.code <= NSURLErrorDNSLookupFailed {
                return .server(ErrorCode.serverNoResponse, self.localizedDescription)
            }
            return .networkNotConnected
        } else {
            if self.code == 500 {
                return .server(ErrorCode.serverInternalError, self.localizedDescription)
            } else if self.code == 401 {
                return .userLoginExpired
            }
        }
        return .server(ErrorCode.nserror, self.localizedDescription)
    }
}

extension SKError: SWErrorCompatible {
    public var swError: SWError {
        switch self.code {
        case .paymentCancelled:
            return .none
        default:
            return .app(ErrorCode.skerror, self.localizedDescription)
        }
    }
}

extension RxError: SWErrorCompatible {
    public var swError: SWError {
        switch self {
        case .unknown: return .unknown
        case .timeout: return .timeout
        default: return .app(ErrorCode.rxerror, self.localizedDescription)
        }
    }
}

extension AFError: SWErrorCompatible {
    public var swError: SWError {
        switch self {
        case let .sessionTaskFailed(error):
            return error.asSWError
        default:
            return .server(ErrorCode.aferror, self.localizedDescription)
        }
    }
}

extension MoyaError: SWErrorCompatible {
    public var swError: SWError {
        switch self {
        case let .underlying(error, _):
            return (error as? SWErrorCompatible)?.swError ?? .server(0, error.localizedDescription)
        case let .statusCode(response):
            if response.statusCode == 401 {
                return .userLoginExpired
            }
            return .server(ErrorCode.moyaError, response.data.string(encoding: .utf8))
        case let .jsonMapping(response):
            return .server(ErrorCode.moyaError, self.localizedDescription)
        default:
            return .server(ErrorCode.moyaError, self.localizedDescription)
        }
    }
}
