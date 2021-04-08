//
//  ErrorExt.swift
//  SWFrame
//
//  Created by liaoya on 2021/4/8.
//

import Foundation
import RxSwift
import Alamofire
import Moya

extension Error {
    
    public var asSWError: SWError {
        if let sw = self as? SWError {
            return sw
        }
        if let compatible = self as? SWCompatibleError {
            return compatible.swError
        }
        return .server(0, nil)
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
            return .networkUnreachable
        } else {
            if self.code == 500 {
                return .server(0, nil)
            } else if self.code == 401 {
                return .userLoginExpired
            }
        }
        return .server(0, self.localizedDescription)
    }
}

extension AFError: SWCompatibleError {
    public var swError: SWError {
        switch self {
        case .sessionTaskFailed:
            return .networkUnreachable
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
        default:
            return .server(0, self.localizedDescription)
        }
    }
}
