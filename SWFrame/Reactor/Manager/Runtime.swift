//
//  Runtime.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/7.
//

import UIKit

public protocol RuntimeCompatible {
    func myWork()
}

final public class Runtime {

    public static var shared = Runtime()
    
    public init() {
    }
    
    public func work() {
        ExchangeImplementations(UIViewController.self, #selector(UIViewController.present(_:animated:completion:)), #selector(UIViewController.swf_present(_:animated:completion:)))
        if let compatible = self as? RuntimeCompatible {
            compatible.myWork()
        }
    }
    
}
