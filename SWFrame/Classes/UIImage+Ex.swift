//
//  UIImage+Ex.swift
//  Pods
//
//  Created by 杨建祥 on 2020/4/8.
//

import UIKit
import QMUIKit

public extension UIImage {
    
    fileprivate class func image(name: String) -> UIImage {
        var image = UIImage(named: name, in: Bundle.main, compatibleWith: nil)
        if image == nil {
            var bundle = Bundle(for: BaseView.self)
            if let path = bundle.path(forResource: "SWFrame", ofType: "bundle") {
                bundle = Bundle(path: path)!
            }
            image = UIImage(named: name, in: bundle, compatibleWith: nil)
            if image == nil {
                if let path = bundle.path(forResource: "\(name)@2x", ofType: "png") {
                    image = .init(contentsOfFile: path)
                }
            }
        }
        return image!
    }
    
    static var back: UIImage {
        return self.image(name: "back")
    }
    
    static var close: UIImage {
        return self.image(name: "close")
    }
    
    static var indicator: UIImage {
        return self.image(name: "indicator")
    }
    
    static var loading: UIImage {
        return self.image(name: "loading")
    }
    
    static var waiting: UIImage {
        return self.image(name: "waiting")
    }
    
    static var networkError: UIImage {
        return self.image(name: "errorNetwork")
    }
    
    static var serverError: UIImage {
        return self.image(name: "errorServer")
    }
    
    static var emptyError: UIImage {
        return self.image(name: "errorEmpty")
    }
    
    static var expireError: UIImage {
        return self.image(name: "errorExpire")
    }
    
}
