//
//  NSObjectExtensions.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation

public extension NSObject {
    
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    
}
