//
//  DispatchQueue+Core.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/16.
//

import Foundation

public extension DispatchQueue {
    private static var _onceTracker = [String]()

    class func once(file: String = #file, function: String = #function, line: Int = #line, block:()->Void) {
        let token = file + ":" + function + ":" + String(line)
        once(token: token, block: block)
    }
    
    class func once(token: String, block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }

        if _onceTracker.contains(token) {
            return
        }

        _onceTracker.append(token)
        block()
    }
    
}
