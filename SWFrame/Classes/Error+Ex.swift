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
            return .network
        } else {
            if self.code == HTTPStatusCode.Server.internalServerError.rawValue {
                return .server(0, self.localizedDescription)
            } else if self.code == HTTPStatusCode.Client.unauthorized.rawValue {
                return .notLoginedIn
            }
        }
        return .server(0, self.localizedDescription)
    }
}

extension AFError: SWErrorCompatible {
    public var swError: SWError {
        switch self {
        case .sessionTaskFailed:
            return .network
        default:
            return .server(0, self.localizedDescription)
        }
    }
}

extension MoyaError: SWErrorCompatible {
    public var swError: SWError {
        switch self {
        case let .underlying(error, _):
            return (error as? SWErrorCompatible)?.swError ?? .server(0, error.localizedDescription)
        case let .statusCode(response):
            if response.statusCode == HTTPStatusCode.Client.unauthorized.rawValue {
                return .notLoginedIn
            }
            return .server(0, response.data.string(encoding: .utf8))
        case let .jsonMapping(response):
            return .server(response.statusCode, self.localizedDescription)
        default:
            return .server(0, self.localizedDescription)
        }
    }
}

extension SKError: SWErrorCompatible {
    public var swError: SWError {
        switch self.code {
        case .paymentCancelled:
            return .cancel
        default:
            return .app(0, self.localizedDescription)
        }
    }
}
