//
//  Error+Ex.swift
//  SWFrame
//
//  Created by liaoya on 2021/4/8.
//

import Foundation
import RxSwift
import RxOptional
import Alamofire
import SwifterSwift
import Moya
import SafariServices

extension Error {
    
    public var asSWFError: SWFError {
        if let sw = self as? SWFError {
            return sw
        }
        if let compatible = self as? SWFCompatibleError {
            return compatible.swfError
        }
        return .server(0, self.localizedDescription)
    }
    
}

public protocol SWFCompatibleError: Error {
    var swfError: SWFError { get }
}

extension SWFCompatibleError {
    public var swfError: SWFError {
        .server(0, nil)
    }
}

extension NSError: SWFCompatibleError {
    public var swfError: SWFError {
        if self.domain == SFAuthenticationError.errorDomain {
            if let compatible = self as? SFAuthenticationError as? SWFCompatibleError {
                return compatible.swfError
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

extension AFError: SWFCompatibleError {
    public var swfError: SWFError {
        switch self {
        case .sessionTaskFailed:
            return .network
        default:
            return .server(0, self.localizedDescription)
        }
    }
}

extension MoyaError: SWFCompatibleError {
    public var swfError: SWFError {
        switch self {
        case let .underlying(error, _):
            return (error as? SWFCompatibleError)?.swfError ?? .server(0, error.localizedDescription)
        case let .statusCode(response):
            if response.statusCode == HTTPStatusCode.Client.unauthorized.rawValue {
                return .notLoginedIn
            }
            return .server(0, response.data.string(encoding: .utf8))
        default:
            return .server(0, self.localizedDescription)
        }
    }
}

extension RxOptionalError: SWFCompatibleError {
    public var swfError: SWFError {
        switch self {
        case .emptyOccupiable: return .listIsEmpty
        case .foundNilWhileUnwrappingOptional: return .dataFormat
        }
    }
}
