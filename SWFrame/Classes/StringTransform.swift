//
//  StringTransform.swift
//  iOSFrame
//
//  Created by 杨建祥 on 2020/5/16.
//

import UIKit
import QMUIKit
import ObjectMapper
import SwifterSwift

public class StringTransform: TransformType {

    public typealias Object = String
    public typealias JSON = Any
    
    var isNumber = false
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> String? {
        self.isNumber = value is Int
        return String(any: value)
    }

    public func transformToJSON(_ value: String?) -> Any? {
        return self.isNumber ? value?.int : value
    }
    
}

public class IntTransform: TransformType {

    public typealias Object = Int
    public typealias JSON = Any
    
    var isString = false
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> Int? {
        self.isString = value is String
        return Int(any: value)
    }

    public func transformToJSON(_ value: Int?) -> Any? {
        return self.isString ? value?.string : value
    }
    
}
