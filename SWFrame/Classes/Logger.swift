//
//  Logger.swift
//  SWFrame
//
//  Created by liaoya on 2021/3/9.
//

import Foundation
import CocoaLumberjack

public let logger = Logger.init()

public protocol LoggerCompatible {
    
    func print(
        _ message: @autoclosure () -> Any,
        module: String,
        level: DDLogLevel,
        flag: DDLogFlag,
        context: Int,
        file: StaticString,
        function: StaticString,
        line: UInt,
        tag: Any?,
        asynchronous async: Bool,
        ddlog: DDLog
    )
    
}

public struct Logger {

    public init() {
    }
    
    public func print(
        _ message: @autoclosure () -> Any,
        module: String = "Common",
        level: DDLogLevel = DDDefaultLogLevel,
        flag: DDLogFlag = .debug,
        context: Int = 0,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line,
        tag: Any? = nil,
        asynchronous async: Bool = asyncLoggingEnabled,
        ddlog: DDLog = .sharedInstance
    ) {
        if let compatible = self as? LoggerCompatible {
            compatible.print(
                message(),
                module: module,
                level: level,
                flag: flag,
                context: context,
                file: file,
                function: function,
                line: line,
                tag: tag,
                asynchronous: async,
                ddlog: ddlog
            )
        } else {
            _DDLogMessage(
                "【\(module)】\(message())",
                level: level,
                flag: flag,
                context: context,
                file: file,
                function: function,
                line: line,
                tag: tag,
                asynchronous: async,
                ddlog: ddlog
            )
        }
    }

}

