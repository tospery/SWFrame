//
//  StringTransform.swift
//  SWFrame
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
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> String? {
        if let bool = value as? Bool {
            return bool.string
        } else if let int = value as? Int {
            return int.string
        } else if let string = value as? String {
            return string
        } else {
            return nil
        }
    }

    public func transformToJSON(_ value: String?) -> Any? {
        return value
    }
    
}

public class IntTransform: TransformType {

    public typealias Object = Int
    public typealias JSON = Any
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> Int? {
        if let bool = value as? Bool {
            return bool.int
        } else if let int = value as? Int {
            return int
        } else if let string = value as? String {
            return string.int
        } else {
            return nil
        }
    }

    public func transformToJSON(_ value: Int?) -> Any? {
        return value
    }
    
}

public class BoolTransform: TransformType {

    public typealias Object = Bool
    public typealias JSON = Any
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> Bool? {
        if let bool = value as? Bool {
            return bool
        } else if let int = value as? Int {
            return int.bool
        } else if let string = value as? String {
            return string.bool
        } else {
            return nil
        }
    }

    public func transformToJSON(_ value: Bool?) -> Any? {
        return value
    }
    
}
