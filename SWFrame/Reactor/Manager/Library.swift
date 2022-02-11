//
//  Library.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/27.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyBeaver

open class Library {
    
    open class func setup() {
        self.setupReachability()
        self.setupSwiftyBeaver()
    }
    
    open class func setupReachability() {
        ReachManager.shared.start()
    }

    open class func setupSwiftyBeaver() {
        sblog.addDestination(ConsoleDestination.init())
        sblog.addDestination(FileDestination.init())
    }
    
}

