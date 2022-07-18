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

            // NSURLErrorUnknown                        -1
            // NSURLErrorCancelled                      -999
            // NSURLErrorBadURL                         -1000
            // NSURLErrorTimedOut                       -1001(请求超时)
            // NSURLErrorUnsupportedURL                 -1002
            // NSURLErrorCannotFindHost                 -1003
            // NSURLErrorCannotConnectToHost            -1004(无法连接服务器)
            // NSURLErrorNetworkConnectionLost          -1005
            // NSURLErrorDNSLookupFailed                -1006
            // NSURLErrorHTTPTooManyRedirects           -1007
            // NSURLErrorResourceUnavailable            -1008
            // NSURLErrorNotConnectedToInternet         -1009
            // NSURLErrorRedirectToNonExistentLocation  -1010
            // NSURLErrorBadServerResponse              -1011
            // NSURLErrorUserCancelledAuthentication    -1012
            // NSURLErrorUserAuthenticationRequired     -1013
            // NSURLErrorZeroByteResource               -1014
            // NSURLErrorCannotDecodeRawData            -1015
            // NSURLErrorCannotDecodeContentData        -1016
            // NSURLErrorCannotParseResponse            -1017
            // logger.print("看看错误码: \(NSURLErrorFileDoesNotExist)")

            if self.code == -1020 {
                return .networkNotConnected
            }
            if self.code >= NSURLErrorNetworkConnectionLost &&
                self.code <= NSURLErrorCancelled {
                return .server(ErrorCode.serverUnableConnect, self.localizedDescription, nil)
            }
//            if self.code >= NSURLErrorDNSLookupFailed ||
//                        self.code <= NSURLErrorCannotParseResponse {
//                return .server(ErrorCode.serverNoResponse, self.localizedDescription)
//            }
            return .networkNotConnected
        } else {
            if self.code == 500 {
                return .server(ErrorCode.serverInternalError, self.localizedDescription, nil)
            } else if self.code == 401 {
                return .userLoginExpired
            }
        }
        return .server(ErrorCode.nserror, self.localizedDescription, nil)
    }
}

extension SKError: SWErrorCompatible {
    public var swError: SWError {
        switch self.code {
        case .paymentCancelled:
            return .none
        default:
            return .app(ErrorCode.skerror, self.localizedDescription, nil)
        }
    }
}

extension RxError: SWErrorCompatible {
    public var swError: SWError {
        switch self {
        case .unknown: return .unknown
        case .timeout: return .timeout
        default: return .app(ErrorCode.rxerror, self.localizedDescription, nil)
        }
    }
}

extension AFError: SWErrorCompatible {
    public var swError: SWError {
        switch self {
        case .explicitlyCancelled:
            return .timeout
        case let .sessionTaskFailed(error):
            return error.asSWError
        default:
            return .server(ErrorCode.aferror, self.localizedDescription, nil)
        }
    }
}

extension MoyaError: SWErrorCompatible {
    public var swError: SWError {
        switch self {
        case let .underlying(error, _):
            return (error as? SWErrorCompatible)?.swError ?? .server(0, error.localizedDescription, nil)
        case let .statusCode(response):
            if response.statusCode == 401 {
                return .userLoginExpired
            }
            return .server(ErrorCode.moyaError, response.data.string(encoding: .utf8), nil)
        case let .jsonMapping(response):
            return .server(ErrorCode.moyaError, self.localizedDescription, nil)
        default:
            return .server(ErrorCode.moyaError, self.localizedDescription, nil)
        }
    }
}
