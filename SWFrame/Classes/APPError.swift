//
//  XYError.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/11.
//

import UIKit
import RxSwift
import Moya

//public protocol APPErrorCompatible {
//    var asAPPError: APPError { get }
//}

public enum APPError: Error {
    case network
    case expired
    case server(Int, String?)
    case illegal(Int, String?)
}

extension APPError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .network:
            return NSLocalizedString("Error.Network.Message", comment: "")
        case .expired:
            return NSLocalizedString("Error.Expired.Message", comment: "")
        case let .server(_, message):
            return message ?? NSLocalizedString("Error.Server.Title", comment: "")
        case let .illegal(_, message):
            return message ?? NSLocalizedString("Error.Illegal.Title", comment: "")
        }
    }
}

extension APPError: Equatable {
    public static func == (lhs: APPError, rhs: APPError) -> Bool {
        switch (lhs, rhs) {
        case (.network, .network), (.expired, .expired):
            return true
        case let (.server(code1, message1), .server(code2, message2)):
            return code1 == code2 && message1 == message2
        case let (.illegal(code1, message1), .illegal(code2, message2)):
            return code1 == code2 && message1 == message2
        default:
            return false
        }
    }
}

