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
        case .network: return UIImage.networkError
        case .server: return UIImage.serverError
        case .listIsEmpty: return UIImage.emptyError
        case .loginExpired: return UIImage.expireError
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
            return .network
        } else {
            if self.code == 500 {
                return .server(0, self.localizedDescription)
            } else if self.code == 401 {
                return .loginExpired
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
            if response.statusCode == 401 {
                return .loginExpired
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
