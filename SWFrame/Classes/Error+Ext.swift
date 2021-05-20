//
//  Error+Ext.swift
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

extension Error {
    
    public var asSWError: SWError {
        if let sw = self as? SWError {
            return sw
        }
        if let compatible = self as? SWCompatibleError {
            return compatible.swError
        }
        return .server(0, self.localizedDescription)
    }
    
}

public protocol SWCompatibleError: Error {
    var swError: SWError { get }
}

extension SWCompatibleError {
    public var swError: SWError {
        .server(0, nil)
    }
}

extension NSError: SWCompatibleError {
    public var swError: SWError {
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

extension AFError: SWCompatibleError {
    public var swError: SWError {
        switch self {
        case .sessionTaskFailed:
            return .network
        default:
            return .server(0, self.localizedDescription)
        }
    }
}

extension MoyaError: SWCompatibleError {
    public var swError: SWError {
        switch self {
        case let .underlying(error, _):
            return (error as? SWCompatibleError)?.swError ?? .server(0, error.localizedDescription)
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

extension RxOptionalError: SWCompatibleError {
    public var swError: SWError {
        switch self {
        case .emptyOccupiable: return .listIsEmpty
        case .foundNilWhileUnwrappingOptional: return .dataFormat
        }
    }
}
