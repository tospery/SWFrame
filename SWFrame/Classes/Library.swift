//
//  Library.swift
//  iOSFrame
//
//  Created by 杨建祥 on 2020/4/27.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa
//import SwiftyBeaver

//public let log = SwiftyBeaver.self

open class Library {
    
    open class func setup() {
        self.setupReachability()
        //self.setupSwiftyBeaver()
    }
    
    open class func setupReachability() {
        ReachabilityManager.shared.start()
    }

//    open class func setupSwiftyBeaver() {
//        log.addDestination(ConsoleDestination.init())
//        log.addDestination(FileDestination.init())
//    }
    
}

