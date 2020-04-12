//
//  UIImageExt.swift
//  Pods
//
//  Created by 杨建祥 on 2020/4/8.
//

import UIKit

public extension UIImage {
    
    fileprivate class func resource() -> Bundle? {
        return Bundle(path: Bundle(module: "SwiftFrame")!.path(forResource: "SwiftFrame", ofType: "bundle")!)
    }
    
    static var back: UIImage {
        return UIImage(named: "back", in: self.resource(), compatibleWith: nil)!
    }
    
    static var close: UIImage {
        return UIImage(named: "close", in: self.resource(), compatibleWith: nil)!
    }
    
    static var indicator: UIImage {
        return UIImage(named: "indicator", in: self.resource(), compatibleWith: nil)!
    }
    
    static var loading: UIImage {
        return UIImage(named: "loading", in: self.resource(), compatibleWith: nil)!
    }
    
    static var waiting: UIImage {
        return UIImage(named: "waiting", in: self.resource(), compatibleWith: nil)!
    }
    
    static var networkError: UIImage {
        return UIImage(named: "errorNetwork", in: self.resource(), compatibleWith: nil)!
    }
    
    static var serverError: UIImage {
        return UIImage(named: "errorServer", in: self.resource(), compatibleWith: nil)!
    }
    
}
