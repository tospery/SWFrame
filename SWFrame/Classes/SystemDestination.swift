//
//  SystemDestination.swift
//  iOSFrame
//
//  Created by liaoya on 2020/7/8.
//

//import os
//import Foundation
//import SwiftyBeaver
//
//public class SystemDestination: BaseDestination {
//
//    public override init() {
//        super.init()
//        levelColor.verbose = "💜 "     // silver
//        levelColor.debug = "💚 "        // green
//        levelColor.info = "💙 "         // blue
//        levelColor.warning = "💛 "     // yellow
//        levelColor.error = "❤️ "       // red
//    }
//
//    // print to Xcode Console. uses full base class functionality
//    override public func send(_ level: SwiftyBeaver.Level, msg: String, thread: String,
//                                file: String, function: String, line: Int, context: Any? = nil) -> String? {
//        let formattedString = super.send(level, msg: msg, thread: thread, file: file, function: function, line: line, context: context)
//
//        if let str = formattedString {
//            os_log("%{public}s", str)
//        }
//        return formattedString
//    }
//
//}

