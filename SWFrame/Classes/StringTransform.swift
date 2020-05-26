//
//  StringTransform.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/5/16.
//

import UIKit
import QMUIKit
import ObjectMapper

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
