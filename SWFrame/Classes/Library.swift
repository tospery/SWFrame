//
//  Library.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/27.
//

import UIKit
import SwiftyBeaver

public let log = SwiftyBeaver.self

open class Library {
    
    open class func setup() {
        self.setupSwiftyBeaver()
    }
    
    open class func setupSwiftyBeaver() {
        let console = ConsoleDestination()
        console.format = "$DHH:mm:ss$d $L $M"
        log.addDestination(console)
        
        let file = FileDestination()
        log.addDestination(file)
        
        let cloud = SBPlatformDestination(appID: "B1QMr6", appSecret: "t2isobttbqmdlrGqTgymbmxcnprqgwpi", encryptionKey: "sS1kcjrPbbdFnttbbdhnscvu3sy9zopg")
        log.addDestination(cloud)
    }
    
}

