//
//  Library.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/27.
//

import UIKit
import Toast_Swift
import SwiftyBeaver

public let log = SwiftyBeaver.self

open class Library {
    
    open class func setup() {
        self.setupSwiftyBeaver()
        self.setupToast()
    }
    
    open class func setupSwiftyBeaver() {
        log.addDestination(ConsoleDestination())
        log.addDestination(FileDestination())
    }

    open class func setupToast() {
        ToastManager.shared.position = .center
        ToastManager.shared.isQueueEnabled = true
    }

}

