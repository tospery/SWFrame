//
//  Runtime.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/7.
//

import UIKit
import QMUIKit

open class Runtime {

    open class func work() {
        ExchangeImplementations(UIViewController.self, #selector(UIViewController.present(_:animated:completion:)), #selector(UIViewController.sf_present(_:animated:completion:)))
    }
    
}
