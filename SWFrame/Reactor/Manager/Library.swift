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

public protocol LibraryCompatible {
    func mySetup()
}

final public class Library {
    
    public static var shared = Library()
    
    public init() {
    }
    
    public func setup() {
        self.setupReachability()
        self.setupSwiftyBeaver()
        if let compatible = self as? LibraryCompatible {
            compatible.mySetup()
        }
    }
    
    func setupReachability() {
        ReachManager.shared.start()
    }

    func setupSwiftyBeaver() {
        sblog.addDestination(ConsoleDestination.init())
        sblog.addDestination(FileDestination.init())
    }
    
}

