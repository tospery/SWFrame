//
//  NSObjectExt.swift
//  iOSFrame
//
//  Created by 杨建祥 on 2020/4/25.
//

import UIKit

public extension NSObject {
    
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    
}
