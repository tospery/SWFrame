//
//  Logger.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation
import SwiftyBeaver

public let logType = SwiftyBeaver.self
public let logger = Logger.init()

public protocol LoggerCompatible {
    
    func print(
        _ message: @autoclosure () -> Any,
        module: Logger.Module,
        level: SwiftyBeaver.Level,
        file: String,
        function: String,
        line: Int,
        context: Any?
    )
    
}

public struct Logger {

    public typealias Module = String
    
    public init() {
    }
    
    public func print(
        _ message: @autoclosure () -> Any,
        module: Module = .common,
        level: SwiftyBeaver.Level = .debug,
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        context: Any? = nil
    ) {
        if let compatible = self as? LoggerCompatible {
            compatible.print(
                message(),
                module: module,
                level: level,
                file: file,
                function: function,
                line: line,
                context: context
            )
        } else {
            logType.custom(
                level: level,
                message: "【\(module)】\(message())",
                file: file,
                function: function,
                line: line,
                context: context
            )
        }
    }

}

extension Logger.Module {
    
    public static var common: Logger.Module { "common" }
    public static var swframe: Logger.Module { "swframe" }
    public static var library: Logger.Module { "library" }
    public static var restful: Logger.Module { "restful" }
    
}

