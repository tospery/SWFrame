//
//  LoggerEvent.swift
//  SWFrame
//
//  Created by liaoya on 2020/6/19.
//

//import UIKit
//import Umbrella
//
//public let journal = Analytics<LoggerEvent>()
//
//public enum LoggerEvent {
//    case verbose(_ message: Any)
//    case debug(_ message: Any)
//    case info(_ message: Any)
//    case warning(_ message: Any)
//    case error(_ message: Any)
//    
//    public static let messageKey = "Logger.Message"
//}
//
//extension LoggerEvent: Umbrella.EventType {
//    public func name(for provider: Umbrella.ProviderType) -> String? {
//        switch self {
//        case .verbose: return "0"
//        case .debug: return "1"
//        case .info: return "2"
//        case .warning: return "3"
//        case .error: return "4"
//        }
//    }
//
//    public func parameters(for provider: Umbrella.ProviderType) -> [String : Any]? {
//        switch self {
//        case .verbose(let message),
//             .debug(let message),
//             .info(let message),
//             .warning(let message),
//             .error(let message):
//            return [LoggerEvent.messageKey: message]
//        }
//    }
//}
